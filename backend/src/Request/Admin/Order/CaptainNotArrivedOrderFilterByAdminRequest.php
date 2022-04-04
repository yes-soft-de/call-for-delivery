<?php

namespace App\Request\Admin\Order;

class CaptainNotArrivedOrderFilterByAdminRequest
{
    /**
     * @var string|null
     */
    private $fromDate;

    /**
     * @var string|null
     */
    private $toDate;

    /**
     * @return string|null
     */
    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    /**
     * @return string|null
     */
    public function getToDate(): ?string
    {
        return $this->toDate;
    }
}