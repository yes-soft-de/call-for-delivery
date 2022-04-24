<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialDuesManager;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialDuesResponse;

class AdminCaptainFinancialDuesService
{
    private AdminCaptainFinancialDuesManager $adminCaptainFinancialDuesManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, AdminCaptainFinancialDuesManager $adminCaptainFinancialDuesManager)
    {
        $this->adminCaptainFinancialDuesManager = $adminCaptainFinancialDuesManager;
        $this->autoMapping = $autoMapping;
    }

    public function getCaptainFinancialDues(int $captainId): array
    {        
        $response = [];

        $captainFinancialDues = $this->adminCaptainFinancialDuesManager->getCaptainFinancialDuesByCaptainId($captainId);

        foreach ($captainFinancialDues as $captainFinancialDue) {

            $response[] = $this->autoMapping->map('array', AdminCaptainFinancialDuesResponse::class, $captainFinancialDue);
        }

        return $response;
    }
}
