<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Entity\CaptainFinancialDailyEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyManager;
use App\Request\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyFilterRequest;
use App\Response\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyAmountGetForCaptainResponse;
use App\Response\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyFilterResponse;
use DateTime;

class CaptainFinancialDailyGetService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private CaptainFinancialDailyManager $captainFinancialDailyManager
    )
    {
    }

    public function getCaptainFinancialAmountDailyByCaptainUserIdAndSpecificDate(int $captainId, DateTime $date): array|null|CaptainFinancialDailyAmountGetForCaptainResponse
    {
        $response = [];

        $captainFinancialDaily = $this->captainFinancialDailyManager->getCaptainFinancialAmountDailyByCaptainUserIdAndSpecificDate($captainId, $date);

        if (! $captainFinancialDaily) {
            //return CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST;
            return $this->autoMapping->map('array', CaptainFinancialDailyAmountGetForCaptainResponse::class, $response);
        }

        return $this->autoMapping->map(CaptainFinancialDailyEntity::class, CaptainFinancialDailyAmountGetForCaptainResponse::class, $captainFinancialDaily);
    }

    public function filterCaptainFinancialDaily(CaptainFinancialDailyFilterRequest $request): array
    {
        $response = [];

        $filteredCaptainFinancialDaily = $this->captainFinancialDailyManager->filterCaptainFinancialDaily($request);

        if (count($filteredCaptainFinancialDaily) > 0) {
            foreach ($filteredCaptainFinancialDaily as $key => $value) {
                $response[$key] = $this->autoMapping->map(CaptainFinancialDailyEntity::class, CaptainFinancialDailyFilterResponse::class,
                    $value);

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

    public function getCaptainFinancialDailyByCaptainProfileIdAndSpecificDate(int $captainProfileId, DateTime $date, ?string $timeZone = null): CaptainFinancialDailyEntity|int
    {
        $captainFinancialDaily = $this->captainFinancialDailyManager->getCaptainFinancialDailyByCaptainProfileIdAndSpecificDate($captainProfileId,
            $date, $timeZone);

        if (count($captainFinancialDaily) === 0) {
            return CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST;
        }

        return $captainFinancialDaily[0];
    }
}
