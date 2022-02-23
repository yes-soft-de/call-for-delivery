<?php

namespace App\Manager\Subscription;

use App\AutoMapping;
use App\Entity\SubscriptionEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Repository\SubscriptionEntityRepository;
use App\Request\Subscription\SubscriptionCreateRequest;
use App\Request\Subscription\SubscriptionChangeIsFutureRequest;
use App\Request\Subscription\SubscriptionUpdateRequest;
use App\Request\Subscription\SubscriptionUpdateIsFutureRequest;
use Doctrine\ORM\EntityManagerInterface;
use DateTime;
use App\Manager\Package\PackageManager;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Manager\Subscription\SubscriptionDetailsManager;
use App\Manager\Subscription\SubscriptionHistoryManager;
use App\Constant\Subscription\SubscriptionConstant;
use Doctrine\ORM\NonUniqueResultException;

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

    public function getSubscriptionsForStoreOwner($storeOwner): array
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

















    // public function subscriptionUpdateState(SubscriptionUpdateStateRequest $request)
    // {
    //     $subscribeEntity = $this->subscribeRepository->find($request->getId());
    //     $subscribeEntity->setEndDate(date_modify(new DateTime('now'),'+1 month'));

    //     if (!$subscribeEntity) {
    //         return null;
    //     }

    //     $subscribeEntity = $this->autoMapping->mapToObject(SubscriptionUpdateStateRequest::class, SubscriptionEntity::class, $request, $subscribeEntity);

    //     $this->entityManager->flush();

    //     return $subscribeEntity;
    // }


    public function changeIsFutureToFalse($id)
    {
        $subscribeEntity = $this->subscribeRepository->find($id);
    //Make this subscription the current subscription
        $subscribeEntity->setIsFuture(0);
    //The end date of the previous subscription is the start date of the current subscription
        $subscribeEntity->setStartDate(new DateTime('now'));

        $subscribeEntity->setEndDate(date_modify(new DateTime('now'),'+1 month'));

        if (!$subscribeEntity) {
            return null;
        }

        $subscribeEntity = $this->autoMapping->map(SubscriptionChangeIsFutureRequest::class, SubscriptionEntity::class, $subscribeEntity);

        $this->entityManager->flush();

        return $subscribeEntity;
    }

    public function getSubscriptionsPending()
    {
        return $this->subscribeRepository->getSubscriptionsPending();
    }

    public function getSubscriptionById($id)
    {
        return $this->subscribeRepository->getSubscriptionById($id);
    }

    /**
     * @param $id
     * @return mixed
     * @throws NonUniqueResultException
     */
    public function subscriptionIsActive($id):mixed
    {
        return $this->subscribeRepository->subscriptionIsActive($id);
    }

    public function countpendingContracts()
    {
        return $this->subscribeRepository->countpendingContracts();
    }

    public function countDoneContracts()
    {
        return $this->subscribeRepository->countDoneContracts();
    }

    public function countCancelledContracts()
    {
        return $this->subscribeRepository->countCancelledContracts();
    }

    /**
     * @throws NonUniqueResultException
     */
    public function getRemainingOrders($storeOwner, $id): ?array
    {
        return $this->subscribeRepository->getRemainingOrders($storeOwner, $id);
    }

    /**
     * @throws NonUniqueResultException
     */
    public function getCountCarsBusy($storeOwner, $id): ?array
    {
        return $this->subscribeRepository->getCountCarsBusy($storeOwner, $id);
    }
   
    public function getCountCancelledOrders($subscribeId)
    {
        return $this->subscribeRepository->getCountCancelledOrders($subscribeId);
    }

    public function getCountDeliveredOrders($storeOwner, $id)
    {
        return $this->subscribeRepository->getCountDeliveredOrders($storeOwner, $id);
    }

    public function subscripeNewUsers($fromDate, $toDate)
    {
        return $this->subscribeRepository->subscripeNewUsers($fromDate, $toDate);
    }

    public function getNextSubscription($storeOwner)
    {
        return $this->subscribeRepository->getNextSubscription($storeOwner);
    }

    public function totalAmountOfSubscriptions($storeOwner)
    {
        return $this->subscribeRepository->totalAmountOfSubscriptions($storeOwner);
    }
}
