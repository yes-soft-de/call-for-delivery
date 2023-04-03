<?php

namespace App\Service\Admin\CaptainFinancialSystem\CaptainFinancialDaily;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Entity\CaptainEntity;
use App\Entity\CaptainFinancialDailyEntity;
use App\Manager\Admin\CaptainFinancialSystem\CaptainFinancialDaily\AdminCaptainFinancialDailyManager;
use App\Request\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyFilterByAdminRequest;
use App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyFilterByAdminResponse;
use App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailySumFilterByAdminResponse;
use App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyTodayGetForAdminResponse;
use App\Service\Admin\Captain\AdminCaptainGetService;
use App\Service\FileUpload\UploadFileHelperService;
use DateTime;

class AdminCaptainFinancialDailyGetService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminCaptainGetService $adminCaptainGetService,
        private UploadFileHelperService $uploadFileHelperService,
        private AdminCaptainFinancialDailyManager $adminCaptainFinancialDailyManager
    )
    {
    }

    public function getCaptainFinancialDailyById(int $captainFinancialDailyId): CaptainFinancialDailyEntity|int
    {
        $captainFinancialDaily = $this->adminCaptainFinancialDailyManager->getCaptainFinancialDailyById($captainFinancialDailyId);

        if (!$captainFinancialDaily) {
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

    /**
     * Get active and online captains' profiles with profile images
     */
    public function getActiveAndOnlineCaptainsForAdmin(): array
    {
        return $this->adminCaptainGetService->getActiveAndOnlineCaptainsForAdmin();
    }

    public function getActiveCaptainsWithFinancialDailyOfTodayForAdmin(): array
    {
        $response = [];

        $captainsProfiles = $this->getActiveAndOnlineCaptainsForAdmin();

        if (count($captainsProfiles) > 0) {
            foreach ($captainsProfiles as $key => $value) {
                $response[$key] = $this->autoMapping->map(CaptainEntity::class, CaptainFinancialDailyTodayGetForAdminResponse::class,
                    $value[0]);

                $response[$key]->image = $this->uploadFileHelperService->getImageParams($value['imagePath']);

                // Check if there are captain financial daily, and if exist, get the financial daily of today
                $captainFinancialDailyEntities = $value[0]->getCaptainFinancialDailyEntities()->toArray();

                if (count($captainFinancialDailyEntities) > 0) {
                    foreach ($captainFinancialDailyEntities as $captainFinancialDaily) {
                        // Compare the date of today and the date of the financial daily
                        if (DateTime::createFromInterface($captainFinancialDaily->getCreatedAt()) == new DateTime("today")) {
                            $response[$key] = $this->autoMapping->map(CaptainFinancialDailyEntity::class, CaptainFinancialDailyTodayGetForAdminResponse::class,
                                $captainFinancialDaily);

                            $response[$key]->captainFinancialDailyId = $response[$key]->id;
                            $response[$key]->captainFinancialDailyUpdatedAt = $captainFinancialDaily->getUpdatedAt();

                            $response[$key]->id = $value[0]->getId();
                            $response[$key]->captainName = $value[0]->getCaptainName();
                            $response[$key]->image = $this->uploadFileHelperService->getImageParams($value['imagePath']);
                        }
                    }
                }
                // End of checking if there are captain financial daily
            }
        }

        return $response;
    }

    /**
     * Filters captain financial daily amounts and get the sum amount of each captain
     */
    public function filterCaptainFinancialDailySumByAdmin(CaptainFinancialDailyFilterByAdminRequest $request): array
    {
        $response = [];

        if ($request->getCaptainProfileId()) {
            $captainFinancialDailyArray = $this->adminCaptainFinancialDailyManager->filterCaptainFinancialDailyWithImagesByAdmin($request);

            if (count($captainFinancialDailyArray) > 0) {
                $tempResponse['id'] = 1;
                $tempResponse['captainProfileId'] = $captainFinancialDailyArray[0][0]->getCaptainProfile()->getId();
                $tempResponse['captainName'] = $captainFinancialDailyArray[0][0]->getCaptainProfile()->getCaptainName();
                $tempResponse['image'] = $this->uploadFileHelperService->getImageParams($captainFinancialDailyArray[0]['imagePath']);
                $tempResponse['amountSum'] = $this->getAmountSumByCaptainFinancialDaily($captainFinancialDailyArray);
                $tempResponse['toBePaid'] = $this->getToBePaidAmountByCaptainFinancialDaily($captainFinancialDailyArray);

                $response[] = $this->autoMapping->map('array', CaptainFinancialDailySumFilterByAdminResponse::class, $tempResponse);
            }

        } else {
            $captainsProfiles = $this->getActiveAndOnlineCaptainsForAdmin();

            if (count($captainsProfiles) > 0) {
                foreach ($captainsProfiles as $key => $value) {
                    $request->setCaptainProfileId($value[0]->getId());

                    $captainFinancialDailyArray = $this->adminCaptainFinancialDailyManager->filterCaptainFinancialDailyWithImagesByAdmin($request);

                    if (count($captainFinancialDailyArray) > 0) {
                        $tempResponse['id'] = $key;
                        $tempResponse['captainProfileId'] = $captainFinancialDailyArray[0][0]->getCaptainProfile()->getId();
                        $tempResponse['captainName'] = $captainFinancialDailyArray[0][0]->getCaptainProfile()->getCaptainName();
                        $tempResponse['image'] = $this->uploadFileHelperService->getImageParams($captainFinancialDailyArray[0]['imagePath']);
                        $tempResponse['amountSum'] = $this->getAmountSumByCaptainFinancialDaily($captainFinancialDailyArray);
                        $tempResponse['toBePaid'] = $this->getToBePaidAmountByCaptainFinancialDaily($captainFinancialDailyArray);

                        $response[] = $this->autoMapping->map('array', CaptainFinancialDailySumFilterByAdminResponse::class, $tempResponse);
                    }
                }
            }
        }

        return $response;
    }

    /**
     * Calculate and return the sum of captain financial daily amount
     * note: the sum of both amount and bonus fields
     */
    public function getAmountSumByCaptainFinancialDaily(array $captainFinancialDailyArray): float
    {
        if (count($captainFinancialDailyArray) === 0) {
            return 0.0;
        }

        $sum = 0.0;

        foreach ($captainFinancialDailyArray as $captainFinancialDaily) {
            $sum += $captainFinancialDaily[0]->getAmount() + $captainFinancialDaily[0]->getBonus();
        }

        return $sum;
    }

    /**
     * Calculate and return the remind payment amount for a group of captain financial daily
     */
    public function getToBePaidAmountByCaptainFinancialDaily(array $captainFinancialDailyArray): float
    {
        if (count($captainFinancialDailyArray) === 0) {
            return 0.0;
        }

        $sum = $this->getAmountSumByCaptainFinancialDaily($captainFinancialDailyArray);

        $paymentsSum = 0.0;

        foreach ($captainFinancialDailyArray as $captainFinancialDaily) {
            $payments = $captainFinancialDaily[0]->getCaptainPayment()->toArray();

            if (count($payments) > 0) {
                foreach ($payments as $payment) {
                    $paymentsSum += $payment->getAmount();
                }
            }
        }

        return ($sum - $paymentsSum);
    }
}
