<?php

namespace App\Request\Admin\CaptainFinancialSystem;

use App\Entity\CaptainEntity;

class CaptainFinancialSystemDetailCreateByAdminRequest
{
    private int $captainFinancialSystemType;

    private int $captainFinancialSystemId;

    // Captain profile id
    private CaptainEntity|int $captain;

    public function getCaptain(): CaptainEntity|int
    {
        return $this->captain;
    }

    public function setCaptain(int|CaptainEntity $captain)
    {
        $this->captain = $captain;
    }
}
