<?php

namespace App\Http\Controllers\Admin;

use App\Constants\ManageStatus;
use App\Http\Controllers\Controller;
use App\Models\Admin;
use App\Models\AdminNotification;
use App\Models\Company;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules\File;
use Illuminate\Validation\Rules\Password;

class AdminController extends Controller
{
    function dashboard() {
        $pageTitle       = 'Dashboard';
        $latestUsers     = User::active()->latest()->limit(6)->get();
        $latestCompanies = Company::active()->latest()->limit(7)->get();
        $admin           = Admin::first();
        $passwordAlert   = false;

        if (Hash::check('admin', $admin->password) || $admin->username == 'admin') {
            $passwordAlert = true;
        }

        $widget = [
            //User Info
            'totalUsers'             => User::count(),
            'activeUsers'            => User::active()->count(),
            'emailUnconfirmedUsers'  => User::emailUnconfirmed()->count(),
            'mobileUnconfirmedUsers' => User::mobileUnconfirmed()->count(),

            // Company Info
            'totalCompanies'    => Company::count(),
            'approvedCompanies' => Company::active()->count(),
            'pendingCompanies'  => Company::pending()->count(),
            'rejectedCompanies' => Company::reject()->count()
        ];

        return view('admin.page.dashboard', compact('pageTitle', 'widget', 'latestUsers', 'passwordAlert', 'latestCompanies'));
    }

    function profile() {
        $pageTitle = 'Profile';
        $admin     = auth('admin')->user();
        return view('admin.page.profile', compact('pageTitle', 'admin'));
    }

    function profileUpdate() {
        $this->validate(request(), [
            'name'     => 'required|max:40',
            'email'    => 'required|email|max:40',
            'username' => 'required|max:40',
            'contact'  => 'required|max:40',
            'address'  => 'required|max:255',
            'image'    => [File::types(['png', 'jpg', 'jpeg'])],
        ]);

        $admin = auth('admin')->user();

        if (request()->hasFile('image')) {
            try {
                $old          = $admin->image;
                $admin->image = fileUploader(request('image'), getFilePath('adminProfile'), getFileSize('adminProfile'), $old);
            } catch (\Exception $exp) {
                $toast[] = ['error', 'Image upload failed'];
                return back()->withToasts($toast);
            }
        }

        $admin->name     = request('name');
        $admin->email    = request('email');
        $admin->username = request('username');
        $admin->contact  = request('contact');
        $admin->address  = request('address');
        $admin->save();

        $toast[] = ['success', 'Profile update success'];
        return back()->withToasts($toast);
    }

    function passwordChange() {
        $passwordValidation = Password::min(6);

        if (bs('strong_pass')) {
            $passwordValidation = $passwordValidation->mixedCase()->numbers()->symbols()->uncompromised();
        }

        $this->validate(request(), [
            'current_password' => 'required',
            'password'         => ['required', 'confirmed', $passwordValidation],
        ]);

        $admin = auth('admin')->user();

        if (!Hash::check(request('current_password'), $admin->password)) {
            $toast[] = ['error', 'Current password mismatched !!'];
            return back()->withToasts($toast);
        }

        $admin->password = Hash::make(request('password'));
        $admin->save();

        $toast[] = ['success', 'Password change success'];
        return back()->withToasts($toast);
    }

    function notificationAll() {
        $notifications = AdminNotification::with('user')->orderBy('is_read')->paginate(getPaginate());
        $pageTitle     = 'Notifications';

        return view('admin.page.notification',compact('pageTitle','notifications'));
    }

    function notificationRead($id) {
        $notification = AdminNotification::findOrFail($id);
        $notification->is_read = ManageStatus::YES;
        $notification->save();

        $url = $notification->click_url;

        if ($url == '#') {
            $url = url()->previous();
        }

        return redirect($url);
    }

    function notificationReadAll() {
        AdminNotification::where('is_read', ManageStatus::NO)->update([
            'is_read'=>ManageStatus::YES
        ]);

        $toast[] = ['success', 'All notification marked as read success'];
        return back()->withToasts($toast);
    }

    function notificationRemove($id) {
        $notification = AdminNotification::findOrFail($id);
        $notification->delete();

        $toast[] = ['success', 'Notification removal success'];
        return back()->withToasts($toast);
    }

    function notificationRemoveAll(){
        AdminNotification::truncate();

        $toast[] = ['success', 'All notification remove success'];
        return back()->withToasts($toast);
    }

    function fileDownload() {
        $path = request('filePath');
        $file = fileManager()->$path()->path.'/'.request('fileName');
        
        return response()->download($file);
    }
}
