<?php

namespace App\Manager\EPaymentFromStoreLog;

use App\AutoMapping;
use App\Entity\EPaymentFromStoreEntity;
use App\Request\EPaymentFromStoreLog\EPaymentFromStoreLogCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class EPaymentFromStoreLogManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager
    )
    {
    }

    public function createEPaymentFromStoreLog(EPaymentFromStoreLogCreateRequest $request): EPaymentFromStoreEntity
    {
        $ePaymentFromStoreEntity = $this->autoMapping->map(EPaymentFromStoreLogCreateRequest::class,
            EPaymentFromStoreEntity::class, $request);

        $this->entityManager->persist($ePaymentFromStoreEntity);
        $this->entityManager->flush();

        return $ePaymentFromStoreEntity;
    }
}
