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
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private PackageManager $packageManager;
    private StoreOwnerProfileManager $storeOwnerProfileManager;
    private SubscriptionDetailsManager $subscriptionDetailsManager;
    private SubscriptionHistoryManager $subscriptionHistoryManager;
    private SubscriptionEntityRepository $subscribeRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, SubscriptionEntityRepository $subscribeRepository, PackageManager $packageManager, StoreOwnerProfileManager $storeOwnerProfileManager, SubscriptionDetailsManager $subscriptionDetailsManager, SubscriptionHistoryManager $subscriptionHistoryManager)
    {
        $this->autoMapping = $autoMapping;
        $this->packageManager = $packageManager;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
        $this->subscriptionDetailsManager = $subscriptionDetailsManager;
        $this->subscriptionHistoryManager = $subscriptionHistoryManager;
        $this->entityManager = $entityManager;
        $this->subscribeRepository = $subscribeRepository;

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

          $this->subscriptionDetailsManager->createSubscriptionDetails($subscriptionEntity, $request->getHasExtra());
       }
      
       $this->subscriptionHistoryManager->createSubscriptionHistory($subscriptionEntity, $request->getType());            

       return $subscriptionEntity;
    }

    public function getSubscriptionCurrent(int $storeOwner): ?SubscriptionDetailsEntity
    {
        $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($storeOwner);

        return $this->subscriptionDetailsManager->getSubscriptionCurrent($storeOwner);
    }

    public function updateRemainingOrders(int $id, int $remainingOrders): ?array
    {
       return $this->subscriptionDetailsManager->updateRemainingOrders($id, $remainingOrders);
    }

    public function getSubscriptionCurrentWithRelation(int $storeOwnerId): ?array
    {
       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($storeOwnerId);

       return $this->subscribeRepository->getSubscriptionCurrentWithRelation($storeOwner);
       
    }

    public function getSubscriptionForNextTime(int $storeOwner): ?array
    {
       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($storeOwner);

       return $this->subscribeRepository->getSubscriptionForNextTime($storeOwner);       
    }

    public function getSubscriptionsForStoreOwner(int $storeOwner): ?array
    {
       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($storeOwner);
     
       return $this->subscribeRepository->getSubscriptionsForStoreOwner($storeOwner);
    }

    public function updateSubscribeState(int $id, string $status): string
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

    public function updateIsFutureAndSubscriptionCurrent(int $id, bool $isFuture, bool $hasExtra): string
    {
        $subscribeEntity = $this->subscribeRepository->find($id);
        
        $subscribeEntity->setIsFuture($isFuture);

        if ($subscribeEntity) {

            $this->autoMapping->map(SubscriptionUpdateIsFutureRequest::class, SubscriptionEntity::class, $subscribeEntity);

            $this->entityManager->flush();
          
            $this->subscriptionDetailsManager->createSubscriptionDetails($subscribeEntity, $hasExtra);           
            
            return SubscriptionConstant::UPDATE_STATE;
        }

        return SubscriptionConstant::ERROR;
    }

    public function calculatingSubscriptionExpiryDate(DateTime $startDate, int $days): DateTime|null
    {
        $days = $days.'day';

        return new DateTime($startDate->format('Y-m-d h:i:s') . $days);
    }

    public function updateEndDate(int $id, DateTime $endDate, string $note): ?SubscriptionEntity
    {
        $subscriptionEntity = $this->subscribeRepository->find($id);
      
        $subscriptionEntity->setEndDate($endDate);

        $this->entityManager->flush();
 
        $this->subscriptionDetailsManager->updateRemainingTime($id, 0);
       
        $this->subscriptionHistoryManager->updateNoteSubscriptionHistory($id, $note);            
       
        return $subscriptionEntity;
    }

    public function countOrders(int $subscriptionId): ?array
    {
       return $this->subscribeRepository->countOrders($subscriptionId);
    }

    public function updateHasExtraAndType(int $subscriptionExtraId, bool $hasExtra, bool $type): ?string
    {
        $subscribeEntity = $this->subscribeRepository->find($subscriptionExtraId);

        if (!$subscribeEntity) {

            return $subscribeEntity;
        }
      
        $subscriptionHistory = $this->subscriptionHistoryManager->updateType($subscribeEntity, $type);
        if($subscriptionHistory === "this subscription not extra") {

            return "this subscription not extra";
        }

        $this->subscriptionDetailsManager->updateHasExtra($subscribeEntity, $hasExtra);

        return SubscriptionConstant::UPDATE_STATE;
    }
}
