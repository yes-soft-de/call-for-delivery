<?php

namespace App\Service\Admin\CaptainAmountFromOrderCash;

use App\AutoMapping;
use App\Entity\CaptainAmountFromOrderCashEntity;
use App\Manager\Admin\CaptainAmountFromOrderCash\AdminCaptainAmountFromOrderCashManager;
use App\Request\Admin\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashFilterGetRequest;
use App\Response\Admin\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashResponse;

class AdminCaptainAmountFromOrderCashService
{
    private AutoMapping $autoMapping;
    private AdminCaptainAmountFromOrderCashManager $adminCaptainAmountFromOrderCashManager;

    public function __construct(AutoMapping $autoMapping, AdminCaptainAmountFromOrderCashManager $adminCaptainAmountFromOrderCashManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminCaptainAmountFromOrderCashManager = $adminCaptainAmountFromOrderCashManager;
    }

    public function filterCaptainAmountFromOrderCash(CaptainAmountFromOrderCashFilterGetRequest $request): array
    {
        $response = [];
        $items = $this->adminCaptainAmountFromOrderCashManager->filterCaptainAmountFromOrderCash($request);
        
        foreach ($items as $captainAmountFromOrderCash) {

            $response[] = $this->autoMapping->map("array", CaptainAmountFromOrderCashResponse::class, $captainAmountFromOrderCash);
        }

        return $response;
    }
}
