<?php

namespace App\Manager\EPaymentFromStore;

use App\AutoMapping;
use App\Entity\EPaymentFromStoreEntity;
use App\Request\EPayment\EPaymentCreateByStoreOwnerRequest;
use Doctrine\ORM\EntityManagerInterface;

class EPaymentFromStoreManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager
    )
    {
    }

    public function createEPaymentFromStore(EPaymentCreateByStoreOwnerRequest $request): EPaymentFromStoreEntity
    {
        $ePaymentFromStoreEntity = $this->autoMapping->map(EPaymentCreateByStoreOwnerRequest::class,
            EPaymentFromStoreEntity::class, $request);

        $this->entityManager->persist($ePaymentFromStoreEntity);
        $this->entityManager->flush();

        return $ePaymentFromStoreEntity;
    }
}
