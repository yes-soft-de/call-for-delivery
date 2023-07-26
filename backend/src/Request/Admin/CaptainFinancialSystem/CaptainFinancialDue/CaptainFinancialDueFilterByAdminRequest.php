<?php

namespace App\Request\Admin\CaptainFinancialSystem\CaptainFinancialDue;

class CaptainFinancialDueFilterByAdminRequest
{
    /**
     * 1: paid. 2: unpaid. 3: partially paid
     *
     * @var int|null
     */
    private $status;

    /**
     * has the captain demanded his/her financial due ?
     *
     * @var bool|null
     */
    private $hasCaptainFinancialDueDemanded;

    public function getStatus(): ?int
    {
        return $this->status;
    }

    public function getHasCaptainFinancialDueDemanded(): ?bool
    {
        return $this->hasCaptainFinancialDueDemanded;
    }
}
