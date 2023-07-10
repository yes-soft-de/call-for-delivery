<?php

namespace App\Manager\Admin\StoreOwnerSubscription;

use App\Constant\Subscription\SubscriptionConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Repository\SubscriptionEntityRepository;
use App\Repository\SubscriptionHistoryEntityRepository;
use App\Request\Subscription\SubscriptionStatusUpdateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Entity\SubscriptionEntity;

class AdminStoreSubscriptionManager
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private SubscriptionEntityRepository $subscribeRepository,
        private SubscriptionHistoryEntityRepository $subscriptionHistoryEntityRepository,
        private AdminSubscriptionDetailsManager $adminSubscriptionDetailsManager
    )
    {
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

    public function updateCurrentSubscriptionStatus(SubscriptionStatusUpdateByAdminRequest $request): SubscriptionEntity|int
    {
        $subscriptionEntity = $this->subscribeRepository->findOneBy(['id' => $request->getId()]);

        if (! $subscriptionEntity) {
            return SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST;
        }

        $subscriptionEntity->setStatus($request->getStatus());

        $this->entityManager->flush();

        return $subscriptionEntity;
    }

    public function getDeliveredOrdersDeliveryCostFromSubscriptionStartDateTillNow(int $storeOwnerProfileId, int $subscriptionId)
    {
        return $this->subscribeRepository->getDeliveredOrdersDeliveryCostFromSubscriptionStartDateTillNowForAdmin($storeOwnerProfileId,
            $subscriptionId);
    }

    public function getLastStoreSubscriptionByStoreOwnerProfileIdForAdmin(int $storeOwnerProfileId): array
    {
        return $this->subscribeRepository->findBy(['storeOwner' => $storeOwnerProfileId], ['id' => 'DESC'], 1);
    }

    public function getDeliveredOrdersDeliveryCostAccordingToSubscriptionStartAndEndDatesForAdmin(int $storeOwnerProfileId, int $subscriptionId)
    {
        return $this->subscribeRepository->getDeliveredOrdersDeliveryCostAccordingToSubscriptionStartAndEndDatesForAdmin($storeOwnerProfileId,
            $subscriptionId);
    }
}
