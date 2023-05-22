<?php

namespace App\Manager\OrderDistanceConflict;

use App\AutoMapping;
use App\Constant\User\UserTypeConstant;
use App\Entity\OrderDistanceConflictEntity;
use App\Repository\OrderDistanceConflictEntityRepository;
use App\Request\OrderDistanceConflict\OrderDistanceConflictCreateByCaptainRequest;
use Doctrine\ORM\EntityManagerInterface;

class OrderDistanceConflictManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private OrderDistanceConflictEntityRepository $orderDistanceConflictEntityRepository
    )
    {
    }

    /**
     * Return an order distance conflict object by order id
     */
    public function getOrderDistanceConflictByOrderId(int $orderId): ?OrderDistanceConflictEntity
    {
        return $this->orderDistanceConflictEntityRepository->findOneBy(['orderId' => $orderId]);
    }

    /**
     * Creates an order distance conflict by captain
     */
    public function createOrderDistanceConflictByCaptain(OrderDistanceConflictCreateByCaptainRequest $request)
    {
        $orderDistanceConflictEntity = $this->autoMapping->map(OrderDistanceConflictCreateByCaptainRequest::class,
            OrderDistanceConflictEntity::class, $request);

        $orderDistanceConflictEntity->setConflictIssuedByUserType(UserTypeConstant::CAPTAIN_USER_TYPE_CONST);

        $this->entityManager->persist($orderDistanceConflictEntity);
        $this->entityManager->flush();

        return $orderDistanceConflictEntity;
    }
}
