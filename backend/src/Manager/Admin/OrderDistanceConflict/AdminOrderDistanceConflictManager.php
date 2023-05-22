<?php

namespace App\Manager\Admin\OrderDistanceConflict;

use App\AutoMapping;
use App\Constant\OrderDistanceConflict\OrderDistanceConflictResolveTypeConstant;
use App\Constant\OrderDistanceConflict\OrderDistanceConflictResultConstant;
use App\Constant\User\UserTypeConstant;
use App\Entity\OrderDistanceConflictEntity;
use App\Repository\OrderDistanceConflictEntityRepository;
use App\Request\Admin\OrderDistanceConflict\OrderDistanceConflictFilterByAdminRequest;
use App\Request\Admin\OrderDistanceConflict\OrderDistanceConflictRefuseByAdminRequest;
use App\Request\Admin\OrderDistanceConflict\OrderDistanceConflictUpdateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminOrderDistanceConflictManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private OrderDistanceConflictEntityRepository $orderDistanceConflictEntityRepository
    )
    {
    }

    /**
     * Updates order distance conflict by admin after either new destination is used or a distance is added
     */
    public function updateOrderDistanceConflictByAdmin(OrderDistanceConflictUpdateByAdminRequest $request): OrderDistanceConflictEntity|int
    {
        $orderDistanceConflictEntity = $this->orderDistanceConflictEntityRepository->findOneBy(['orderId' => $request->getOrderId()]);

        if (! $orderDistanceConflictEntity) {
            return OrderDistanceConflictResultConstant::ORDER_DISTANCE_CONFLICT_NOT_EXIST_CONST;
        }

        $orderDistanceConflictEntity = $this->autoMapping->mapToObject(OrderDistanceConflictUpdateByAdminRequest::class,
            OrderDistanceConflictEntity::class, $request, $orderDistanceConflictEntity);

        $orderDistanceConflictEntity->setIsResolved(true);
        $orderDistanceConflictEntity->setConflictResolvedByUserType(UserTypeConstant::ADMIN_USER_TYPE_CONST);

        $this->entityManager->flush();

        return $orderDistanceConflictEntity;
    }

    /**
     * Updates order distance conflict by refusing it by admin
     */
    public function refuseOrderDistanceConflictByAdmin(OrderDistanceConflictRefuseByAdminRequest $request): OrderDistanceConflictEntity|int
    {
        $orderDistanceConflictEntity = $this->orderDistanceConflictEntityRepository->findOneBy(['id' => $request->getId()]);

        if (! $orderDistanceConflictEntity) {
            return OrderDistanceConflictResultConstant::ORDER_DISTANCE_CONFLICT_NOT_EXIST_CONST;
        }

        $orderDistanceConflictEntity = $this->autoMapping->mapToObject(OrderDistanceConflictRefuseByAdminRequest::class,
            OrderDistanceConflictEntity::class, $request, $orderDistanceConflictEntity);

        $orderDistanceConflictEntity->setIsResolved(true);
        $orderDistanceConflictEntity->setConflictResolvedByUserType(UserTypeConstant::ADMIN_USER_TYPE_CONST);
        $orderDistanceConflictEntity->setResolvedAt(new \DateTime('now'));
        $orderDistanceConflictEntity->setResolveType(OrderDistanceConflictResolveTypeConstant::CONFLICT_RESOLVED_BY_REJECTING_BY_ADMIN_CONST);

        $this->entityManager->flush();

        return $orderDistanceConflictEntity;
    }

    /**
     * Filters orders distance conflicts by admin
     */
    public function filterOrderDistanceConflictByAdmin(OrderDistanceConflictFilterByAdminRequest $request)
    {
        return $this->orderDistanceConflictEntityRepository->filterOrderDistanceConflictByAdmin($request);
    }
}
