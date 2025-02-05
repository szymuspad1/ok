<?php

namespace App\Http\Controllers\Admin;

use App\Constants\ManageStatus;
use App\Http\Controllers\Controller;
use App\Models\Report;
use App\Models\Review;

class ReportController extends Controller
{
    function index() {
        $pageTitle = 'All Reports';
        $reports   = Report::with(['review', 'user'])->searchable(['user:fullname', 'user:username', 'user_feedback'])->latest()->paginate(getPaginate());

        return view('admin.page.reports', compact('pageTitle', 'reports'));
    }

    function delete($id) {
        $report = Report::find($id);
        
        if (!$report) {
            $toast[] = ['error', 'Report not found'];
            return back()->withToasts($toast);
        }

        $review = Review::reported()->where('reporter_id', $report->user_id)->first();

        if (!$review) {
            $toast[] = ['error', 'Review not found'];
            return back()->withToasts($toast);
        }

        $review->report_id     = ManageStatus::CLEAN;
        $review->report_status = ManageStatus::CLEAN;
        $review->reporter_id   = ManageStatus::CLEAN;
        $review->save();

        notify($report->user, 'DELETE_REPORT', [
            'reporter_name' => $report->user->fullname,
            'company_name'  => $review->company->name,
        ]);

        $report->delete();

        $toast[] = ['success', 'Report delete success'];
        return back()->withToasts($toast);
    }
}
