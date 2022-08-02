<?php

namespace App\Manager\Admin\StoreOwnerSubscription;

use App\AutoMapping;
use App\Constant\Subscription\SubscriptionCaptainOffer;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionCaptainOfferEntity;
use App\Manager\Subscription\SubscriptionManager;
use App\Repository\SubscriptionCaptainOfferEntityRepository;
use App\Request\Admin\Subscription\AdminCaptainOfferSubscriptionCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminCaptainOfferSubscriptionManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private AdminStoreSubscriptionManager $adminStoreSubscriptionManager;
    private SubscriptionManager $subscriptionManager;
    private SubscriptionCaptainOfferEntityRepository $subscriptionCaptainOfferEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, AdminStoreSubscriptionManager $adminStoreSubscriptionManager, SubscriptionManager $subscriptionManager,
                                SubscriptionCaptainOfferEntityRepository $subscriptionCaptainOfferEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->adminStoreSubscriptionManager = $adminStoreSubscriptionManager;
        $this->subscriptionManager = $subscriptionManager;
        $this->subscriptionCaptainOfferEntityRepository = $subscriptionCaptainOfferEntityRepository;
    }

    public function createCaptainOfferSubscriptionByAdmin(AdminCaptainOfferSubscriptionCreateRequest $request): SubscriptionCaptainOfferEntity
    {
        $subscriptionCaptainOfferEntity = $this->autoMapping->map(AdminCaptainOfferSubscriptionCreateRequest::class, SubscriptionCaptainOfferEntity::class, $request);

        $subscriptionCaptainOfferEntity->setStatus(SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_ACTIVE);

        $subscriptionCaptainOfferEntity->setCarCount($request->getCaptainOffer()->getCarCount());
        $subscriptionCaptainOfferEntity->setExpired($request->getCaptainOffer()->getExpired());

        $this->entityManager->persist($subscriptionCaptainOfferEntity);
        $this->entityManager->flush();

        $this->subscriptionManager->updateSubscriptionCaptainOfferId($subscriptionCaptainOfferEntity, true);

        return $subscriptionCaptainOfferEntity;
    }

    public function isThereSubscription(StoreOwnerProfileEntity $storeOwnerId): ?array
    {
        return $this->adminStoreSubscriptionManager->isThereSubscription($storeOwnerId);
    }

    public function getSubscriptionCaptainOfferBySubscriptionId(int $subscriptionId): ?array
    {
        return $this->subscriptionCaptainOfferEntityRepository->subscriptionCaptainOfferBySubscribeId($subscriptionId);
    }
}
