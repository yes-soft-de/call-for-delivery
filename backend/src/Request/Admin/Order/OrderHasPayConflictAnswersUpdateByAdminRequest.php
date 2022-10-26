<?php

namespace App\Request\Admin\Order;

class OrderHasPayConflictAnswersUpdateByAdminRequest
{
    // currently unavailable
//    /**
//     * @var int|null
//     */
//    private $hasPayConflictAnswers;

    /**
     * @var string|null
     */
    private $fromDate;

    /**
     * @var string|null
     */
    private $toDate;

//    public function getHasPayConflictAnswers(): ?int
//    {
//        return $this->hasPayConflictAnswers;
//    }

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    public function getToDate(): ?string
    {
        return $this->toDate;
    }
}
