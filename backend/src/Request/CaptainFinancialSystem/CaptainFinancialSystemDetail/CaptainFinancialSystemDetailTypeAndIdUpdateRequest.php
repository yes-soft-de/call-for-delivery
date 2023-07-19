<?php

namespace App\Request\CaptainFinancialSystem\CaptainFinancialSystemDetail;

class CaptainFinancialSystemDetailTypeAndIdUpdateRequest
{
    private int $id;

    private int $captainFinancialSystemType;

    private int $captainFinancialSystemId;

    private int $updatedBy;

    public function getId(): int
    {
        return $this->id;
    }

    public function setId(int $id): void
    {
        $this->id = $id;
    }

    public function setCaptainFinancialSystemType(int $captainFinancialSystemType): void
    {
        $this->captainFinancialSystemType = $captainFinancialSystemType;
    }

    public function setCaptainFinancialSystemId(int $captainFinancialSystemId): void
    {
        $this->captainFinancialSystemId = $captainFinancialSystemId;
    }

    public function setUpdatedBy(int $updatedBy): void
    {
        $this->updatedBy = $updatedBy;
    }
}
