<?php

namespace App\Manager\Admin\StoreOwnerSubscription;

use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\Subscription\SubscriptionDetailsConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Repository\SubscriptionDetailsEntityRepository;
use App\Request\Subscription\SubscriptionStatusUpdateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminSubscriptionDetailsManager
{
    private EntityManagerInterface $entityManager;
    private SubscriptionDetailsEntityRepository $subscriptionDetailsEntityRepository;

    public function __construct(EntityManagerInterface $entityManager, SubscriptionDetailsEntityRepository $subscriptionDetailsEntityRepository)
    {
        $this->entityManager = $entityManager;
        $this->subscriptionDetailsEntityRepository = $subscriptionDetailsEntityRepository;
    }
    
    public function deleteSubscriptionDetailsBySubscriptionId(int $subscriptionId): ?SubscriptionDetailsEntity
    {
        $subscriptionDetailsEntity = $this->subscriptionDetailsEntityRepository->findOneBy(['lastSubscription' => $subscriptionId]);
       

        if ($subscriptionDetailsEntity) {
            $subscriptionDetailsEntity->setLastSubscription(null);
            $subscriptionDetailsEntity->setStoreOwner(null);
            
            $this->entityManager->remove($subscriptionDetailsEntity);
            $this->entityManager->flush();
        }
        return $subscriptionDetailsEntity;
    }

    public function getSubscriptionCurrentActive(StoreOwnerProfileEntity $storeOwner): ?array
    {
        return $this->subscriptionDetailsEntityRepository->getSubscriptionCurrentActive($storeOwner);
    }

    public function getSubscriptionDetailsByStoreOwnerProfileIdForAdmin(int $storeOwnerProfileId): ?SubscriptionDetailsEntity
    {
        return $this->subscriptionDetailsEntityRepository->findOneBy(['storeOwner' => $storeOwnerProfileId]);
    }

    public function updateRemainingCarsOfStoreSubscriptionBySubscriptionDetailsId(int $subscriptionDetailsId, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        $subscriptionDetailsEntity = $this->subscriptionDetailsEntityRepository->findOneBy(['id' => $subscriptionDetailsId]);

        if (! $subscriptionDetailsEntity) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        if ($operationType === SubscriptionConstant::OPERATION_TYPE_ADDITION) {
            $subscriptionDetailsEntity->setRemainingCars(
              $subscriptionDetailsEntity->getRemainingCars() + $factor
            );

        } elseif ($operationType === SubscriptionConstant::OPERATION_TYPE_ADDITION) {
            $subscriptionDetailsEntity->setRemainingCars(
                $subscriptionDetailsEntity->getRemainingCars() - $factor
            );
        }

        $this->entityManager->flush();

        return $subscriptionDetailsEntity;
    }

    public function updateRemainingOrdersOfStoreSubscriptionBySubscriptionDetailsId(int $subscriptionDetailsId, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        $subscriptionDetailsEntity = $this->subscriptionDetailsEntityRepository->findOneBy(['id' => $subscriptionDetailsId]);

        if (! $subscriptionDetailsEntity) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        if ($operationType === SubscriptionConstant::OPERATION_TYPE_ADDITION) {
            $subscriptionDetailsEntity->setRemainingOrders(
                $subscriptionDetailsEntity->getRemainingOrders() + $factor
            );

        } elseif ($operationType === SubscriptionConstant::OPERATION_TYPE_SUBTRACTION) {
            $subscriptionDetailsEntity->setRemainingOrders(
                $subscriptionDetailsEntity->getRemainingOrders() - $factor
            );
        }

        $this->entityManager->flush();

        return $subscriptionDetailsEntity;
    }

    public function getSubscriptionDetailsBySubscriptionIdAndSpecificGroupOfStatusForAdmin(int $subscriptionId, array $statusArray): ?SubscriptionDetailsEntity
    {
        return $this->subscriptionDetailsEntityRepository->findOneBy(['lastSubscription' => $subscriptionId, 'status' => $statusArray]);
    }

    public function updateCurrentSubscriptionDetailsStatus(SubscriptionStatusUpdateByAdminRequest $request): SubscriptionDetailsEntity|int
    {
        $subscriptionDetailsEntity = $this->subscriptionDetailsEntityRepository->findOneBy(['id' => $request->getId()]);

        if (! $subscriptionDetailsEntity) {
            return SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST;
        }

        $subscriptionDetailsEntity->setStatus($request->getStatus());

        $this->entityManager->flush();

        return $subscriptionDetailsEntity;
    }

    public function getCurrentSubscriptionIdBySubscriptionDetailsId(int $subscriptionDetailsId): ?int
    {
        $subscriptionDetailsEntity = $this->subscriptionDetailsEntityRepository->findOneBy(['id' => $subscriptionDetailsId]);

        if (! $subscriptionDetailsEntity) {
            return SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST;
        }

        return $subscriptionDetailsEntity->getId();
    }
}
