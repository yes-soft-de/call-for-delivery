<?php

namespace App\Manager\Subscription;

use App\AutoMapping;
use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\Subscription\SubscriptionDetailsConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\SubscriptionEntity;
use App\Repository\SubscriptionDetailsEntityRepository;
use App\Request\Subscription\SubscriptionDetailsCreateRequest;
use App\Request\Subscription\SubscriptionStatusUpdateRequest;
use App\Request\Subscription\SubscriptionUpdateRequest;
use App\Request\Subscription\SubscriptionRemainingOrdersUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class SubscriptionDetailsManager
{
    /**
     * @param AutoMapping $autoMapping
     * @param EntityManagerInterface $entityManager
     * @param SubscriptionDetailsEntityRepository $subscribeDetailsRepository
     */
    public function __construct(private AutoMapping $autoMapping, private EntityManagerInterface $entityManager, private SubscriptionDetailsEntityRepository $subscribeDetailsRepository)
    {
    }

    public function createSubscriptionDetails(SubscriptionEntity $subscription, $hasExtra): SubscriptionDetailsEntity
    { 
        $request = new SubscriptionDetailsCreateRequest();

        $request->setStoreOwner($subscription->getStoreOwner());
        $request->setLastSubscription($subscription);
      
        $request->setRemainingCars($subscription->getPackage()->getCarCount());
        $request->setRemainingOrders($subscription->getPackage()->getOrderCount());
        $request->setStatus($subscription->getStatus());
        $request->setHasExtra($hasExtra);
        //default value for extra  time is zero
        $request->setRemainingTime(0);

        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(["storeOwner" => $subscription->getStoreOwner()]);
        if($subscriptionDetailsEntity) {
       
            return $this->updateSubscriptionDetails($request, $subscriptionDetailsEntity);
        }
       
        $subscriptionDetailsEntity = $this->autoMapping->map(SubscriptionDetailsCreateRequest::class, SubscriptionDetailsEntity::class, $request);
      
        $this->entityManager->persist($subscriptionDetailsEntity);
        $this->entityManager->flush();
 
        return $subscriptionDetailsEntity;
    }

    public function updateSubscriptionDetails(SubscriptionDetailsCreateRequest $request, SubscriptionDetailsEntity $subscriptionDetailsEntity): SubscriptionDetailsEntity
    {     
        $subscriptionDetailsEntity = $this->autoMapping->mapToObject(SubscriptionDetailsCreateRequest::class, SubscriptionDetailsEntity::class, $request, $subscriptionDetailsEntity);
       
        $this->entityManager->flush();
 
        return $subscriptionDetailsEntity;
    }

    public function updateSubscriptionDetailsState($id, $status): ?array
    {     
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(["lastSubscription" => $id]);

        $subscriptionDetailsEntity->setStatus($status);

        // Why we need this?
        $subscriptionDetailsEntity = $this->autoMapping->map(SubscriptionUpdateRequest::class, SubscriptionDetailsEntity::class, $subscriptionDetailsEntity);
       
        $this->entityManager->flush();
 
        return $subscriptionDetailsEntity;
    }

    public function updateRemainingOrders($id, $orderRemaining): SubscriptionDetailsEntity|int
    {   
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(["lastSubscription" => $id]);

        if (! $subscriptionDetailsEntity) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        $subscriptionDetailsEntity->setRemainingOrders($orderRemaining);

        // Following line commented by Rami because it makes no sense
        //$subscriptionDetailsEntity = $this->autoMapping->map(SubscriptionRemainingOrdersUpdateRequest::class, SubscriptionDetailsEntity::class, $subscriptionDetailsEntity);
       
        $this->entityManager->flush();
 
        return $subscriptionDetailsEntity;
    }

    public function updateRemainingTime($subscriptionId, $remainingTime): ?subscriptionDetailsEntity
    {   
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(["lastSubscription" => $subscriptionId]);
       
        $subscriptionDetailsEntity->setRemainingTime($remainingTime);

        $this->entityManager->flush();
 
        return $subscriptionDetailsEntity;
    }

    public function getSubscriptionCurrent($storeOwner): ?SubscriptionDetailsEntity
    {   
        return $this->subscribeDetailsRepository->findOneBy(['storeOwner' => $storeOwner]);
    }

    public function getSubscriptionCurrentActive($storeOwner): ?array
    {   
        return $this->subscribeDetailsRepository->getSubscriptionCurrentActive($storeOwner);
    }
    
    public function updateHasExtra(SubscriptionEntity $subscribeEntity, bool $hasExtra): ?SubscriptionDetailsEntity
    {     
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(["lastSubscription" => $subscribeEntity]);
        
        if(!$subscriptionDetailsEntity) {
     
            return $subscriptionDetailsEntity;
        }

        $subscriptionDetailsEntity->setHasExtra($hasExtra);

        $this->entityManager->flush();
 
        return $subscriptionDetailsEntity;
    }
    
    public function updateRemainingCars(int $id, int $remainingCars): ?SubscriptionDetailsEntity 
    {   
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(["lastSubscription" => $id]);

        $subscriptionDetailsEntity->setRemainingCars($remainingCars);
             
        $this->entityManager->flush();

        return $subscriptionDetailsEntity;
    }

    public function updateSubscriptionDetailsByAdmin(SubscriptionEntity $subscription, int $oldPackageOrderCount): ?SubscriptionDetailsEntity
    {     
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(["lastSubscription" => $subscription->getId()]);
     
        $subscriptionDetailsEntity->setRemainingCars($subscription->getPackage()->getCarCount());

        // *** calculate remaining orders of the new subscription ***
        // remaining orders = orderCount of the new package - consumed orders from previous subscription
        // consumed orders from previous subscription = orderCount of old package - remaining orders from old subscription
        $subscriptionDetailsEntity->setRemainingOrders($subscription->getPackage()->getOrderCount() - ($oldPackageOrderCount - $subscriptionDetailsEntity->getRemainingOrders()));

        $this->entityManager->flush();
 
        return $subscriptionDetailsEntity;
    }

    public function deleteSubscriptionDetailsByStoreOwnerId(int $storeOwnerId): array
    {
        $subscriptionDetailsResults = $this->subscribeDetailsRepository->getSubscriptionDetailsByStoreOwnerId($storeOwnerId);

        if (! empty($subscriptionDetailsResults)) {
            foreach ($subscriptionDetailsResults as $result) {
                $result->setLastSubscription(null);
                $result->setStoreOwner(new StoreOwnerProfileEntity());
                $this->entityManager->remove($result);
                $this->entityManager->flush();
            }
        }

        return $subscriptionDetailsResults;
    }

    public function getSubscriptionDetailsEntityByLastSubscriptionId(int $subscriptionId): array
    {
        return $this->subscribeDetailsRepository->getSubscriptionDetailsEntityByLastSubscriptionId($subscriptionId);
    }

    public function deleteSubscriptionDetailsBySubscriptionId(int $subscriptionId): ?SubscriptionDetailsEntity
    {
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(['lastSubscription'=>$subscriptionId]);

        if (! $subscriptionDetailsEntity) {
            return $subscriptionDetailsEntity;
        }

        $subscriptionDetailsEntity->setLastSubscription(null);
        $subscriptionDetailsEntity->setStoreOwner(new StoreOwnerProfileEntity());

        $this->entityManager->remove($subscriptionDetailsEntity);
        $this->entityManager->flush();

        return $subscriptionDetailsEntity;
    }

    /**
     * Update subscription details status depending on subscription id
     */
    public function updateSubscriptionDetailsStatusBySubscriptionId(SubscriptionStatusUpdateRequest $request): SubscriptionDetailsEntity|int
    {
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(['lastSubscription' => $request->getId()]);

        if (! $subscriptionDetailsEntity) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        $subscriptionDetailsEntity->setStatus($request->getStatus());

        $this->entityManager->flush();

        return $subscriptionDetailsEntity;
    }

    public function getSubscriptionDetailsByStoreOwnerProfileId(int $storeOwnerProfileId): ?SubscriptionDetailsEntity
    {
        return $this->subscribeDetailsRepository->findOneBy(['storeOwner' => $storeOwnerProfileId]);
    }

    public function updateRemainingOrdersOfStoreSubscriptionBySubscriptionDetailsId(int $subscriptionDetailsId, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(['id' => $subscriptionDetailsId]);

        if (! $subscriptionDetailsEntity) {
            return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
        }

        if ($operationType === SubscriptionConstant::OPERATION_TYPE_ADDITION) {
            $subscriptionDetailsEntity->setRemainingOrders(
                $subscriptionDetailsEntity->getRemainingOrders() + $factor
            );

        } elseif ($operationType === SubscriptionConstant::OPERATION_TYPE_ADDITION) {
            $subscriptionDetailsEntity->setRemainingOrders(
                $subscriptionDetailsEntity->getRemainingOrders() - $factor
            );
        }

        $this->entityManager->flush();

        return $subscriptionDetailsEntity;
    }

    public function updateRemainingCarsOfStoreSubscriptionBySubscriptionDetailsId(int $subscriptionDetailsId, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(['id' => $subscriptionDetailsId]);

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
}
