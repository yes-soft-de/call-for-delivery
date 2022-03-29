<?php

namespace App\Request\Order;

class OrderFilterByCaptainRequest
{
    /**
     * @var string|null
     */
    private $state;

    /**
     * @var string|null
     */
    private $fromDate;

    /**
     * @var string|null
     */
    private $toDate;

    /**
     * @var int|null
     */
    private $captainId;

    /**
     * @return string|null
     */
    public function getState(): ?string
    {
        return $this->state;
    }

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
     * @return int|null
     */
    public function getCaptainId(): ?int
    {
        return $this->captainId;
    }

    /**
     * @param int|null $captainId
     */
    public function setCaptainId(?int $captainId): void
    {
        $this->captainId = $captainId;
    }
}
