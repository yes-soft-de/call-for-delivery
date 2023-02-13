<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDaily;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyIsPaidConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Order\OrderHasPayConflictAnswersConstant;
use App\Constant\Order\OrderPaidToProviderConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Payment\PaymentConstant;
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
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemOne\OrderFinancialValueAccordingToSystemOneCalculationService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemThree\OrderFinancialValueAccordingToSystemThreeCalculationService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo\OrderFinancialValueAccordingToSystemTwoCalculationService;
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
        private OrderFinancialValueAccordingToSystemTwoCalculationService $orderFinancialValueAccordingToSystemTwoCalculationService,
        private OrderFinancialValueAccordingToSystemThreeCalculationService $orderFinancialValueAccordingToSystemThreeCalculationService,
        private OrderFinancialValueAccordingToSystemOneCalculationService $orderFinancialValueAccordingToSystemOneCalculationService,
        private DateFactoryService $dateFactoryService,
        private CaptainFinancialDailyManager $captainFinancialDailyManager
    )
    {
    }

    public function getOrderByIdAndState(int $orderId, string $orderState): OrderEntity|string
    {
        return $this->orderGetService->getOrderEntityByIdAndState($orderId, $orderState);
    }

    public function getCaptainFinancialSystemDetailByCaptainUserId(int $captainUserId): array
    {
        return $this->captainFinancialSystemDetailGetService->getLastCaptainFinancialSystemDetailByCaptainUserId($captainUserId);
    }

    public function getOrderFinancialValueAccordingToCountOfOrders(int $captainProfileId, array $captainFinancialSystemDetails, float $orderDistance = null): float
    {
        return $this->orderFinancialValueAccordingToSystemTwoCalculationService->getOrderFinancialValueAccordingToCountOfOrders($captainProfileId,
            $captainFinancialSystemDetails, $orderDistance);
    }

    /**
     * return array consists of basic order value, and bonus
     */
    public function getOrderFinancialValueAccordingOnOrders(int $captainProfileId, float $orderDistance = null): array
    {
        return $this->orderFinancialValueAccordingToSystemThreeCalculationService->getOrderFinancialValueAccordingOnOrders($captainProfileId,
            $orderDistance);
    }

    public function getOrderFinancialValueAccordingOnCountOfHours(float $compensationForEveryOrder, float $orderDistance = null): float
    {
        return $this->orderFinancialValueAccordingToSystemOneCalculationService->getOrderFinancialValueAccordingOnCountOfHours($compensationForEveryOrder,
            $orderDistance);
    }

    /**
     * return array consists of basic order value, and bonus
     */
    public function getOrderFinancialValueAccordingToCaptainFinancialSystemType(array $captainFinancialSystemDetail, int $captainProfileId, float $storeBranchToClientDistance = null): array
    {
        $orderFinancialValue = 0.0;

        if ($captainFinancialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
            // Captain financial system is the first one
            ///todo calculate the order cost according to the first financial system

            return [0.0, 0.0];

        } elseif ($captainFinancialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {
            // Captain financial system is the second one
            ///todo calculate the order cost according to the second financial system

            return [0.0, 0.0];

        } elseif ($captainFinancialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
            // Captain financial system is the third one

        }

        return [$orderFinancialValue, 0.0];
    }

    /**
     * return array consists of basic order value, bonus, and boolean value indicate if there is bonus or not
     */
    public function getOrderFinancialCostAndBonus(array $captainFinancialSystemDetail, int $captainProfileId, float $storeBranchToClientDistance = null): array
    {
        $orderFinancialValuesArrayResult = $this->getOrderFinancialValueAccordingToCaptainFinancialSystemType($captainFinancialSystemDetail,
            $captainProfileId, $storeBranchToClientDistance);

        // allocate third cell of the returned array to determine if there is bonus or not
        $orderFinancialValuesArrayResult[2] = false;

        if ($orderFinancialValuesArrayResult[1] > 0.0) {
            $orderFinancialValuesArrayResult[2] = true;
        }

        return $orderFinancialValuesArrayResult;
    }

    public function checkAndGetOrderCashAmountByOrderEntity(OrderEntity $orderEntity): float|int|null
    {
        if ($orderEntity->getPayment() !== PaymentConstant::CASH_PAYMENT_METHOD_CONST) {
            return OrderResultConstant::ORDER_CARD_PAYMENT_CONST;
        }

        if ($orderEntity->getHasPayConflictAnswers() === OrderHasPayConflictAnswersConstant::ORDER_HAS_PAYMENT_CONFLICT_ANSWERS) {
            return OrderResultConstant::ORDER_HAS_PAY_CONFLICT_ANSWER_CONST;
        }

        if ($orderEntity->getPaidToProvider() === OrderPaidToProviderConstant::ORDER_PAID_TO_PROVIDER_YES_CONST) {
            // Captain already paid the order cost to the store, and the client didn't pay the captain, so the captain
            // deserve the cost of the order
            return $orderEntity->getCaptainOrderCost();
        }

        // Captain didn't pay the order cost to the store, so he/she doesn't deserve money for that
        return 0.0;
    }

    public function checkIfCaptainFinancialDailyExistForSpecificDay(DateTime $date): CaptainFinancialDailyEntity|int
    {
        $captainFinancialDaily = $this->captainFinancialDailyManager->getCaptainFinancialDailyByDate($date);

        if (! $captainFinancialDaily) {
            return CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST;
        }

        return $captainFinancialDaily;
    }

    public function getDateTimeObjectFromDateTimeInterface(DateTimeInterface $dateTime): DateTime
    {
        return $this->dateFactoryService->getDateTimeObjectFromDateTimeInterface($dateTime);
    }

    public function initializeAndGetCaptainFinancialDailyCreateRequest(CaptainEntity $captainEntity, float $amount, float $alreadyHadAmount, int $financialSystemType, int $isPaid,
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

        return $captainFinancialDailyCreateRequest;
    }

    public function createCaptainFinancialDaily(CaptainEntity $captainEntity, float $amount, float $alreadyHadAmount, int $financialSystemType,
                                                int $isPaid, bool $withBonus, float $bonus = null, int $financialSystemPlan = null,
                                                CaptainPaymentEntity $captainPaymentEntity = null)
    {
        $captainFinancialDailyCreateRequest = $this->initializeAndGetCaptainFinancialDailyCreateRequest($captainEntity, $amount, $alreadyHadAmount,
            $financialSystemType, $isPaid, $withBonus, $bonus, $financialSystemPlan, $captainPaymentEntity);

        $captainFinancialDaily = $this->captainFinancialDailyManager->createCaptainFinancialDaily($captainFinancialDailyCreateRequest);

        return $this->autoMapping->map(CaptainFinancialDailyEntity::class, CaptainFinancialDailyCreateResponse::class, $captainFinancialDaily);
    }

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
    public function createOrUpdateCaptainFinancialDaily(int $orderId)
    {
        // Get order entity first
        $order = $this->getOrderByIdAndState($orderId, OrderStateConstant::ORDER_STATE_DELIVERED);

        if ($order === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        // Get which financial system has the captain subscribed with
        $captainFinancialSystemDetail = $this->getCaptainFinancialSystemDetailByCaptainUserId($order->getCaptainId()->getCaptainId());

        if (count($captainFinancialSystemDetail) === 0) {
            return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
        }

        // Depending on financial system type and id, calculate the expected financial value of the order
        $orderFinancialValuesArrayResult = $this->getOrderFinancialCostAndBonus($captainFinancialSystemDetail, $order->getCaptainId()->getId(),
            $order->getStoreBranchToClientDistance());

        // Check if order is cash, and if the captain paid the order cost on behalf of the client
        $orderCashAmount = $this->checkAndGetOrderCashAmountByOrderEntity($order);

        if (($orderCashAmount === OrderResultConstant::ORDER_CARD_PAYMENT_CONST)
            || (OrderResultConstant::ORDER_HAS_PAY_CONFLICT_ANSWER_CONST)) {
            $orderCashAmount = 0.0;
        }

        // Check if there is financial due for the day similar to the creation day of the order
        // if exists, then update it, if not, create a new one
        $date = $this->getDateTimeObjectFromDateTimeInterface($order->getCreatedAt());

        $captainFinancialDaily = $this->checkIfCaptainFinancialDailyExistForSpecificDay($date);

        if ($captainFinancialDaily === CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST) {
            // create new captain financial daily
            return $this->createCaptainFinancialDaily($order->getCaptainId(), $orderFinancialValuesArrayResult[0], $orderCashAmount,
                $captainFinancialSystemDetail['captainFinancialSystemType'], CaptainFinancialDailyIsPaidConstant::CAPTAIN_FINANCIAL_DAILY_IS_NOT_PAID_CONST,
                $orderFinancialValuesArrayResult[2], $orderFinancialValuesArrayResult[1], null);
        }

        // update existing captain financial daily
        return $this->updateCaptainFinancialDailyAmount($captainFinancialDaily->getId(), $orderFinancialValuesArrayResult[0],
            $orderCashAmount, $orderFinancialValuesArrayResult[2], $orderFinancialValuesArrayResult[1]);
    }
}
