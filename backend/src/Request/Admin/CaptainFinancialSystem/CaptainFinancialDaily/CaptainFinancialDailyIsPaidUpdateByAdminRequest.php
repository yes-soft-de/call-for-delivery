<?php

namespace App\Request\Admin\CaptainFinancialSystem\CaptainFinancialDaily;

class CaptainFinancialDailyIsPaidUpdateByAdminRequest
{
    private int $id;

    private int $isPaid;

    public function getId(): int
    {
        return $this->id;
    }

    public function setId(int $id): void
    {
        $this->id = $id;
    }

    public function getIsPaid(): int
    {
        return $this->isPaid;
    }

    public function setIsPaid(int $isPaid): void
    {
        $this->isPaid = $isPaid;
    }
}