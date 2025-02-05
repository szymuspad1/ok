<?php

namespace App\Models;

use App\Constants\ManageStatus;
use App\Traits\Searchable;
use Illuminate\Database\Eloquent\Model;

class Review extends Model
{
    use Searchable;
    function user() {
        return $this->belongsTo(User::class);
    }

    function company() {
        return $this->belongsTo(Company::class);
    }

    function report() {
        return $this->belongsTo(Report::class);
    }

    public function scopeReported($query) {
        return $query->where('report_status', ManageStatus::REPORTED);
    }

    public function scopeClean($query) {
        return $query->where('report_status', ManageStatus::CLEAN);
    }
}
