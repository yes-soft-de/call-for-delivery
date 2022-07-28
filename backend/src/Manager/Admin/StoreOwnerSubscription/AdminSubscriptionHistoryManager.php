<?php

namespace App\Manager\Admin\StoreOwnerSubscription;

use App\Entity\SubscriptionHistoryEntity;
use App\Repository\SubscriptionHistoryEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class AdminSubscriptionHistoryManager
{
    private EntityManagerInterface $entityManager;
    private SubscriptionHistoryEntityRepository $subscriptionHistoryEntityRepository;

    public function __construct(EntityManagerInterface $entityManager, SubscriptionHistoryEntityRepository $subscriptionHistoryEntityRepository)
    {
        $this->entityManager = $entityManager;
        $this->subscriptionHistoryEntityRepository = $subscriptionHistoryEntityRepository;
    }
    
    public function deleteSubscriptionHistoryBySubscriptionId(int $subscriptionId)
    {
        $subscriptionsHistoryEntities = $this->subscriptionHistoryEntityRepository->findBy(['subscription'=>$subscriptionId]);

        if ($subscriptionsHistoryEntities) {
            foreach ($subscriptionsHistoryEntities as $subscriptionHistoryEntity) {
                $this->entityManager->remove($subscriptionHistoryEntity);

                $this->entityManager->flush();
            }
        }
    }
}
