<?php

namespace App\Manager\Admin\StoreOwnerPreference;

use App\AutoMapping;
use App\Entity\StoreOwnerPreferenceEntity;
use App\Request\Admin\StoreOwnerPreference\StoreOwnerPreferenceCreateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminStoreOwnerPreferenceManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager
    )
    {
    }

    public function createStoreOwnerPreferenceByAdmin(StoreOwnerPreferenceCreateByAdminRequest $request): StoreOwnerPreferenceEntity
    {
        $storeOwnerPreference = $this->autoMapping->map(StoreOwnerPreferenceCreateByAdminRequest::class,
            StoreOwnerPreferenceEntity::class, $request);

        $this->entityManager->persist($storeOwnerPreference);
        $this->entityManager->flush();

        return $storeOwnerPreference;
    }
}
