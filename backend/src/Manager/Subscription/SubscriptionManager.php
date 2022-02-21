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
use Doctrine\ORM\NonUniqueResultException;

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

    public function createSubscription(SubscriptionCreateRequest $request, $status): ?SubscriptionEntity
    { 
        // change to SUBSCRIBE_INACTIVE
        $request->setStatus(SubscriptionConstant::SUBSCRIBE_ACTIVE);
        
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

    public function nextSubscription(SubscriptionNextRequest $request, $status): ?SubscriptionEntity
    {  
        $request->setStatus(SubscriptionConstant::SUBSCRIBE_INACTIVE);
        
        if($status === SubscriptionConstant::SUBSCRIBE_ACTIVE) {
           
            $request->setIsFuture(1);
        }

        else {
          
            $request->setIsFuture(0);
        }

       $package = $this->packageManager->getPackage($request->getPackage());
       $request->setPackage($package);

       $storeOwnerProfile = $this->storeOwnerProfileManager->getStoreOwnerProfile($request->getStoreOwner());
       $request->setStoreOwner($storeOwnerProfile);
      
       $subscriptionEntity = $this->autoMapping->map(SubscriptionNextRequest::class, SubscriptionEntity::class, $request);
    
    //    $subscriptionEntity->setStartDate(new DateTime());

       $this->entityManager->persist($subscriptionEntity);

       $this->entityManager->flush();

       return $subscriptionEntity;
    }

    public function getIsFuture($storeOwner): ?array
    {
        return $this->subscribeRepository->getIsFuture($storeOwner);
    }
    
    public function getSubscriptionForStoreOwner($storeOwner): array
    {
         return $this->subscribeRepository->getSubscriptionForStoreOwner($storeOwner);
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

    public function updateSubscribeStateToFinish($id, $status): string
    {
        $subscribeEntity = $this->subscribeRepository->find($id);
        
        $subscribeEntity->setStatus($status);

        if ($subscribeEntity) {

            $this->autoMapping->map(SubscriptionUpdateFinishRequest::class, SubscriptionEntity::class, $subscribeEntity);

            $this->entityManager->flush();

            return SubscriptionConstant::UPDATE_STATE;
        }

        return SubscriptionConstant::ERROR;
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
