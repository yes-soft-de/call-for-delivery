<?php

namespace App\Manager\Subscription;

use App\AutoMapping;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\SubscriptionEntity;
use App\Repository\SubscriptionDetailsEntityRepository;
use App\Request\Subscription\SubscriptionDetailsCreateRequest;
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

        $subscriptionDetailsEntity = $this->autoMapping->map(SubscriptionUpdateRequest::class, SubscriptionDetailsEntity::class, $subscriptionDetailsEntity);
       
        $this->entityManager->flush();
 
        return $subscriptionDetailsEntity;
    }

    public function updateRemainingOrders($id, $orderRemaining): ?array
    {   
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(["lastSubscription" => $id]);

        $subscriptionDetailsEntity->setRemainingOrders($orderRemaining);

        $subscriptionDetailsEntity = $this->autoMapping->map(SubscriptionRemainingOrdersUpdateRequest::class, SubscriptionDetailsEntity::class, $subscriptionDetailsEntity);
       
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

    public function updateSubscriptionDetailsByAdmin(SubscriptionEntity $subscription)
    {     
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(["lastSubscription" => $subscription->getId()]);
     
        $subscriptionDetailsEntity->setRemainingCars($subscription->getPackage()->getCarCount());
        $subscriptionDetailsEntity->setRemainingOrders($subscription->getPackage()->getOrderCount());

        $this->entityManager->flush();
 
        return $subscriptionDetailsEntity;
    }
}
