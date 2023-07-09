<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyIsPaidConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Order\OrderResultConstant;
use App\Constant\Order\OrderStateConstant;
use App\Entity\CaptainEntity;
use App\Entity\CaptainFinancialDailyEntity;
use App\Entity\CaptainPaymentEntity;
use App\Entity\OrderEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyManager;
use App\Request\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyAmountUpdateRequest;
use App\Request\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyCreateRequest;
use App\Response\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyAmountUpdateResponse;
use App\Response\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyCreateResponse;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemDetail\CaptainFinancialSystemDetailGetService;
use App\Service\DateFactory\DateFactoryService;
use App\Service\Order\OrderGetService;
use DateTime;
use DateTimeInterface;

class CaptainFinancialDailyService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private OrderGetService $orderGetService,
        private CaptainFinancialSystemDetailGetService $captainFinancialSystemDetailGetService,
        private DateFactoryService $dateFactoryService,
        private CaptainFinancialDailyManager $captainFinancialDailyManager,
        private CaptainFinancialSystemThreeDailyService $captainFinancialSystemThreeDailyService,
        private CaptainFinancialSystemOneDailyService $captainFinancialSystemOneDailyService,
        private CaptainFinancialSystemTwoDailyService $captainFinancialSystemTwoDailyService,
        private CaptainFinancialDefaultSystemDailyService $captainFinancialDefaultSystemDailyService
    )
    {
    }

    /**
     * Get order entity if exists, or string const if not
     */
    public function getOrderById(int $orderId): OrderEntity|string
    {
        return $this->orderGetService->getOrderEntityById($orderId);
    }

    /**
     * Get selected captain financial system details
     * if the financial system is the first or the second one, then return more info about the financial system
     */
    public function getCaptainFinancialSystemDetailByCaptainUserId(int $captainUserId): array
    {
        return $this->captainFinancialSystemDetailGetService->getLastCaptainFinancialSystemDetailByCaptainUserId($captainUserId);
    }

    /**
     * Get array consists of basic order value, cash store amount, and bonus, according to the selected financial system
     */
    public function getCaptainFinancialAmountAndStoreCashAmountBySpecificFinancialSystemTypeAndSpecificDate(array $captainFinancialSystemDetail, int $captainProfileId, string $fromDate, string $toDate): array
    {
        $response = [];

        $response['basicFinancialAmount'] = 0.0;
        $response['bounce'] = 0.0;
        $response['amountForStore'] = 0.0;

        if ($captainFinancialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
            // Captain financial system is the first one
            return $this->captainFinancialSystemOneDailyService->getDailyCaptainFinancialAmount($captainFinancialSystemDetail,
                $captainProfileId, $fromDate, $toDate);

        } elseif ($captainFinancialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {
            // Captain financial system is the second one
            return $this->captainFinancialSystemTwoDailyService->getDailyCaptainFinancialAmount($captainFinancialSystemDetail,
                $captainProfileId, $fromDate, $toDate);

        } elseif ($captainFinancialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
            // Captain financial system is the third one
            return $this->captainFinancialSystemThreeDailyService->getDailyCaptainFinancialAmount($captainProfileId,
                $fromDate, $toDate);

        } elseif ($captainFinancialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_DEFAULT_SYSTEM_CONST) {
            // Captain financial system is the default one
            return $this->captainFinancialDefaultSystemDailyService->getDailyCaptainFinancialAmount($captainProfileId,
                $fromDate, $toDate);
        }

        return $response;
    }

    /**
     * Get array consists of basic order value, cash store amount, bonus, and if there is bonus or not
     */
    public function getCaptainFinancialAmountDetailsBySpecificDate(array $captainFinancialSystemDetail, int $captainProfileId, string $fromDate, string $toDate): array
    {
        $orderFinancialValuesArrayResult = $this->getCaptainFinancialAmountAndStoreCashAmountBySpecificFinancialSystemTypeAndSpecificDate($captainFinancialSystemDetail,
            $captainProfileId, $fromDate, $toDate);

        // allocate additional cell of the returned array to determine if there is bonus or not
        $orderFinancialValuesArrayResult['withBonus'] = false;

        if ($orderFinancialValuesArrayResult['bounce'] > 0.0) {
            $orderFinancialValuesArrayResult['withBonus'] = true;
        }

        return $orderFinancialValuesArrayResult;
    }

    /**
     * Get daily captain financial amount, if exists, according to the captain and specific date
     */
    public function checkIfCaptainFinancialDailyExistForSpecificDay(DateTime $date, int $captainProfileId): CaptainFinancialDailyEntity|int
    {
        $captainFinancialDaily = $this->captainFinancialDailyManager->getCaptainFinancialDailyByDateAndCaptainProfileId($date,
            $captainProfileId);

        if (! $captainFinancialDaily) {
            return CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST;
        }

        return $captainFinancialDaily;
    }

    /**
     * Get object of type DateTime from object of type DateTimeInterface
     */
    public function getDateTimeObjectFromDateTimeInterface(DateTimeInterface $dateTime): DateTime
    {
        return $this->dateFactoryService->getDateTimeObjectFromDateTimeInterface($dateTime);
    }

    /**
     * Initialize and return new request for creating daily captain financial amount
     */
    public function initializeAndGetCaptainFinancialDailyCreateRequest(CaptainEntity $captainEntity, float $amount, float $alreadyHadAmount, int $financialSystemType, int $isPaid, DateTime $createdAt,
                                                                       bool $withBonus, float $bonus = null, int $financialSystemPlan = null, CaptainPaymentEntity $captainPaymentEntity = null): CaptainFinancialDailyCreateRequest
    {
        $captainFinancialDailyCreateRequest = new CaptainFinancialDailyCreateRequest();

        $captainFinancialDailyCreateRequest->setCaptainProfile($captainEntity);
        $captainFinancialDailyCreateRequest->setAmount($amount);
        $captainFinancialDailyCreateRequest->setAlreadyHadAmount($alreadyHadAmount);
        $captainFinancialDailyCreateRequest->setFinancialSystemType($financialSystemType);
        $captainFinancialDailyCreateRequest->setFinancialSystemPlan($financialSystemPlan);
        $captainFinancialDailyCreateRequest->setIsPaid($isPaid);
        $captainFinancialDailyCreateRequest->setWithBonus($withBonus);
        $captainFinancialDailyCreateRequest->setBonus($bonus);
        $captainFinancialDailyCreateRequest->setCaptainPayment($captainPaymentEntity);
        $captainFinancialDailyCreateRequest->setCreatedAt($createdAt);

        return $captainFinancialDailyCreateRequest;
    }

    /**
     * Create daily captain financial amount and return appropriate response
     */
    public function createCaptainFinancialDaily(CaptainEntity $captainEntity, float $amount, float $alreadyHadAmount, int $financialSystemType,
                                                int $isPaid, DateTime $createdAt, bool $withBonus, float $bonus = null, int $financialSystemPlan = null,
                                                CaptainPaymentEntity $captainPaymentEntity = null)
    {
        $captainFinancialDailyCreateRequest = $this->initializeAndGetCaptainFinancialDailyCreateRequest($captainEntity, $amount, $alreadyHadAmount,
            $financialSystemType, $isPaid, $createdAt, $withBonus, $bonus, $financialSystemPlan, $captainPaymentEntity);

        $captainFinancialDaily = $this->captainFinancialDailyManager->createCaptainFinancialDaily($captainFinancialDailyCreateRequest);

        return $this->autoMapping->map(CaptainFinancialDailyEntity::class, CaptainFinancialDailyCreateResponse::class, $captainFinancialDaily);
    }

    /**
     * Initialize and return new request for updating daily captain financial amount
     */
    public function initializeAndGetCaptainFinancialDailyAmountUpdateRequest(int $captainFinancialDailyId, float $amount, float $alreadyHadAmount, bool $withBonus, float $bonus = null): CaptainFinancialDailyAmountUpdateRequest
    {
        $captainFinancialDailyAmountUpdateRequest = new CaptainFinancialDailyAmountUpdateRequest();

        $captainFinancialDailyAmountUpdateRequest->setId($captainFinancialDailyId);
        $captainFinancialDailyAmountUpdateRequest->setAmount($amount);
        $captainFinancialDailyAmountUpdateRequest->setAlreadyHadAmount($alreadyHadAmount);
        $captainFinancialDailyAmountUpdateRequest->setWithBonus($withBonus);
        $captainFinancialDailyAmountUpdateRequest->setBonus($bonus);

        return $captainFinancialDailyAmountUpdateRequest;
    }

    /**
     * Update daily captain financial amount and return appropriate response
     */
    public function updateCaptainFinancialDailyAmount(int $captainFinancialDailyId, float $amount, float $alreadyHadAmount, bool $withBonus, float $bonus = null)
    {
        $captainFinancialDailyAmountUpdateRequest = $this->initializeAndGetCaptainFinancialDailyAmountUpdateRequest($captainFinancialDailyId,
            $amount, $alreadyHadAmount, $withBonus, $bonus);

        $captainFinancialDailyUpdateResult = $this->captainFinancialDailyManager->updateCaptainFinancialDailyAmount($captainFinancialDailyAmountUpdateRequest);

        if ($captainFinancialDailyUpdateResult === CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST) {
            return CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST;
        }

        return $this->autoMapping->map(CaptainFinancialDailyEntity::class, CaptainFinancialDailyAmountUpdateResponse::class, $captainFinancialDailyUpdateResult);
    }

    /**
     * main function
     * Creates or updates captain financial daily
     */
    public function createOrUpdateCaptainFinancialDaily(int $orderId, CaptainEntity $captainEntity = null)
    {
        // Get order entity first
        $order = $this->getOrderById($orderId);

        if ($order === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        if (! $captainEntity) {
            $captainProfile = $order->getCaptainId();

        } else {
            $captainProfile = $captainEntity;
        }

        // Get which financial system has the captain subscribed with
        $captainFinancialSystemDetail = $this->getCaptainFinancialSystemDetailByCaptainUserId($captainProfile->getCaptainId());

        if (count($captainFinancialSystemDetail) === 0) {
            return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
        }

        // Depending on financial system type and id, calculate the expected financial value of the order
        $orderFinancialValuesArrayResult = $this->getCaptainFinancialAmountDetailsBySpecificDate($captainFinancialSystemDetail,
            $captainProfile->getId(), $order->getCreatedAt()->format('Y-m-d 00:00:00'), $order->getCreatedAt()->format('Y-m-d 23:59:59'));

        // Check if there is financial due for the day similar to the creation day of the order
        // if exists, then update it, if not, create a new one
        $date = $this->getDateTimeObjectFromDateTimeInterface($order->getCreatedAt());

        $captainFinancialDaily = $this->checkIfCaptainFinancialDailyExistForSpecificDay($date, $captainProfile->getId());

        if ($captainFinancialDaily === CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST) {
            // create new captain financial daily
            return $this->createCaptainFinancialDaily($captainProfile, $orderFinancialValuesArrayResult['basicFinancialAmount'],
                $orderFinancialValuesArrayResult['amountForStore'], $captainFinancialSystemDetail['captainFinancialSystemType'],
                CaptainFinancialDailyIsPaidConstant::CAPTAIN_FINANCIAL_DAILY_IS_NOT_PAID_CONST, DateTime::createFromInterface($order->getCreatedAt()),
                $orderFinancialValuesArrayResult['withBonus'], $orderFinancialValuesArrayResult['bounce'], $captainFinancialSystemDetail['captainFinancialSystemId']);
        }

        // update existing captain financial daily
        return $this->updateCaptainFinancialDailyAmount($captainFinancialDaily->getId(), $orderFinancialValuesArrayResult['basicFinancialAmount'],
            $orderFinancialValuesArrayResult['amountForStore'], $orderFinancialValuesArrayResult['withBonus'],
            $orderFinancialValuesArrayResult['bounce']);
    }
}
