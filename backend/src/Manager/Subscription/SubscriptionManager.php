<?php

namespace App\Manager\Subscription;

use App\AutoMapping;
use App\Constant\Subscription\SubscriptionCaptainOffer;
use App\Constant\Subscription\SubscriptionDetailsConstant;
use App\Entity\PackageEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\SubscriptionCaptainOfferEntity;
use App\Entity\SubscriptionHistoryEntity;
use App\Repository\SubscriptionEntityRepository;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\Subscription\SubscriptionCreateRequest;
use App\Request\Subscription\SubscriptionStatusUpdateRequest;
use App\Request\Subscription\SubscriptionUpdateRequest;
use App\Request\Subscription\SubscriptionUpdateIsFutureRequest;
use Doctrine\ORM\EntityManagerInterface;
use DateTime;
use App\Manager\Package\PackageManager;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Constant\Subscription\SubscriptionConstant;
use App\Request\Subscription\SubscriptionUpdateByAdminRequest;

class SubscriptionManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private PackageManager $packageManager,
        private StoreOwnerProfileManager $storeOwnerProfileManager,
        private SubscriptionDetailsManager $subscriptionDetailsManager,
        private SubscriptionHistoryManager $subscriptionHistoryManager,
        private SubscriptionEntityRepository $subscribeRepository
    )
    {
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

    public function updateRemainingOrders(int $id, int $remainingOrders): SubscriptionDetailsEntity|int
    {
       return $this->subscriptionDetailsManager->updateRemainingOrders($id, $remainingOrders);
    }

    public function getSubscriptionCurrentWithRelation(int $storeOwnerId): ?array
    {
       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($storeOwnerId);

       return $this->subscribeRepository->getSubscriptionCurrentWithRelation($storeOwner);
    }

    public function isThereSubscription(int $storeOwnerId): ?array
    {
       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($storeOwnerId);

       return $this->subscriptionDetailsManager->getSubscriptionCurrentActive($storeOwner);
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

            // Why we need this?
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

    public function isPackageReadyForSubscription($packageId): ?array {
       
        return $this->packageManager->getPackageActiveById($packageId);
    }

    public function updateRemainingCars(int $id, int $remainingCars): ?SubscriptionDetailsEntity 
    {
        return $this->subscriptionDetailsManager->updateRemainingCars($id, $remainingCars);
    }

    /**
     * This function link captain offer subscription with current store subscription,
     * And updates the remainingCars field of the subscription details record
     */
    public function updateSubscriptionCaptainOfferId(SubscriptionCaptainOfferEntity $subscriptionCaptainOfferEntity, $captainOfferFirstTime = false): string|array
    { 
        //TODO shortcut two queries in one query
        $subscribeCurrent = $this->subscriptionDetailsManager->getSubscriptionCurrent($subscriptionCaptainOfferEntity->getStoreOwner()->getId());
              
        $subscribeEntity = $this->subscribeRepository->find($subscribeCurrent->getLastSubscription()->getId());

        if (! $subscribeEntity) {
            return SubscriptionConstant::ERROR;
        }

        $subscribeEntity->setSubscriptionCaptainOffer($subscriptionCaptainOfferEntity);
        $subscribeEntity->setCaptainOfferFirstTime($captainOfferFirstTime);
    
        $this->entityManager->flush();
       
        $remainingCars = $subscribeCurrent->getRemainingCars() + $subscriptionCaptainOfferEntity->getCarCount();

        $subscriptionDetailsResult = $this->updateRemainingCars($subscribeCurrent->getLastSubscription()->getId(), $remainingCars);

        if ($subscriptionDetailsResult) {
            return [SubscriptionConstant::UPDATE_STATE, $subscriptionDetailsResult];
        }

        return [SubscriptionConstant::UPDATE_STATE, SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND];
    }
    
    public function getStoreOwnerProfileByStoreOwnerId(int $storeOwnerId): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($storeOwnerId);
    }

    public function storeOwnerProfileCompleteAccountStatusUpdate(CompleteAccountStatusUpdateRequest $request): StoreOwnerProfileEntity|string
    {
        return $this->storeOwnerProfileManager->storeOwnerProfileCompleteAccountStatusUpdate($request);
    }

    public function getSubscriptionCurrentByOrderId($orderId): ?array
    {
        return $this->subscribeRepository->getSubscriptionCurrentByOrderId($orderId);
    }

    public function getSubscriptionHistoryByStoreOwner(StoreOwnerProfileEntity $storeOwnerProfileEntity): ?SubscriptionHistoryEntity
    {
        return $this->subscriptionHistoryManager->getSubscriptionHistoryByStoreOwner($storeOwnerProfileEntity);
    }

    public function checkWhetherThereIsActiveCaptainsOffer($storeOwnerId): ?SubscriptionEntity
    {
        return $this->subscribeRepository->checkWhetherThereIsActiveCaptainsOffer($storeOwnerId);
    }
  
    public function getSubscriptionById(int $id): ?SubscriptionEntity
    {
        return $this->subscribeRepository->find($id);
    }

    public function updateSubscriptionFlag(SubscriptionEntity $subscriptionEntity, int $flag): ?SubscriptionEntity
    {        
        $subscriptionEntity->setFlag($flag);

        $this->entityManager->flush();
      //To be used with the extended subscription, to become a normal subscription.
        $this->subscriptionHistoryManager->updateType($subscriptionEntity, SubscriptionConstant::POSSIBLE_TO_EXTRA_FALSE);
      //To be used with the extended subscription, to become a normal subscription.
        $this->subscriptionDetailsManager->updateHasExtra($subscriptionEntity, SubscriptionConstant::IS_HAS_EXTRA_FALSE);  
       
        return $subscriptionEntity;
    }
    
    public function getSubscriptionsByUserID(int $userId): ?array
    {
        return $this->subscribeRepository->getSubscriptionsByUserID($userId);
    }
    
    public function getCaptainOfferFirstTimeBySubscriptionId(int $subscriptionId): ?array
    {
        return $this->subscribeRepository->getCaptainOfferFirstTimeBySubscriptionId($subscriptionId);
    }
    
    public function getCaptainOffersBySubscriptionId(int $subscriptionId): ?array
    {
        return $this->subscribeRepository->getCaptainOffersBySubscriptionId($subscriptionId);
    }

    public function updateSubscription(SubscriptionUpdateByAdminRequest $request)
    { 
       $package = $this->packageManager->getPackage($request->getPackage());
       $request->setPackage($package);

       $subscriptionEntity = $this->subscribeRepository->find($request->getId());

       // save order count of old package in order to calculate the remaining orders lately
       $oldPackageOrderCount = $subscriptionEntity->getPackage()->getOrderCount();

       $subscriptionEntity = $this->autoMapping->mapToObject(SubscriptionUpdateByAdminRequest::class, SubscriptionEntity::class, $request, $subscriptionEntity);

       $subscriptionEntity->setStartDate(new DateTime());
   
       $subscriptionEntity->setEndDate($this->calculatingSubscriptionExpiryDate($subscriptionEntity->getStartDate(), $package->getExpired()));

       $this->entityManager->flush();

       $this->subscriptionDetailsManager->updateSubscriptionDetailsByAdmin($subscriptionEntity, $oldPackageOrderCount);
      
       $this->subscriptionHistoryManager->updateSubscriptionHistoryByAdmin($subscriptionEntity->getId());            

       return SubscriptionConstant::SUBSCRIPTION_OK;
    }

    public function getStoreOwnerProfileByStoreOwnerProfileId(int $storeOwnerProfileId): ?StoreOwnerProfileEntity
    {
       return $this->storeOwnerProfileManager->getStoreOwnerProfile($storeOwnerProfileId);
    }

    public function deleteStoreSubscriptionByStoreOwnerId(int $storeOwnerId): array
    {
        $subscriptions = $this->subscribeRepository->getAllSubscriptionsEntitiesByStoreOwnerId($storeOwnerId);

        if (! empty($subscriptions)) {
            foreach ($subscriptions as $subscription) {
                $this->entityManager->remove($subscription);
                $this->entityManager->flush();
            }
        }

        return $subscriptions;
    }

    public function updateSubscriptionByRemovingCaptainOfferSubscription(int $subscriptionId): ?SubscriptionEntity
    {
        $subscriptionEntity = $this->subscribeRepository->findOneBy(['id'=>$subscriptionId]);

        if ($subscriptionEntity !== null) {
            $subscriptionEntity->setSubscriptionCaptainOffer(null);
            $subscriptionEntity->setCaptainOfferFirstTime(null);

            $this->entityManager->flush();
        }

        return $subscriptionEntity;
    }

    public function getOrdersExceedGeographicalRangeBySubscriptionId(int $subscriptionId, float $packageGeographicalRange): ?array
    {
       return $this->subscribeRepository->getOrdersExceedGeographicalRangeBySubscriptionId($subscriptionId, $packageGeographicalRange);
    }

    public function getCountOfConsumedOrders(int $subscriptionId): ?int
    {
       return $this->subscribeRepository->getCountOfConsumedOrders($subscriptionId);
    }

    public function deleteStoreSubscriptionBySubscriptionId(int $subscriptionId): ?SubscriptionEntity
    {
        $subscriptionEntity = $this->subscribeRepository->findOneBy(['id'=>$subscriptionId]);

        if (! $subscriptionEntity) {
            return $subscriptionEntity;
        }

        $this->entityManager->remove($subscriptionEntity);
        $this->entityManager->flush();

        return $subscriptionEntity;
    }

    public function getFutureSubscriptionByStoreOwnerProfileId(int $storeOwnerProfileId): array
    {
        return $this->subscribeRepository->findBy(['storeOwner' => $storeOwnerProfileId, 'isFuture' => 1], ['id' => 'ASC'], 1);
    }

    public function updateFutureSubscriptionToCurrentSubscription(int $futureSubscriptionId): SubscriptionEntity|int
    {
        $subscriptionEntity = $this->subscribeRepository->findOneBy(['id' => $futureSubscriptionId]);

        if (! $subscriptionEntity) {
            return SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST;
        }

        $subscriptionEntity->setIsFuture(0);

        $this->entityManager->flush();

        $this->subscriptionDetailsManager->createSubscriptionDetails($subscriptionEntity, SubscriptionConstant::IS_HAS_EXTRA_FALSE);

        return $subscriptionEntity;
    }

    /**
     * Update subscription status and subscription details status
     */
    public function updateSubscribeStatusAndCurrentSubscriptionStatus(SubscriptionStatusUpdateRequest $request): SubscriptionEntity|string|int
    {
        $subscriptionEntity = $this->subscribeRepository->findOneBy(['id' => $request->getId()]);

        if (! $subscriptionEntity) {
            return SubscriptionConstant::SUBSCRIPTION_NOT_FOUND;
        }

        $this->entityManager->getConnection()->beginTransaction();

        try {
            $subscriptionEntity->setStatus($request->getStatus());

            $this->entityManager->flush();

            // Also, update the status of the current subscription details
            $subscriptionDetailsStatusUpdateResult = $this->subscriptionDetailsManager->updateSubscriptionDetailsStatusBySubscriptionId($request);

            if ($subscriptionDetailsStatusUpdateResult === SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND) {
                return SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND;
            }

            $this->entityManager->getConnection()->commit();

            return $subscriptionEntity;

        } catch (\Exception $e) {
            $this->entityManager->getConnection()->rollBack();

            throw $e;
        }
    }

    public function getActiveCaptainOfferSubscriptionBySubscriptionId(int $subscriptionId): SubscriptionCaptainOfferEntity|int|string
    {
        $subscriptionEntity = $this->subscribeRepository->getSubscriptionWithActiveCaptainOfferSubscriptionBySubscriptionId($subscriptionId);

        if (! $subscriptionEntity) {
            return SubscriptionConstant::SUBSCRIPTION_NOT_FOUND;
        }

        if (! $subscriptionEntity->getSubscriptionCaptainOffer()) {
            return SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_NOT_EXIST;
        }

        return $subscriptionEntity->getSubscriptionCaptainOffer();
    }

    public function getPackageEntityById(int $id): ?PackageEntity
    {
        return $this->packageManager->getPackageEntityById($id);
    }

    public function createSubscriptionWithFreePackage(SubscriptionCreateRequest $request): ?SubscriptionEntity
    {
        // change to SUBSCRIBE_INACTIVE
        $request->setStatus(SubscriptionConstant::SUBSCRIBE_ACTIVE);

        $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($request->getStoreOwner());

        $request->setStoreOwner($storeOwner);

        $storeOwnerProfile = $this->storeOwnerProfileManager->getStoreOwnerProfile($request->getStoreOwner());
        $request->setStoreOwner($storeOwnerProfile);

        $subscriptionEntity = $this->autoMapping->map(SubscriptionCreateRequest::class, SubscriptionEntity::class,
            $request);

        $subscriptionEntity->setStartDate(new DateTime('now'));

        $subscriptionEntity->setEndDate($this->calculatingSubscriptionExpiryDate($subscriptionEntity->getStartDate(),
            $request->getPackage()->getExpired()));

        $this->entityManager->persist($subscriptionEntity);
        $this->entityManager->flush();

        if ($subscriptionEntity->getIsFuture() === false) {
            $this->subscriptionDetailsManager->createSubscriptionDetails($subscriptionEntity, $request->getHasExtra());
        }

        $this->subscriptionHistoryManager->createSubscriptionHistory($subscriptionEntity, $request->getType());

        return $subscriptionEntity;
    }

    public function checkDeliveredOrdersCostTillNow(int $storeOwnerUserId, int $subscriptionId): array
    {
        return $this->subscribeRepository->checkDeliveredOrdersCostTillNow($storeOwnerUserId, $subscriptionId);
    }

    public function updateSubscriptionStatusToDateFinishedBySubscriptionDetailsEntity(SubscriptionDetailsEntity $subscriptionDetailsEntity): SubscriptionDetailsEntity
    {
        $subscriptionDetailsEntityUpdateResult = $this->subscriptionDetailsManager->updateSubscriptionDetailsStatusToDateFinished($subscriptionDetailsEntity);

        $subscription = $subscriptionDetailsEntityUpdateResult->getLastSubscription();

        $subscription->setStatus(SubscriptionConstant::DATE_FINISHED);
        $subscription->setEndDate(new DateTime('now'));

        $this->entityManager->flush();

        return $subscriptionDetailsEntityUpdateResult;
    }

    public function updateSubscriptionPaidFlagBySubscriptionEntity(SubscriptionEntity $subscriptionEntity, int $paidFlag): SubscriptionEntity
    {
        $subscriptionEntity->setFlag($paidFlag);

        $this->entityManager->flush();

        return $subscriptionEntity;
    }

    public function getDeliveredOrdersDeliveryCostFromSubscriptionStartDateTillNow(int $storeOwnerUserId, int $subscriptionId): array
    {
        return $this->subscribeRepository->getDeliveredOrdersDeliveryCostFromSubscriptionStartDateTillNow($storeOwnerUserId,
            $subscriptionId);
    }

    /**
     * ///todo to be used for Updating subscriptionCost field of the store
     * Get last store subscription and not a future one (whatever its status)
     */
    public function getLastUnFutureStoreSubscriptionByStoreOwnerProfileId(int $storeOwnerProfileId): array
    {
        return $this->subscribeRepository->findBy(['storeOwner' => $storeOwnerProfileId, 'isFuture' => false],
            ['id' => 'DESC'], 1);
    }

    public function updateSubscriptionCostBySubscriptionEntityAndNewSubscriptionCost(SubscriptionEntity $subscriptionEntity, float $newSubscriptionCost): SubscriptionEntity
    {
        $subscriptionEntity->setSubscriptionCost($newSubscriptionCost);

        $this->entityManager->flush();

        return $subscriptionEntity;
    }
}
