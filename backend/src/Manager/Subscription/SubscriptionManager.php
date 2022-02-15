<?php

namespace App\Manager\Subscription;

use App\AutoMapping;
use App\Entity\SubscriptionEntity;
use App\Entity\PackageEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Repository\SubscriptionEntityRepository;
use App\Request\Subscription\SubscriptionCreateRequest;
use App\Request\Subscription\SubscriptionNextRequest;
use App\Request\Subscription\SubscriptionChangeIsFutureRequest;
use App\Request\Subscription\SubscriptionUpdateStateRequest;
use App\Request\Subscription\SubscriptionUpdateFinishRequest;
use Doctrine\ORM\EntityManagerInterface;
use DateTime;
use App\Manager\Package\PackageManager;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Constant\Subscription\SubscriptionConstant;
use App\Response\Subscription\MySubscriptionsResponse;

class SubscriptionManager
{
    private $autoMapping;
    private $entityManager;
    private $subscribeRepository;
    private $packageManager;
    private $storeOwnerProfileManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, SubscriptionEntityRepository $subscribeRepository, PackageManager $packageManager, StoreOwnerProfileManager $storeOwnerProfileManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->subscribeRepository = $subscribeRepository;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
        $this->packageManager = $packageManager;
    }

    public function createSubscription(SubscriptionCreateRequest $request, $status)
    { 
        $request->setStatus(SubscriptionConstant::SUBSCRIBE_INACTIVE);
        
        if($status == SubscriptionConstant::SUBSCRIBE_ACTIVE) {
           
            $request->setIsFuture(1);
        }

        else {
          
            $request->setIsFuture(0);
        }

       $package = $this->packageManager->getPackage($request->getPackage());
       $request->setPackage($package);

       $storeOwnerProfile = $this->storeOwnerProfileManager->getStoreOwnerProfile($request->getStoreOwner());
       $request->setStoreOwner($storeOwnerProfile);
      
       $subscriptionEntity = $this->autoMapping->map(SubscriptionCreateRequest::class, SubscriptionEntity::class, $request);
    
    //    $subscriptionEntity->setStartDate(new DateTime());

       $this->entityManager->persist($subscriptionEntity);

       $this->entityManager->flush();
       $this->entityManager->clear();

       return $subscriptionEntity;
    }

    public function nextSubscription(SubscriptionNextRequest $request, $status)
    {  
        $request->setStatus('inactive');
       
        if($status == "active") {
             $request->setIsFuture(1);
             }
        else{
            $request->setIsFuture(0);
        }
        $subscriptionEntity = $this->autoMapping->map(SubscriptionNextRequest::class, SubscriptionEntity::class, $request);
    // tell talal and mohammed befor active    
    // to save subscribe end date automatic
       // $subscriptionEntity->setEndDate(date_modify(new DateTime('now'),'+1 month'));

        $this->entityManager->persist($subscriptionEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $subscriptionEntity;
    }

    public function getIsFuture($storeOwner): ?array
    {
        return $this->subscribeRepository->getIsFuture($storeOwner);
    }
    
    public function getSubscriptionForStoreOwner($storeOwner)
    {
        // $subscribes = $this->subscribeRepository->getSubscriptionForStoreOwner($storeOwner);
        $subscribes = $this->subscribeRepository->findBy(['storeOwner' => $storeOwner]);
       
        foreach($subscribes as $subscribe){
          
            $subscribe->getPackage()->getName();
           
            $results[] = $this->autoMapping->map( SubscriptionEntity::class, MySubscriptionsResponse::class, $subscribe);
            
        }

        return $results;
    }

    public function subscriptionUpdateState(SubscriptionUpdateStateRequest $request)
    {
        $subscribeEntity = $this->subscribeRepository->find($request->getId());
        $subscribeEntity->setEndDate(date_modify(new DateTime('now'),'+1 month'));

        if (!$subscribeEntity) {
            return null;
        }

        $subscribeEntity = $this->autoMapping->mapToObject(SubscriptionUpdateStateRequest::class, SubscriptionEntity::class, $request, $subscribeEntity);

        $this->entityManager->flush();

        return $subscribeEntity;
    }

    public function updateFinish($id, $status)
    {
        $subscribeEntity = $this->subscribeRepository->find($id);
        
        $subscribeEntity->setStatus($status);

        if (!$subscribeEntity) {
            return null;
        }

        $subscribeEntity = $this->autoMapping->map(SubscriptionUpdateFinishRequest::class, SubscriptionEntity::class, $subscribeEntity);

        $this->entityManager->flush();

        return $subscribeEntity;
    }

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

    public function subscriptionIsActive($ownerID, $subscribeId)
    {
        return $this->subscribeRepository->subscriptionIsActive($ownerID, $subscribeId);
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

    public function getRemainingOrders($storeOwner, $id)
    {
        return $this->subscribeRepository->getRemainingOrders($storeOwner, $id);
    }

    public function getCountActiveCars($ownerID, $subscribeId)
    {
        return $this->subscribeRepository->getCountActiveCars($ownerID, $subscribeId);
    }
   
    public function getCountCancelledOrders($subscribeId)
    {
        return $this->subscribeRepository->getCountCancelledOrders($subscribeId);
    }

    public function getCountDeliveredOrders($ownerID, $subscribeId)
    {
        return $this->subscribeRepository->getCountDeliveredOrders($ownerID, $subscribeId);
    }

    public function subscripeNewUsers($fromDate, $toDate)
    {
        return $this->subscribeRepository->subscripeNewUsers($fromDate, $toDate);
    }

    public function getSubscriptionCurrent($storeOwner): ?array
    {
        return $this->subscribeRepository->getSubscriptionCurrent($storeOwner);
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
