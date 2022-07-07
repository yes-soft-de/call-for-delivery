<?php

namespace App\Manager\Admin\StoreOwnerSubscription;

use App\Entity\SubscriptionDetailsEntity;
use App\Repository\SubscriptionDetailsEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class AdminSubscriptionDetailsManager
{
    private EntityManagerInterface $entityManager;
    private SubscriptionDetailsEntityRepository $subscriptionDetailsEntityRepository;

    public function __construct(EntityManagerInterface $entityManager, SubscriptionDetailsEntityRepository $subscriptionDetailsEntityRepository)
    {
        $this->entityManager = $entityManager;
        $this->subscriptionDetailsEntityRepository = $subscriptionDetailsEntityRepository;
    }
    
    public function deleteSubscriptionDetailsBySubscriptionId(int $subscriptionId): ?SubscriptionDetailsEntity
    {
        $subscriptionDetailsEntity = $this->subscriptionDetailsEntityRepository->findOneBy(['lastSubscription' => $subscriptionId]);

        if ($subscriptionDetailsEntity) {
            $this->entityManager->remove($subscriptionDetailsEntity);
            $this->entityManager->flush();
        }
        return $subscriptionDetailsEntity;
    }
}
