<?php

namespace App\Service\Subscription;

use App\AutoMapping;
use App\Entity\SubscriptionDetailsEntity;
use App\Manager\Subscription\SubscriptionDetailsManager;
use App\Request\Subscription\SubscriptionDetailsCreateRequest;
use App\Response\Subscription\SubscriptionDetailsResponse;
use Doctrine\ORM\NonUniqueResultException;

class SubscriptionDetailsService
{
    private $autoMapping;
    private $subscriptionDetailsManager;

    public function __construct(AutoMapping $autoMapping, SubscriptionDetailsManager $subscriptionDetailsManager)
    {
        $this->autoMapping = $autoMapping;
        $this->subscriptionDetailsManager = $subscriptionDetailsManager;
    }

    /**
     * @param SubscriptionDetailsCreateRequest $request
     * @return mixed
     * @throws NonUniqueResultException
     */
    public function createSubscriptionDetails(SubscriptionDetailsCreateRequest $request): mixed
    {
        $subscriptionResult = $this->subscriptionDetailsManager->createSubscriptionDetails($request);

        return $this->autoMapping->map(SubscriptionDetailsEntity::class, SubscriptionDetailsResponse::class, $subscriptionResult);
    }

    public function getSubscriptionDetailsEntityByLastSubscriptionId(int $subscriptionId): array
    {
        return $this->subscriptionDetailsManager->getSubscriptionDetailsEntityByLastSubscriptionId($subscriptionId);
    }

    public function updateRemainingCars(int $id, int $remainingCars): ?SubscriptionDetailsEntity
    {
        return $this->subscriptionDetailsManager->updateRemainingCars($id, $remainingCars);
    }
}
