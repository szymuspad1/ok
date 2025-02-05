<?php

namespace App\Models;

use App\Constants\ManageStatus;
use App\Traits\Searchable;
use App\Traits\UniversalStatus;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use UniversalStatus, Searchable;

    function companies() {
        return $this->hasMany(Company::class);
    }

    public function scopeInactive($query){
        return $query->where('status', ManageStatus::INACTIVE);
    }

    public function scopeHighlight($query) {
        return $query->where('highlight', ManageStatus::ACTIVE);
    }

    public function scopeCompanyCount($query) {
        return $query->withCount(['companies' => function($query) {
            $query->active();
        }]);
    }
}
