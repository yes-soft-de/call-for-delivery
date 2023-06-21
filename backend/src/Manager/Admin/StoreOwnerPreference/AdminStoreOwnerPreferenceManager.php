<?php

namespace App\Manager\Admin\StoreOwnerPreference;

use App\AutoMapping;
use App\Entity\StoreOwnerPreferenceEntity;
use App\Repository\StoreOwnerPreferenceEntityRepository;
use App\Request\Admin\StoreOwnerPreference\StoreOwnerPreferenceCreateByAdminRequest;
use App\Request\Admin\StoreOwnerPreference\StoreOwnerPreferenceUpdateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminStoreOwnerPreferenceManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private StoreOwnerPreferenceEntityRepository $storeOwnerPreferenceEntityRepository
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

    public function updateStoreOwnerPreferenceByAdmin(StoreOwnerPreferenceUpdateByAdminRequest $request): ?StoreOwnerPreferenceEntity
    {
        $storeOwnerPreference = $this->storeOwnerPreferenceEntityRepository->findOneBy(['id' => $request->getId()]);

        if ($storeOwnerPreference) {
            $storeOwnerPreference = $this->autoMapping->mapToObject(StoreOwnerPreferenceUpdateByAdminRequest::class,
                StoreOwnerPreferenceEntity::class, $request, $storeOwnerPreference);

            $this->entityManager->flush();
        }

        return $storeOwnerPreference;
    }

    public function getStoreOwnerPreferenceByStoreOwnerProfileId(int $storeOwnerProfileId): ?StoreOwnerPreferenceEntity
    {
        return $this->storeOwnerPreferenceEntityRepository->findOneBy(['storeOwnerProfile' => $storeOwnerProfileId]);
    }
}
