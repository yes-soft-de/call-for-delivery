<?php

namespace App\Request\Admin\Order;

class OrderCaptainFilterByAdminRequest
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
     * @var int
     */
    private $captainProfileId;

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

    /**
     * Get the value of captainProfileId
     *
     * @return  int|null
     */ 
    public function getCaptainProfileId()
    {
        return $this->captainProfileId;
    }
}
