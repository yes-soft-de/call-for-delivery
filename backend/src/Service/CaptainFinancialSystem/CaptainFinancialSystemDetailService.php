<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemDetailManager;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemDetailResponse;
use App\Request\CaptainFinancialSystem\CaptainFinancialSystemDetailRequest;

class CaptainFinancialSystemDetailService
{
    private CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager)
    {
        $this->captainFinancialSystemDetailManager = $captainFinancialSystemDetailManager;
        $this->autoMapping = $autoMapping;
    }

    public function createCaptainFinancialSystemDetail(CaptainFinancialSystemDetailRequest $request): CaptainFinancialSystemDetailResponse
    {
        $item = $this->captainFinancialSystemDetailManager->createCaptainFinancialSystemDetail($request);

        return $this->autoMapping->map(CaptainFinancialSystemDetailEntity::class, CaptainFinancialSystemDetailResponse::class, $item);
    }
}
