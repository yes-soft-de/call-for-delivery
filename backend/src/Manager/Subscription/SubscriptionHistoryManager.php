<?php

namespace App\Manager\Subscription;

use App\AutoMapping;
use App\Entity\SubscriptionHistoryEntity;
use App\Repository\SubscriptionHistoryEntityRepository;
use App\Request\Subscription\SubscriptionHistoryCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use DateTime;

class SubscriptionHistoryManager
{
    public function __construct(private AutoMapping $autoMapping, private EntityManagerInterface $entityManager, private SubscriptionHistoryEntityRepository $subscribeHistoryRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->subscribeHistoryRepository = $subscribeHistoryRepository;
    }

    public function createSubscriptionHistory($subscription):SubscriptionHistoryEntity
    { 
        $request = new SubscriptionHistoryCreateRequest();
       
        $request->setStoreOwner($subscription->getStoreOwner());
        $request->setSubscription($subscription);
       
        $subscriptionHistoryEntity = $this->autoMapping->map(SubscriptionHistoryCreateRequest::class, SubscriptionHistoryEntity::class, $request);
        
        $subscriptionHistoryEntity->setCreatedAt(new DateTime());
        
        $this->entityManager->persist($subscriptionHistoryEntity);
        $this->entityManager->flush();
 
        return $subscriptionHistoryEntity;
    }
}
