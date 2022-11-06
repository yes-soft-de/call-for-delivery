<?php

namespace App\Manager\SuperAdmin\Order;

use App\Constant\Order\OrderAmountCashConstant;
use App\Constant\Order\OrderConflictedAnswersResolvedByConstant;
use App\Constant\Order\OrderHasPayConflictAnswersConstant;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Payment\PaymentConstant;
use App\Repository\OrderEntityRepository;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;

class SuperAdminOrderManager
{
    private EntityManagerInterface $entityManager;
    private OrderEntityRepository $orderEntityRepository;

    public function __construct(EntityManagerInterface $entityManager, OrderEntityRepository $orderEntityRepository)
    {
        $this->entityManager = $entityManager;
        $this->orderEntityRepository = $orderEntityRepository;
    }

    /**
     * This function for one-time use only
     * Update isCaptainPaidToProvider by super admin to 1 (captain paid the cash order payment to the store) for order
     * which meet following condition:
     *      state = delivered
     *      payment = cash
     *      createdAt < specific date (currently: 2022-08-28)
     */
    public function updateIsCashPaymentConfirmedByStoreForSpecificOrdersByOrderCommand(): array
    {
        $ordersEntities = $this->orderEntityRepository->getNotConfirmedCashPaymentOrdersBeforeSpecificDate( new \DateTime('2022-08-28'));

        if (count($ordersEntities) > 0) {
            foreach ($ordersEntities as $orderEntity) {
                $orderEntity->setIsCashPaymentConfirmedByStore(OrderAmountCashConstant::ORDER_PAID_FLAG_YES);
                $orderEntity->setIsCashPaymentConfirmedByStoreUpdateDate(new \DateTime('now'));

                $orderEntity->setHasPayConflictAnswers(OrderHasPayConflictAnswersConstant::ORDER_PAYMENT_CONFLICT_ANSWER_RESOLVED_BY_COMMAND);

                $this->entityManager->flush();
            }
        }

        return $ordersEntities;
    }

    public function updateOrderHasPayConflictAnswersByCommand(): array
    {
        $ordersArray = $this->orderEntityRepository->getCashPaymentAnsweredOrdersBeforeSpecificDate();

        if (count($ordersArray) > 0) {
            foreach ($ordersArray as $orderEntity) {
                if ($orderEntity->getCreatedAt() < new DateTime('2022-08-28')) {
                    $orderEntity->setHasPayConflictAnswers(OrderHasPayConflictAnswersConstant::ORDER_PAYMENT_CONFLICT_ANSWER_RESOLVED_BY_COMMAND);

                } else {
                    if (($orderEntity->getIsCashPaymentConfirmedByStore()) && ($orderEntity->getPaidToProvider())
                        && ($orderEntity->getIsCashPaymentConfirmedByStore() != $orderEntity->getPaidToProvider())) {
                        $orderEntity->setHasPayConflictAnswers(OrderHasPayConflictAnswersConstant::ORDER_HAS_PAYMENT_CONFLICT_ANSWERS);

                    } elseif (($orderEntity->getIsCashPaymentConfirmedByStore()) && ($orderEntity->getPaidToProvider())
                        && ($orderEntity->getIsCashPaymentConfirmedByStore() === $orderEntity->getPaidToProvider())) {
                        $orderEntity->setHasPayConflictAnswers(OrderHasPayConflictAnswersConstant::ORDER_DOES_NOT_HAVE_PAYMENT_CONFLICT_ANSWERS);

                        $orderEntity->setConflictedAnswersResolvedBy(OrderConflictedAnswersResolvedByConstant::CONFLICTED_ANSWERS_RESOLVED_BY_COMMAND_CONST);
                    }
                }

                $this->entityManager->flush();
            }
        }

        return $ordersArray;
    }
}
