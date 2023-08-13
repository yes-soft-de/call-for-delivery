<?php

namespace App\Manager\EPaymentFromStoreLog;

use App\AutoMapping;
use App\Entity\EPaymentFromStoreLogEntity;
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

    public function createEPaymentFromStoreLog(EPaymentFromStoreLogCreateRequest $request): EPaymentFromStoreLogEntity
    {
        $ePaymentFromStoreLogEntity = $this->autoMapping->map(EPaymentFromStoreLogCreateRequest::class,
            EPaymentFromStoreLogEntity::class, $request);

        $this->entityManager->persist($ePaymentFromStoreLogEntity);
        $this->entityManager->flush();

        return $ePaymentFromStoreLogEntity;
    }
}
