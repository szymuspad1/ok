<?php

namespace App\Http\Controllers\User;

use App\Constants\ManageStatus;
use App\Http\Controllers\Controller;
use App\Lib\FormProcessor;
use App\Models\Category;
use App\Models\Company;
use App\Models\Form;
use Illuminate\Validation\Rules\File;


class CompanyController extends Controller
{
    function index(){
        $pageTitle = 'Your Companies';
        $subTitle  = 'Track Your Company\'s Performance and Growth';
        $companies = Company::where('user_id', auth()->id())->latest()->paginate(getPaginate());

        return view($this->activeTheme . 'user.company.index', compact('pageTitle', 'subTitle', 'companies'));
    }

    function add() {
        $pageTitle  = 'Add Companies';
        $subTitle   = 'Create and manage new company profiles easily';
        $title      = 'Provide Your Company Information';
        $route      = route('user.company.store');
        $categories = Category::active()->orderBy('name')->get();

        return view($this->activeTheme . 'user.company.store', compact('pageTitle', 'subTitle', 'categories', 'title', 'route'));
    }

    function edit($id) {
        $company = Company::where('id', $id)
                            ->where(fn($query) => $query->where('status', ManageStatus::ACTIVE)
                                ->orWhere('status', ManageStatus::PENDING))
                            ->first();

        if (!$company) {
            $toast[] = ['error', 'Company not found'];
            return back()->withToasts($toast);
        }

        $pageTitle  = 'Edit Company';
        $subTitle   = 'Update Your Company Profile';
        $title      = 'Edit Your Company Information';
        $route      = route('user.company.store', $id);
        $categories = Category::orderBy('name')->get();
        
        return view($this->activeTheme . 'user.company.store', compact('pageTitle', 'subTitle', 'categories', 'title', 'route', 'company'));
    }

    function store($id = 0) {

        $imageValidation = $id ? 'nullable' : 'required';

        $this->validate(request(), [
            'name'        => 'required|string|max:40|unique:companies,name,' . $id,
            'category_id' => 'required|integer|gt:0',
            'image'       => [$imageValidation, File::types(['png', 'jpg', 'jpeg'])],
            'url'         => 'required|url',
            'email'       => 'required|email|unique:companies,email,' . $id,
            'address'     => 'required|string',
            'description' => 'required|string',
            'tags'        => 'required|array|min:1',
            'tags.*'      => 'string|max:40',
        ]);

        $category = Category::active()->find(request('category_id'));

        if (!$category) {
            $toast[] = ['error', 'Category not found or inactive'];
            return back()->withToasts($toast);
        }

        if ($id) {
            $company = Company::where('id', $id)
                                ->where(fn($query) => $query->where('status', ManageStatus::ACTIVE)
                                    ->orWhere('status', ManageStatus::PENDING))
                                ->first();

            if (!$company) {
                $toast[] = ['error', 'Company not exist'];
                return back()->withToasts($toast);
            }

            $message = ' company info update success';
        } else {
            $form           = Form::where('act', 'company_verification')->first();
            $formData       = $form->form_data;
            $formProcessor  = new FormProcessor();
            $validationRule = $formProcessor->valueValidation($formData);

            request()->validate($validationRule);
            $verificationData = $formProcessor->processFormData(request(), $formData);

            $company = new Company();
            $company->user_id = auth()->id();
            $company->details = $verificationData;

            $message = ' company add success';
        }

        if (request()->hasFile('image')) {
            try {
                $company->image = fileUploader(request('image'), getFilePath('companyImage'), null, @$company->image);
            } catch (\Exception $exp) {
                $toast[] = ['error', 'Image upload failed'];
                return back()->withToasts($toast);
            }
        }

        $company->category_id = request('category_id');
        $company->name        = request('name');
        $company->url         = request('url');
        $company->email       = request('email');
        $company->address     = request('address');
        $company->tags        = request('tags');
        $company->description = request('description');
        $company->save();


        $toast[] = ['success', $company->name . $message];
        return back()->withToasts($toast);
    }

    protected function validation($request, $id = 0) {
        $imageValidation = $id ? 'nullable' : 'required';

        $request->validate([
            'name'        => 'required|string|max:40|unique:companies,name,' . $id,
            'category_id' => 'required|integer|exists:categories,id|gt:0',
            'image'       => [$imageValidation, File::types(['png', 'jpg', 'jpeg'])],
            'url'         => 'required|url',
            'email'       => 'required|email|unique:companies,email,' . $id,
            'address'     => 'required|string',
            'description' => 'required|string',
            'tags'        => 'required|array|min:1',
            'tags.*'      => 'string|max:40',
        ]);
    }

    function details($name, $id) {
        $company = Company::activeCheck()->find($id);

        if(!$company) {
            $toast[] = ['error', 'Company not found or disabled'];
            return back()->withToasts($toast);
        }

        return to_route('company.details', [slug($company->name), $company->id]);
    }
}

