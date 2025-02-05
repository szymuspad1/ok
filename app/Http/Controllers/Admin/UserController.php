<?php

namespace App\Http\Controllers\Admin;

use App\Constants\ManageStatus;
use App\Http\Controllers\Controller;
use App\Models\Company;
use App\Models\Review;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    function index() {
        $pageTitle = 'All Users';
        $users     = $this->userData();

        return view('admin.user.index', compact('pageTitle', 'users'));
    }

    function active() {
        $pageTitle = 'Active Users';
        $users     = $this->userData('active');

        return view('admin.user.index', compact('pageTitle', 'users'));
    }

    function banned() {
        $pageTitle = 'Banned Users';
        $users     = $this->userData('banned');

        return view('admin.user.index', compact('pageTitle', 'users'));
    }

    function kycPending() {
        $pageTitle = 'KYC Pending Users';
        $users     = $this->userData('kycPending');

        return view('admin.user.index', compact('pageTitle', 'users'));
    }

    function kycUnConfirmed() {
        $pageTitle = 'KYC Unconfirmed Users';
        $users     = $this->userData('kycUnconfirmed');

        return view('admin.user.index', compact('pageTitle', 'users'));
    }

    function emailUnConfirmed() {
        $pageTitle = 'Email Unconfirmed Users';
        $users     = $this->userData('emailUnconfirmed');

        return view('admin.user.index', compact('pageTitle', 'users'));
    }

    function mobileUnConfirmed() {
        $pageTitle = 'Mobile Unconfirmed Users';
        $users     = $this->userData('mobileUnconfirmed');

        return view('admin.user.index', compact('pageTitle', 'users'));
    }

    function details($id) {
        $user                 = User::findOrFail($id);
        $pageTitle            = 'Details - ' .$user->username;
        $countries            = json_decode(file_get_contents(resource_path('views/partials/country.json')));
        $totalCompanies       = Company::where('user_id', $id);
        $totalCompanyCount    = (clone $totalCompanies)->count();
        $approvedCompanyCount = (clone $totalCompanies)->active()->count();
        $pendingCompanyCount  = (clone $totalCompanies)->pending()->count();
        $totalReviewCount     = Review::where('user_id', $id)->count();

        return view('admin.user.detail', compact('pageTitle', 'user', 'countries', 'totalCompanyCount', 'approvedCompanyCount', 'pendingCompanyCount', 'totalReviewCount'));
    }

    function update($id) {
        $user         = User::findOrFail($id);
        $countryData  = json_decode(file_get_contents(resource_path('views/partials/country.json')));
        $countryArray = (array)$countryData;
        $countries    = implode(',', array_keys($countryArray));
        $countryCode  = request('country');
        $country      = $countryData->$countryCode->country;
        $dialCode     = $countryData->$countryCode->dial_code;

        $this->validate(request(), [
            'firstname' => 'required|string|max:40',
            'lastname'  => 'required|string|max:40',
            'email'     => 'required|email|string|max:40|unique:users,email,' . $user->id,
            'mobile'    => 'required|string|max:40|unique:users,mobile,' . $user->id,
            'country'   => 'required|in:' . $countries,
        ]);

        $user->mobile       = $dialCode.request('mobile');
        $user->country_name = $country;
        $user->country_code = $countryCode;
        $user->firstname    = request('firstname');
        $user->lastname     = request('lastname');
        $user->email        = request('email');
        $user->ec           = request('ec') ? ManageStatus::VERIFIED : ManageStatus::UNVERIFIED;
        $user->sc           = request('sc') ? ManageStatus::VERIFIED : ManageStatus::UNVERIFIED;
        $user->ts           = request('ts') ? ManageStatus::ACTIVE   : ManageStatus::INACTIVE;
        $user->address      = [
                                'city'    => request('city'),
                                'state'   => request('state'),
                                'zip'     => request('zip'),
                                'country' => @$country,
                            ];
        if (!request('kc')) {
            $user->kc = ManageStatus::UNVERIFIED;

            if ($user->kyc_data) {
                foreach ($user->kyc_data as $kycData) {
                    if ($kycData->type == 'file') {
                        fileManager()->removeFile(getFilePath('verify').'/'.$kycData->value);
                    }
                }
            }

            $user->kyc_data = null;
        }else{
            $user->kc = ManageStatus::VERIFIED;
        }
        $user->save();

        $toast[] = ['success', 'User details updated success'];
        return back()->withToasts($toast);
    }

    function login($id) {
        Auth::loginUsingId($id);
        return to_route('user.home');
    }

    function status($id) {
        $user = User::findOrFail($id);

        if ($user->status == ManageStatus::ACTIVE) {
            $this->validate(request(), [
                'ban_reason'=>'required|string|max:255'
            ]);

            $user->status = ManageStatus::INACTIVE;
            $user->ban_reason = request('ban_reason');
            $toast[] = ['success','User ban success'];
        }else{
            $user->status = ManageStatus::ACTIVE;
            $user->ban_reason = null;
            $toast[] = ['success','User unbanned success'];
        }

        $user->save();

        return back()->withToasts($toast);
    }

    function kycApprove($id) {
        $user     = User::findOrFail($id);
        $user->kc = ManageStatus::VERIFIED;
        $user->save();

        notify($user, 'KYC_APPROVE', []);

        $toast[] = ['success', 'KYC approval success'];
        return back()->withToasts($toast);
    }

    function kycCancel($id) {
        $user           = User::findOrFail($id);

        foreach ($user->kyc_data as $kycData) {
            if ($kycData->type == 'file') {
                fileManager()->removeFile(getFilePath('verify').'/'.$kycData->value);
            }
        }

        $user->kc       = ManageStatus::UNVERIFIED;
        $user->kyc_data = null;
        $user->save();

        notify($user, 'KYC_REJECT', []);

        $toast[] = ['success', 'KYC cancellation success'];
        return back()->withToasts($toast);
    }

    protected function userData($scope = null){
        $users = $scope ? User::$scope() : User::query();
    
        return $users->searchable(['username', 'email'])->dateFilter()->latest()->paginate(getPaginate());
    }
}
