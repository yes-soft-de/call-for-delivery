<?php

namespace App\Manager\Admin\StoreOwnerSubscription;

use App\Repository\SubscriptionEntityRepository;
use App\Repository\SubscriptionHistoryEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class AdminStoreSubscriptionManager
{
    private EntityManagerInterface $entityManager;
    private SubscriptionEntityRepository $subscribeRepository;
    private SubscriptionHistoryEntityRepository $subscriptionHistoryEntityRepository;

    public function __construct(EntityManagerInterface $entityManager, SubscriptionEntityRepository $subscribeRepository, SubscriptionHistoryEntityRepository $subscriptionHistoryEntityRepository)
    {
        $this->entityManager = $entityManager;
        $this->subscribeRepository = $subscribeRepository;
        $this->subscriptionHistoryEntityRepository = $subscriptionHistoryEntityRepository;
    }

    public function getSubscriptionsSpecificStoreForAdmin(int $storeId): ?array
    {
        return $this->subscribeRepository->getSubscriptionsSpecificStoreForAdmin($storeId);
    }

    public function getCaptainOfferFirstTimeBySubscriptionId(int $subscriptionId): ?array
    {
        return $this->subscribeRepository->getCaptainOfferFirstTimeBySubscriptionId($subscriptionId);
    }

    public function getCaptainOffersBySubscriptionId(int $subscriptionId): ?array
    {
        return $this->subscribeRepository->getCaptainOffersBySubscriptionId($subscriptionId);
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
}
