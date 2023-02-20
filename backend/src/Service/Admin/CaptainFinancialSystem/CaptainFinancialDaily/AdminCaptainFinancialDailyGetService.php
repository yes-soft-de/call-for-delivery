<?php

namespace App\Service\Admin\CaptainFinancialSystem\CaptainFinancialDaily;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Entity\CaptainFinancialDailyEntity;
use App\Manager\Admin\CaptainFinancialSystem\CaptainFinancialDaily\AdminCaptainFinancialDailyManager;
use App\Request\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyFilterByAdminRequest;
use App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyFilterByAdminResponse;

class AdminCaptainFinancialDailyGetService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminCaptainFinancialDailyManager $adminCaptainFinancialDailyManager
    )
    {
    }

    public function getCaptainFinancialDailyById(int $captainFinancialDailyId): CaptainFinancialDailyEntity|int
    {
        $captainFinancialDaily = $this->adminCaptainFinancialDailyManager->getCaptainFinancialDailyById($captainFinancialDailyId);

        if (! $captainFinancialDaily) {
            return CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST;
        }

        return $captainFinancialDaily;
    }

    public function filterCaptainFinancialDailyByAdmin(CaptainFinancialDailyFilterByAdminRequest $request): array
    {
        $response = [];

        $captainFinancialDailyArray = $this->adminCaptainFinancialDailyManager->filterCaptainFinancialDailyByAdmin($request);

        if (count($captainFinancialDailyArray) > 0) {
            foreach ($captainFinancialDailyArray as $key => $value) {
                $response[$key] = $this->autoMapping->map(CaptainFinancialDailyEntity::class, CaptainFinancialDailyFilterByAdminResponse::class,
                    $value);

                $response[$key]->captainProfileId = $value->getCaptainProfile()->getId();
                $response[$key]->captainName = $value->getCaptainProfile()->getCaptainName();

                // Check if there is captain payment linked with the financial daily amount. then get its info
                $captainPayments = $value->getCaptainPayment()->toArray();

                if (count($captainPayments) > 0) {
                    foreach ($captainPayments as $captainPaymentKey => $captainPaymentValue) {
                        $response[$key]->captainPayments[$captainPaymentKey]['id'] = $captainPaymentValue->getId();
                        $response[$key]->captainPayments[$captainPaymentKey]['amount'] = $captainPaymentValue->getAmount();
                        $response[$key]->captainPayments[$captainPaymentKey]['createdAt'] = $captainPaymentValue->getCreatedAt();
                        $response[$key]->captainPayments[$captainPaymentKey]['note'] = $captainPaymentValue->getNote();
                    }
                }
            }
        }

        return $response;
    }
}
