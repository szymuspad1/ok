<?php

namespace App\Constants;

class ManageStatus {
    const ACTIVE   = 1;
    const INACTIVE = 0;

    const YES = 1;
    const NO  = 0;
    
    const UNVERIFIED = 0;
    const VERIFIED   = 1;
    const PENDING    = 2;

    const PAYMENT_INITIATE = 0;
    const PAYMENT_SUCCESS  = 1;
    const PAYMENT_PENDING  = 2;
    const PAYMENT_CANCEL   = 3;

    const SINGLE_STAR = 1;
    const DOUBLE_STAR = 2;
    const TRIPLE_STAR = 3;
    const QUAD_STAR   = 4;
    const FIVE_STAR   = 5;

    const REPORTED = 8;
    const CLEAN    = 0;
}
