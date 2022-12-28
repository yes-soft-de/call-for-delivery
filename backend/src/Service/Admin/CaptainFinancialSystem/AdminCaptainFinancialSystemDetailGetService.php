<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailManager;

class AdminCaptainFinancialSystemDetailGetService
{
    private AdminCaptainFinancialSystemDetailManager $adminCaptainFinancialSystemDetailManager;

    public function __construct(AdminCaptainFinancialSystemDetailManager $adminCaptainFinancialSystemDetailManager)
    {
        $this->adminCaptainFinancialSystemDetailManager = $adminCaptainFinancialSystemDetailManager;
    }

    public function getLatestFinancialCaptainSystemDetails(int $captainId): ?array
    {
        return $this->adminCaptainFinancialSystemDetailManager->getLatestFinancialCaptainSystemDetails($captainId);
    }
}
