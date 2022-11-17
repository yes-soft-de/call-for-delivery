<?php

namespace App\Request\Admin\Order;

class OrderHasPayConflictAnswersUpdateByAdminRequest
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
     * @var int|null
     */
    private $orderId;

    /**
     * Refers to the correct answer, either by the captain or by the store
     * 3: captain's answer
     * 4: store's answer
     *
     * @var int
     */
    private $correctAnswer;

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    public function getOrderId(): ?int
    {
        return $this->orderId;
    }

    public function getCorrectAnswer(): int
    {
        return $this->correctAnswer;
    }
}
