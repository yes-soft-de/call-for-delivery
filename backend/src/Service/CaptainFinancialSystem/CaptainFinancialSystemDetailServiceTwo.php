<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemDetailManager;

class CaptainFinancialSystemDetailServiceTwo
{
    private CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager;
    private AutoMapping $autoMapping;
   

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager)
    {
        $this->captainFinancialSystemDetailManager = $captainFinancialSystemDetailManager;
        $this->autoMapping = $autoMapping;
    }

    public function updateCaptainFinancialSystemDetail(bool $status, int $userId): CaptainFinancialSystemDetailEntity|null
    {
       return $this->captainFinancialSystemDetailManager->updateCaptainFinancialSystemDetail($status, $userId);
    }
}
