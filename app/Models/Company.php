<?php

namespace App\Models;

use App\Constants\ManageStatus;
use App\Traits\Searchable;
use App\Traits\UniversalStatus;
use Illuminate\Database\Eloquent\Model;

class Company extends Model
{
    use UniversalStatus, Searchable;

    protected $casts = [
        'tags'    => 'array',
        'details' => 'object',
    ];

    function user() {
        return $this->belongsTo(User::class);
    }

    function reviews() {
        return $this->hasMany(Review::class);
    }

    function category() {
        return $this->belongsTo(Category::class);
    }

    public function scopePending($query) {
        return $query->where('status', ManageStatus::PENDING);
    }

    public function scopeReject($query) {
        return $query->where('status', ManageStatus::INACTIVE);
    }

    public function scopeActiveCheck($query) {
        return $query->active()->whereHas('category', fn($query) => $query->where('status', ManageStatus::ACTIVE))->whereHas('user', fn($query) => $query->where('status', ManageStatus::ACTIVE));
    }
}
