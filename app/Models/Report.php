<?php

namespace App\Models;

use App\Traits\Searchable;
use Illuminate\Database\Eloquent\Model;

class Report extends Model
{
    use Searchable;

    public function review() {
        return $this->belongsTo(Review::class);
    }

    public function user() {
        return $this->belongsTo(User::class);
    }
}
