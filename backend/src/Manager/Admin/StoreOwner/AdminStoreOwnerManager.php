<?php

namespace App\Manager\Admin\StoreOwner;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Repository\StoreOwnerProfileEntityRepository;
use App\Request\Admin\Report\StoresAndOrdersCountDuringSpecificTimeFilterByAdminRequest;
use App\Request\Admin\StoreOwner\StoreOwnerProfileOpeningSubscriptionWithoutPaymentUpdateRequest;
use App\Request\Admin\StoreOwner\StoreOwnerProfileStatusUpdateByAdminRequest;
use App\Request\Admin\StoreOwner\StoreOwnerProfileUpdateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminStoreOwnerManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private StoreOwnerProfileEntityRepository $storeOwnerProfileEntityRepository
    )
    {
    }

    public function getStoreOwnerProfileByIdForAdmin(int $storeOwnerProfileId): ?array
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerProfileByIdForAdmin($storeOwnerProfileId);
    }

    public function getStoreOwnerBranchesByStoreOwnerProfileIdForAdmin(int $storeOwnerProfileId): ?array
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerBranchesByStoreOwnerProfileIdForAdmin($storeOwnerProfileId);
    }

    public function getStoreOwnersProfilesCountByStatusForAdmin(string $storeOwnerProfileStatus): int
    {
        return $this->storeOwnerProfileEntityRepository->count(["status" => $storeOwnerProfileStatus]);
    }

    /**
     * Gets store owners' profiles according to status
     */
    public function getStoreOwnersProfilesByStatusForAdmin(string $storeOwnerProfileStatus): ?array
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnersProfilesByStatusForAdmin($storeOwnerProfileStatus);
    }

    public function updateStoreOwnerProfileStatusByAdmin(StoreOwnerProfileStatusUpdateByAdminRequest $request): string|StoreOwnerProfileEntity
    {
        $storeOwnerProfileEntity = $this->storeOwnerProfileEntityRepository->find($request->getId());

        if(! $storeOwnerProfileEntity) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $storeOwnerProfileEntity = $this->autoMapping->mapToObject(StoreOwnerProfileStatusUpdateByAdminRequest::class, StoreOwnerProfileEntity::class,
            $request, $storeOwnerProfileEntity);

        $this->entityManager->flush();

        return $storeOwnerProfileEntity;
    }

    public function updateStoreOwnerProfileByAdmin(StoreOwnerProfileUpdateByAdminRequest $request): string|StoreOwnerProfileEntity
    {
        $storeOwnerProfileEntity = $this->storeOwnerProfileEntityRepository->find($request->getId());

        if (! $storeOwnerProfileEntity) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $storeOwnerProfileEntity = $this->autoMapping->mapToObject(StoreOwnerProfileUpdateByAdminRequest::class, StoreOwnerProfileEntity::class,
            $request, $storeOwnerProfileEntity);

        $storeOwnerProfileEntity->setOpeningTime($request->getOpeningTime());
        $storeOwnerProfileEntity->setClosingTime($request->getClosingTime());

        $this->entityManager->flush();

        return $storeOwnerProfileEntity;
    }

    public function getLastThreeActiveStoreOwnersProfilesForAdmin(): array
    {
        return $this->storeOwnerProfileEntityRepository->getLastThreeActiveStoreOwnersProfilesForAdmin();
    }

    public function getStoreOwnerProfileEntityByStoreOwnerId(int $storeOwnerId): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileEntityRepository->findOneBy(['storeOwnerId'=>$storeOwnerId]);
    }

    // Get top stores according on delivered orders during specific time
    public function filterTopStoresAccordingOnOrdersByAdmin(StoresAndOrdersCountDuringSpecificTimeFilterByAdminRequest $request): array
    {
        return $this->storeOwnerProfileEntityRepository->filterTopStoresAccordingOnOrdersByAdmin($request);
    }

    public function getStoreOwnerProfileEntityByIdForAdmin(int $id): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileEntityRepository->findOneBy(['id' => $id]);
    }

    public function updateStoreOwnerProfileOpeningSubscriptionWithoutPayment(StoreOwnerProfileOpeningSubscriptionWithoutPaymentUpdateRequest $request): ?StoreOwnerProfileEntity
    {
        $storeOwnerProfile = $this->storeOwnerProfileEntityRepository->findOneBy(['id' => $request->getId()]);

        if ($storeOwnerProfile) {
            $storeOwnerProfile->setOpeningSubscriptionWithoutPayment($request->isOpeningSubscriptionWithoutPayment());

            $this->entityManager->flush();
        }

        return $storeOwnerProfile;
    }
}
