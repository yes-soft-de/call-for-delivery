<?php

namespace App\Manager\Subscription;

use App\AutoMapping;
use App\Entity\SubscriptionEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Repository\SubscriptionEntityRepository;
use App\Request\Subscription\SubscriptionCreateRequest;
use App\Request\Subscription\SubscriptionUpdateRequest;
use App\Request\Subscription\SubscriptionUpdateIsFutureRequest;
use Doctrine\ORM\EntityManagerInterface;
use DateTime;
use App\Manager\Package\PackageManager;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Manager\Subscription\SubscriptionDetailsManager;
use App\Manager\Subscription\SubscriptionHistoryManager;
use App\Constant\Subscription\SubscriptionConstant;

class SubscriptionManager
{  
    public function __construct(private AutoMapping $autoMapping, private EntityManagerInterface $entityManager, private SubscriptionEntityRepository $subscribeRepository, private PackageManager $packageManager, private StoreOwnerProfileManager $storeOwnerProfileManager, private SubscriptionDetailsManager $subscriptionDetailsManager, private SubscriptionHistoryManager $subscriptionHistoryManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->subscribeRepository = $subscribeRepository;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
        $this->packageManager = $packageManager;
        $this->subscriptionDetailsManager = $subscriptionDetailsManager;
        $this->subscriptionHistoryManager = $subscriptionHistoryManager;
    }

    public function createSubscription(SubscriptionCreateRequest $request): ?SubscriptionEntity
    { 
        // change to SUBSCRIBE_INACTIVE
       $request->setStatus(SubscriptionConstant::SUBSCRIBE_ACTIVE);

       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($request->getStoreOwner());
       $request->setStoreOwner($storeOwner);

       $package = $this->packageManager->getPackage($request->getPackage());
       $request->setPackage($package);

       $storeOwnerProfile = $this->storeOwnerProfileManager->getStoreOwnerProfile($request->getStoreOwner());
       $request->setStoreOwner($storeOwnerProfile);
      
       $subscriptionEntity = $this->autoMapping->map(SubscriptionCreateRequest::class, SubscriptionEntity::class, $request);
       $subscriptionEntity->setStartDate(new DateTime());
   
       $subscriptionEntity->setEndDate($this->calculatingSubscriptionExpiryDate($subscriptionEntity->getStartDate(), $package->getExpired()));

       $this->entityManager->persist($subscriptionEntity);
       $this->entityManager->flush();

       if($subscriptionEntity->getIsFuture() === false) {

          $this->subscriptionDetailsManager->createSubscriptionDetails($subscriptionEntity);
       }
      
       $this->subscriptionHistoryManager->createSubscriptionHistory($subscriptionEntity);            

       return $subscriptionEntity;
    }

    public function getSubscriptionCurrent($storeOwner): ?SubscriptionDetailsEntity
    {
       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($storeOwner);

       return $this->subscriptionDetailsManager->getSubscriptionCurrent($storeOwner);
    }

    public function updateRemainingOrders($id, $remainingOrders): ?array
    {
       return $this->subscriptionDetailsManager->updateRemainingOrders($id, $remainingOrders);
    }

    public function updateRemainingTime($id, $remainingTime): ?array
    {
       return $this->subscriptionDetailsManager->updateRemainingTime($id, $remainingTime);
    }

    public function getSubscriptionCurrentWithRelation($storeOwner)
    {
       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($storeOwner);

       return $this->subscribeRepository->getSubscriptionCurrentWithRelation($storeOwner);
       
    }

    public function getSubscriptionForNextTime($storeOwner)
    {
       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($storeOwner);

       return $this->subscribeRepository->getSubscriptionForNextTime($storeOwner);       
    }

    public function getSubscriptionsForStoreOwner($storeOwner): ?array
    {
       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($storeOwner);
     
       return $this->subscribeRepository->getSubscriptionsForStoreOwner($storeOwner);
    }

    public function updateSubscribeState($id, $status): string
    {
        $subscribeEntity = $this->subscribeRepository->find($id);
        
        $subscribeEntity->setStatus($status);

        if ($subscribeEntity) {

            $this->autoMapping->map(SubscriptionUpdateRequest::class, SubscriptionEntity::class, $subscribeEntity);

            $this->entityManager->flush();
          
            $this->subscriptionDetailsManager->updateSubscriptionDetailsState($id, $status);
            
            return SubscriptionConstant::UPDATE_STATE;
        }

        return SubscriptionConstant::ERROR;
    }

    public function updateIsFutureAndSubscriptionCurrent($id, $isFuture): string
    {
        $subscribeEntity = $this->subscribeRepository->find($id);
        
        $subscribeEntity->setIsFuture($isFuture);

        if ($subscribeEntity) {

            $this->autoMapping->map(SubscriptionUpdateIsFutureRequest::class, SubscriptionEntity::class, $subscribeEntity);

            $this->entityManager->flush();
          
            $this->subscriptionDetailsManager->createSubscriptionDetails($subscribeEntity);           
            
            return SubscriptionConstant::UPDATE_STATE;
        }

        return SubscriptionConstant::ERROR;
    }

    public function calculatingSubscriptionExpiryDate($startDate, $days)
    {
        $days = $days.'day';
       
        return new DateTime($startDate->format('Y-m-d h:i:s') . $days); 
    }

    public function updateEndDate($id, $endDate, $note): ?SubscriptionEntity
    {
        $subscriptionEntity = $this->subscribeRepository->find($id);
      
        $subscriptionEntity->setEndDate($endDate);

        $this->entityManager->flush();
 
        $this->subscriptionDetailsManager->updateRemainingTime($id, 0);
       
        $this->subscriptionHistoryManager->updateNoteSubscriptionHistory($id, $note);            
       
        return $subscriptionEntity;
    }
}
