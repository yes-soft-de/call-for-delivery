<?php

namespace App\Manager\Subscription;

use App\AutoMapping;
use App\Entity\SubscriptionCaptainOfferEntity;
use App\Manager\Subscription\SubscriptionManager;
use App\Request\Subscription\SubscriptionCaptainOfferCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\CaptainOffer\CaptainOfferManager;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Constant\Subscription\SubscriptionCaptainOffer;
use App\Repository\SubscriptionCaptainOfferEntityRepository;

class SubscriptionCaptainOfferManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private CaptainOfferManager $captainOfferManager;
    private SubscriptionManager $subscriptionManager;
    private SubscriptionCaptainOfferEntityRepository $subscriptionCaptainOfferEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CaptainOfferManager $captainOfferManager, StoreOwnerProfileManager $storeOwnerProfileManager, SubscriptionManager $subscriptionManager, SubscriptionCaptainOfferEntityRepository $subscriptionCaptainOfferEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainOfferManager = $captainOfferManager;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
        $this->subscriptionManager = $subscriptionManager;
        $this->subscriptionCaptainOfferEntityRepository = $subscriptionCaptainOfferEntityRepository;
    }

    public function createSubscriptionCaptainOffer(SubscriptionCaptainOfferCreateRequest $request): SubscriptionCaptainOfferEntity
    {
        $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($request->getStoreOwner());
        $request->setStoreOwner($storeOwner);
 
        $captainOffer = $this->captainOfferManager->getCaptainOfferById($request->getCaptainOffer());
        $request->setCaptainOffer($captainOffer);

        $subscriptionCaptainOfferEntity = $this->autoMapping->map(SubscriptionCaptainOfferCreateRequest::class, SubscriptionCaptainOfferEntity::class, $request);

        $subscriptionCaptainOfferEntity->setStatus(SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_ACTIVE);

        $subscriptionCaptainOfferEntity->setCarCount($captainOffer->getCarCount());
        $subscriptionCaptainOfferEntity->setExpired($captainOffer->getExpired());

        $this->entityManager->persist($subscriptionCaptainOfferEntity);
        $this->entityManager->flush();

        $this->subscriptionManager->updateSubscriptionCaptainOfferId($subscriptionCaptainOfferEntity, true);
       
        return $subscriptionCaptainOfferEntity;
    }

    public function updateState(int $id, string $status): SubscriptionCaptainOfferEntity
    {
        $subscriptionCaptainOfferEntity = $this->subscriptionCaptainOfferEntityRepository->find($id);

        $subscriptionCaptainOfferEntity->setStatus($status);

        $this->entityManager->flush();

        return $subscriptionCaptainOfferEntity;
    }

    public function isThereSubscription($storeOwnerId): ?array
    {
       return  $this->subscriptionManager->isThereSubscription($storeOwnerId);
    }

    public function subscriptionCaptainOfferBySubscribeId(int $subscribeId): ?array
    {
       return  $this->subscriptionCaptainOfferEntityRepository->subscriptionCaptainOfferBySubscribeId($subscribeId);
    }

    public function deleteCaptainOfferSubscriptionById(int $id): ?SubscriptionCaptainOfferEntity
    {
        $captainOfferSubscriptionEntity = $this->subscriptionCaptainOfferEntityRepository->findOneBy(['id'=>$id]);

        if ($captainOfferSubscriptionEntity !== null) {
            $captainOfferSubscriptionEntity->setStoreOwner(null);
            $captainOfferSubscriptionEntity->setCaptainOffer(null);

            $subscriptionsArray = $captainOfferSubscriptionEntity->getSubscriptionEntitie()->toArray();

            if (count($subscriptionsArray)) {
                foreach ($subscriptionsArray as $subscription) {
                    $captainOfferSubscriptionEntity->removeSubscriptionEntitie($subscription);
                }
            }

            $this->entityManager->remove($captainOfferSubscriptionEntity);

            $this->entityManager->flush();
        }

        return $captainOfferSubscriptionEntity;
    }
}
