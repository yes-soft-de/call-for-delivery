<?php

namespace App\Manager\SuperAdmin\Order;

use App\Constant\Order\OrderAmountCashConstant;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Payment\PaymentConstant;
use App\Repository\OrderEntityRepository;
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
     */
    public function updateIsCashPaymentConfirmedByStoreForSpecificOrdersByOrderCommand(): array
    {
        $ordersEntities = $this->orderEntityRepository->getNotConfirmedCashPaymentOrdersBeforeSpecificDate( new \DateTime('2022-08-28'));

        if (count($ordersEntities) > 0) {
            foreach ($ordersEntities as $orderEntity) {
                $orderEntity->setIsCashPaymentConfirmedByStore(OrderAmountCashConstant::ORDER_PAID_FLAG_YES);
                $orderEntity->setIsCashPaymentConfirmedByStoreUpdateDate(new \DateTime('now'));

                $this->entityManager->flush();
            }
        }

        return $ordersEntities;
    }
}
