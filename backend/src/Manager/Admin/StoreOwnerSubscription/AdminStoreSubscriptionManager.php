<?php

namespace App\Manager\Admin\StoreOwnerSubscription;

use App\Entity\StoreOwnerProfileEntity;
use App\Repository\SubscriptionEntityRepository;
use App\Repository\SubscriptionHistoryEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\Admin\StoreOwnerSubscription\AdminSubscriptionDetailsManager;
use App\Manager\Admin\StoreOwnerSubscription\AdminSubscriptionHistoryManager;
use App\Entity\SubscriptionEntity;

class AdminStoreSubscriptionManager
{
    private EntityManagerInterface $entityManager;
    private SubscriptionEntityRepository $subscribeRepository;
    private SubscriptionHistoryEntityRepository $subscriptionHistoryEntityRepository;
    private AdminSubscriptionDetailsManager $adminSubscriptionDetailsManager;
    private AdminSubscriptionHistoryManager $adminSubscriptionHistoryManager;

    public function __construct(EntityManagerInterface $entityManager, SubscriptionEntityRepository $subscribeRepository, SubscriptionHistoryEntityRepository $subscriptionHistoryEntityRepository, AdminSubscriptionDetailsManager $adminSubscriptionDetailsManager, AdminSubscriptionHistoryManager $adminSubscriptionHistoryManager)
    {
        $this->entityManager = $entityManager;
        $this->subscribeRepository = $subscribeRepository;
        $this->subscriptionHistoryEntityRepository = $subscriptionHistoryEntityRepository;
        $this->adminSubscriptionDetailsManager = $adminSubscriptionDetailsManager;
        $this->adminSubscriptionHistoryManager = $adminSubscriptionHistoryManager;
    }

    public function getSubscriptionsSpecificStoreForAdmin(int $storeId): ?array
    {
        return $this->subscribeRepository->getSubscriptionsSpecificStoreForAdmin($storeId);
    }

    public function getCaptainOfferFirstTimeBySubscriptionId(int $subscriptionId): ?array
    {
        return $this->subscribeRepository->getCaptainOfferFirstTimeBySubscriptionId($subscriptionId);
    }

    public function getCaptainOffersBySubscriptionIdForAdmin(int $subscriptionId): ?array
    {
        return $this->subscribeRepository->getCaptainOffersBySubscriptionIdForAdmin($subscriptionId);
    }

    // This functions deletes only future subscriptions of a store according to storeOwnerId
    public function deleteAllStoreFutureSubscriptionsByStoreOwnerId(int $storeOwnerId): array
    {
        $futureSubscriptionsEntities = $this->subscribeRepository->findBy(['storeOwner'=>$storeOwnerId, 'isFuture'=>1]);

        if (! empty($futureSubscriptionsEntities)) {
            foreach ($futureSubscriptionsEntities as $futureSubscriptionEntity) {
                // First, we have to delete the history records of the subscriptions
                $subscriptionsHistoryEntities = $this->subscriptionHistoryEntityRepository->findBy(['subscription'=>$futureSubscriptionEntity->getId(), 'storeOwner'=>$storeOwnerId]);

                if (! empty($subscriptionsHistoryEntities)) {
                    foreach ($subscriptionsHistoryEntities as $subscriptionHistoryEntity) {
                        $this->entityManager->remove($subscriptionHistoryEntity);

                        $this->entityManager->flush();
                    }
                }

                // now we delete the subscription entity itself
                $this->entityManager->remove($futureSubscriptionEntity);

                $this->entityManager->flush();
            }
        }

        return $futureSubscriptionsEntities;
    }

//    public function deleteSubscriptionById(int $id): ?SubscriptionEntity
//    {
//        $subscriptionEntity = $this->subscribeRepository->find($id);
//
//        if ($subscriptionEntity) {
//                //Delete subscription details
//                $this->adminSubscriptionDetailsManager->deleteSubscriptionDetailsBySubscriptionId($id);
//                //Delete history
//                $this->adminSubscriptionHistoryManager->deleteSubscriptionHistoryBySubscriptionId($id);
//                // //Delete the subscription entity
//                $this->entityManager->remove($subscriptionEntity);
//
//                $this->entityManager->flush();
//        }
//
//        return $subscriptionEntity;
//    }

    public function isThereSubscription(StoreOwnerProfileEntity $storeOwnerProfileId): ?array
    {
        return $this->adminSubscriptionDetailsManager->getSubscriptionCurrentActive($storeOwnerProfileId);
    }

    public function getSubscriptionEntityByIdForAdmin(int $id): ?SubscriptionEntity
    {
        return $this->subscribeRepository->findOneBy(['id'=>$id]);
    }
    
    public function getOrdersExceedGeographicalRangeBySubscriptionId(int $subscriptionId, float $packageGeographicalRange): ?array
    {
       return $this->subscribeRepository->getOrdersExceedGeographicalRangeBySubscriptionId($subscriptionId, $packageGeographicalRange);
    }
}
