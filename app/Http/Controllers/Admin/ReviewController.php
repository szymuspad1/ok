<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Review;
use App\Models\User;

class ReviewController extends Controller
{
    function index($userId = 0) {
        return $this->reviewData('All reviews', $scope = null, $userId);
    }

    function clean() {
        return $this->reviewData('Clean reviews', 'clean');
    }

    function reported() {
        return $this->reviewData('Reported reviews', 'reported');
    }

    function delete($id) {
        $review = Review::find($id);
    
        if (!$review) {
            $toast[] = ['error', 'Review not found'];
            return back()->withToasts($toast);
        }

        if ($review->report_status && $review->reporter_id) {
            $reporter = User::where('id', $review->reporter_id)->first();
    
            if (!$reporter) {
                $toast[] = ['error', 'Reporter not found'];
                return back()->withToasts($toast);
            }
    
            if ($review->company->user->id != $reporter->id) {
                $toast[] = ['error', 'Reporter is not authorized'];
                return back()->withToasts($toast);
            }

            notify($reporter, 'INFORM_REPORTER', [
                'company_name' => $review->company->name
            ]);

            notify($review->user, 'DELETE_REPORTED_REVIEW', [
                'company_name' => $review->company->name
            ]);

            $report = $review->report;
            $report->delete();
        } else {
            notify($review->user, 'DELETE_REVIEW', [
                'company_name' => $review->company->name
            ]);
        }

        $company                  = $review->company;
        $company->total_rating   -= $review->rating;
        $company->total_reviewer -= 1;
        $company->save();

        $company->avg_rating = avgRating($company->total_rating, $company->total_reviewer);
        $company->save();

        $review->delete();

        $toast[] = ['success', 'Review delete success'];
        return back()->withToasts($toast);
    }

    protected function reviewData($pageTitle, $scope = null, $userId = 0) {
        $user = null;

        if ($userId) {
            $user = User::active()->find($userId);

            if (!$user) {
                $toast[] = ['error', 'User not found'];
                return back()->withToasts($toast)->throwResponse();
            }
        }

        $reviews = $scope ? Review::$scope()->latest() : Review::latest();
        $reviews = $reviews->when($user, fn($query) => $query->where('user_id', $user->id))->with(['company', 'user'])->searchable(['company:name', 'user:username', 'review', 'rating'])->paginate(getPaginate());

        return view('admin.page.reviews', compact('pageTitle', 'reviews'));
    }
}
