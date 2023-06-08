<?php

namespace App\Manager\ExternallyDeliveredOrder;

use App\AutoMapping;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Request\ExternallyDeliveredOrder\ExternallyDeliveredOrderCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class ExternallyDeliveredOrderManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager
    )
    {
    }

    public function createExternallyDeliveredOrder(ExternallyDeliveredOrderCreateRequest $request): ExternallyDeliveredOrderEntity
    {
        $externallyDeliveredOrderEntity = $this->autoMapping->map(ExternallyDeliveredOrderCreateRequest::class,
            ExternallyDeliveredOrderEntity::class, $request);

        $this->entityManager->persist($externallyDeliveredOrderEntity);
        $this->entityManager->flush();

        return $externallyDeliveredOrderEntity;
    }
}
