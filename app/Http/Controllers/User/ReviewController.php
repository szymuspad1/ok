<?php

namespace App\Http\Controllers\User;

use App\Constants\ManageStatus;
use App\Http\Controllers\Controller;
use App\Models\Company;
use App\Models\Report;
use App\Models\Review;

class ReviewController extends Controller
{
    function store($id = 0) {
        
        $ratingValidation = $id ? 'nullable' : 'required';

        $this->validate(request(), [
                'rating'     => $ratingValidation .'|integer|min:1|max:5',
                'company_id' => 'required|integer|gt:0',
                'review'     => 'required|string|max:255'
        ]);

            $user    = auth()->user();
         $company = Company::activeCheck()->find(request('company_id'));


        if (!$company) {
                $toasts[] = ['error', 'Company not found or disabled'];
                return back()->withToasts($toasts);
            }

        if ($id) {
                $review = Review::where('id', $id)->where('user_id', $user->id)->where('company_id', request('company_id'))->first();
        
                if(!$review) {
                        $toasts[] = ['error', 'Review not found'];
                    return back()->withToasts($toasts);
                }

                if (request('rating')) {
                    $ratingDiff             = (int)request('rating') - $review->rating;
                    $company->total_rating += $ratingDiff;
                    $company->save();
            
                    $review->rating     = request('rating');
                }

                $message = 'Review edit success';
        } else {
                $userExist    = Review::where('company_id', request('company_id'))->where('user_id', $user->id)->first();

                if ($userExist) {
                    $toasts[] = ['error', 'You have already reviewed this company'];
                    return back()->withToasts($toasts);
                }
        
                $review             = new Review();
                $review->user_id    = $user->id;
                $review->company_id = request('company_id');
                $review->rating     = request('rating');

                $company->total_rating   += (int)request('rating');
                $company->total_reviewer += 1;
                $company->save();

                $message = 'Review send success';
        }

        $company->avg_rating = avgRating($company->total_rating, $company->total_reviewer);
        $company->save();
    
        $review->review     = request('review');
        $review->save();

        $toasts[] = ['success', $message];
        return back()->withToasts($toasts);
    }

    function report() {
        $this->validate(request(), [
            'review_id'     => 'required|integer|gt:0',
            'user_feedback' => 'required|string|max:255'
        ]);

        $user   = auth()->user();
        $review = Review::find(request('review_id'));
        
        if (!$review) {
            $toast[] = ['error', 'Review not found'];
            return back()->withToasts($toast);
        }

        if (($review->company->user_id != $user->id) && ($review->user_id == $user->id)) {
            $toast[] = ['error', 'You are not authorized for this action'];
            return back()->withToasts($toast);
        }

        $report                = new Report();
        $report->user_id       = $user->id;
        $report->review_id     = request('review_id');
        $report->user_feedback = request('user_feedback');
        $report->save();

        $review->report_id     = $report->id;
        $review->reporter_id   = $user->id;
        $review->report_status = ManageStatus::REPORTED;
        $review->save();

        $toast[] = ['success', 'Report send success'];
        return back()->withToasts($toast);
    }
}
