<?php

namespace App\Http\Controllers\Admin;

use App\Constants\ManageStatus;
use App\Http\Controllers\Controller;
use App\Lib\FormProcessor;
use App\Models\Company;
use App\Models\Form;
use App\Models\User;

class CompanyController extends Controller
{   
    function verification() {
        $pageTitle   = 'Verification Setting';
        $formHeading = 'Company Verification Information';
        $form        = Form::where('act', 'company_verification')->first();

        return view('admin.company.companyVerification', compact('pageTitle', 'formHeading', 'form'));
    }

    function verificationStore() {
        $formProcessor = new FormProcessor();
        $formProcessor->generate('company_verification', true);

        $toast[] = ['success', 'Verification setting upodate success'];
        return back()->withToasts($toast);
    }

    function index($userId = 0) {
        return $this->companyData('All Companies',$scope = null, $userId);
    }

    function pending($userId = 0) {
        return $this->companyData('Pending Companies', 'pending', $userId);
    }

    function approved($userId = 0) {
        return $this->companyData('Active Companies', 'active', $userId);
    }

    function rejected() {
        return $this->companyData('Rejected Companies', 'reject');
    }

    function reject() {

        $this->validate(request(), [
            'company_id'     => 'required|integer|gt:0',
            'action'         => 'required|in:reject',
            'admin_feedback' => 'required|string'
        ]);

        $company = Company::pending()->find(request('company_id'));

        if (!$company) {
            $toast[] = ['error', 'Company not found'];
            return back()->withToasts($toast);
        }
        
        $company->status         = ManageStatus::INACTIVE;
        $company->admin_feedback = request('admin_feedback');
        $company->save();

        $toast[] = ['success', $company->name . ' reject success'];
        return back()->withToasts($toast);

    }

    function approve($id) {
        $company = Company::pending()->find( $id);

        if (!$company) {
            $toast[] = ['error', 'Company not found'];
            return back()->withToasts($toast);
        }

        $company->status = ManageStatus::ACTIVE;
        $company->save();

        $toast[] = ['success', $company->name . ' approve success'];
        return back()->withToasts($toast);
    }

    protected function companyData($pageTitle, $scope=null, $userId=0) {
        $user = null;

        if ($userId) {
                $user = User::active()->where('id', $userId)->first();

                if (!$user) {
                    $toast[] = ['error', 'User not found'];
                    return back()->withToasts($toast)->throwResponse();
                }
        }
    
        $companies = $scope ? Company::$scope()->latest() : Company::latest();
        $companies = $companies->when($user, fn($query) => $query->where('user_id', $user->id))->with(['user', 'category'])->searchable(['name', 'user:username'])->paginate(getPaginate());

        return view('admin.company.index', compact('pageTitle', 'companies'));
    }
}
