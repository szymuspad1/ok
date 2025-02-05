<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Advertisement;
use Illuminate\Validation\Rules\File;

class AdvertisementController extends Controller
{
    function index() {
        $pageTitle      = 'All Advertisements';
        $advertisements = Advertisement::latest()->searchable(['size'])->paginate(getPaginate());

        return view('admin.page.advertisements', compact('pageTitle', 'advertisements'));
    }

    function store($id = 0) {
        $imageValidation = (request('type') == '1' && !$id) ? 'required' : 'nullable';

        $this->validate(request(), [
            'type'         => 'required|integer|between:1,2',
            'size'         => 'required|in:350x495,470x270,460x460,960x145',
            'redirect_url' => 'required_if:type,1|url',
            'image'        => [$imageValidation, File::types(['png', 'jpg', 'jpeg'])],
            'script'       => 'required_if:type,2'
        ]);
        
        if ($id) {
            $advertisement = Advertisement::findOrFail($id);
            $message       = 'Advertisement update success';
        } else {
            $advertisement = new Advertisement();
            $message       = 'Advertisement add success';
        }

        if (request()->hasFile('image')) {
            try {
                $advertisement->image = fileUploader(request('image'), getFilePath('advertisements'), request('size'), @$advertisement->image);
                
                if ($id) {
                    $advertisement->script = null;
                }
            } catch (\Exception $exp) {
                $toast[] = ['error', 'Image upload failed'];
                return back()->withToasts($toast);
            }
        }

        if (request('type') == '2') {
            $advertisement->script = request('script');
            
            if ($id) {
                fileManager()->removeFile(getFilePath('advertisements').'/'.@$advertisement->image);
                $advertisement->image = null;
            }
        }

        $advertisement->type         = request('type');
        $advertisement->size         = request('size');
        $advertisement->redirect_url = request('redirect_url') ? request('redirect_url') : null;
        $advertisement->save();

        $toast[] = ['success', $message];
        return back()->withToasts($toast);
    }

    function status($id) {
        $advertisement = Advertisement::find($id);

        if (!$advertisement) {
            $toast[] = ['error', 'Advertisement not found'];
            return back()->withToasts($toast);
        }

        return Advertisement::changeStatus($advertisement->id);
    }
}
