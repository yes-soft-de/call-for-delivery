<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailUpdateByAdminRequest;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailUpdateRequest;

interface AdminCaptainFinancialSystemDetailInterface
{
    public function getBalanceDetailForAdmin(int $captainId);

    public function getLatestFinancialCaptainSystemDetails(int $captainId);

    public function updateStatusCaptainFinancialSystemDetail(AdminCaptainFinancialSystemDetailUpdateRequest $request);

    public function getSumPayments($captainId, $fromDate, $toDate);

    public function captainFinancialSystemDetailUpdate(AdminCaptainFinancialSystemDetailUpdateByAdminRequest $request);

    public function calculateOrdersThatNotBelongToAnyFinancialDues();
}
