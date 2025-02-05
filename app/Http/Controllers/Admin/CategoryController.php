<?php

namespace App\Http\Controllers\Admin;

use App\Constants\ManageStatus;
use App\Http\Controllers\Controller;
use App\Models\Category;
use Illuminate\Validation\Rules\File;


class CategoryController extends Controller
{
    function index() {
        return $this->categoryData('All Categories');
    }

    function active() {
        return $this->categoryData('Active Categories', 'active');
    }

    function inactive() {
        return $this->categoryData('Inactive Categories', 'inactive');
    }

    function store($id=0) {
        $imageValidation = $id ? 'nullable' : 'required';

        $this->validate(request(), [
            'name'       => 'required|string|max:255|unique:categories,name,' . $id,
            'short_name' => 'required|string|max:40|unique:categories,short_name,' . $id,
            'highlight'  => 'nullable',
            'image'      => [$imageValidation, File::types(['png', 'jpg', 'jpeg'])]

        ]);

        if ($id) {
            $category = Category::findOrFail($id);
            $message  = ' category edited successfully';
        } else {
            $category = new Category();
            $message  = ' category added successfully';
        }

        if (request()->hasFile('image')) {
            try {
                $category->image = fileUploader(request('image'), getFilePath('categoryImage'), getFileSize('categoryImage'), @$category->image);
            } catch (\Exception $exp) {
                $toast[] = ['error', 'Image upload failed'];
                return back()->withToasts($toast);
            }
        }

        $category->name       = request('name');
        $category->short_name = request('short_name');
        $category->highlight  = request('highlight') ? ManageStatus::YES : ManageStatus::NO;
        $category->save();

        $toast[] = ['success', $category->name . $message];
        return back()->withToasts($toast);
    }

    function status($id){
        return Category::changeStatus($id);
    }

    protected function categoryData($pageTitle, $scope = null) {
        $categories = $scope ? Category::$scope()->latest() : Category::latest();
        $categories = $categories->searchable(['name'])->paginate(getPaginate());

        return view('admin.page.category', compact('pageTitle', 'categories'));
    }
}
