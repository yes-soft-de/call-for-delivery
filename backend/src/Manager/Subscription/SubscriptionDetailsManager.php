<?php

namespace App\Manager\Subscription;

use App\AutoMapping;
use App\Entity\SubscriptionDetailsEntity;
use App\Repository\SubscriptionDetailsEntityRepository;
use App\Request\Subscription\SubscriptionDetailsCreateRequest;
use App\Request\Subscription\SubscriptionUpdateRequest;
use App\Request\Subscription\SubscriptionRemainingOrdersUpdateRequest;
use App\Request\Subscription\SubscriptionRemainingTimeUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class SubscriptionDetailsManager
{
    public function __construct(private AutoMapping $autoMapping, private EntityManagerInterface $entityManager, private SubscriptionDetailsEntityRepository $subscribeDetailsRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->subscribeDetailsRepository = $subscribeDetailsRepository;
    }

    public function createSubscriptionDetails($subscription):SubscriptionDetailsEntity
    { 
        $request = new SubscriptionDetailsCreateRequest();

        $request->setStoreOwner($subscription->getStoreOwner());
        $request->setLastSubscription($subscription);
      
        $request->setRemainingCars($subscription->getPackage()->getCarCount());
        $request->setRemainingOrders($subscription->getPackage()->getOrderCount());
        $request->setStatus($subscription->getStatus());
        $request->setRemainingTime($subscription->getPackage()->getExpired());

        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(["storeOwner" => $subscription->getStoreOwner()]);
        if($subscriptionDetailsEntity) {
       
            return $this->updateSubscriptionDetails($request, $subscriptionDetailsEntity);
        }
       
        $subscriptionDetailsEntity = $this->autoMapping->map(SubscriptionDetailsCreateRequest::class, SubscriptionDetailsEntity::class, $request);
       
        $this->entityManager->persist($subscriptionDetailsEntity);
        $this->entityManager->flush();
 
        return $subscriptionDetailsEntity;
    }

    public function updateSubscriptionDetails(SubscriptionDetailsCreateRequest $request, $subscriptionDetailsEntity):SubscriptionDetailsEntity
    {     
        $subscriptionDetailsEntity = $this->autoMapping->mapToObject(SubscriptionDetailsCreateRequest::class, SubscriptionDetailsEntity::class, $request, $subscriptionDetailsEntity);
       
        $this->entityManager->flush();
 
        return $subscriptionDetailsEntity;
    }

    public function updateSubscriptionDetailsState($id, $status):?array
    {     
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(["lastSubscription" => $id]);

        $subscriptionDetailsEntity->setStatus($status);

        $subscriptionDetailsEntity = $this->autoMapping->map(SubscriptionUpdateRequest::class, SubscriptionDetailsEntity::class, $subscriptionDetailsEntity);
       
        $this->entityManager->flush();
 
        return $subscriptionDetailsEntity;
    }

    public function updateRemainingOrders($id, $orderRemaining):?array
    {     
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(["lastSubscription" => $id]);

        $subscriptionDetailsEntity->setRemainingOrders($orderRemaining);

        $subscriptionDetailsEntity = $this->autoMapping->map(SubscriptionRemainingOrdersUpdateRequest::class, SubscriptionDetailsEntity::class, $subscriptionDetailsEntity);
       
        $this->entityManager->flush();
 
        return $subscriptionDetailsEntity;
    }

    public function updateRemainingTime($id, $remainingTime):?array
    {   
        $subscriptionDetailsEntity = $this->subscribeDetailsRepository->findOneBy(["lastSubscription" => $id]);
        
        $days = intval($remainingTime);
      
        $subscriptionDetailsEntity->setRemainingTime($days);

        $subscriptionDetailsEntity = $this->autoMapping->map(SubscriptionRemainingTimeUpdateRequest::class, SubscriptionDetailsEntity::class, $subscriptionDetailsEntity);
       
        $this->entityManager->flush();
 
        return $subscriptionDetailsEntity;
    }

    public function getSubscriptionCurrent($storeOwner):?SubscriptionDetailsEntity
    {     
        return $this->subscribeDetailsRepository->findOneBy(['storeOwner' => $storeOwner]);
    }
}
