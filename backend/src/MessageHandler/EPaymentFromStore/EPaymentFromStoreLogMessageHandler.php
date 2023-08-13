<?php

namespace App\MessageHandler\EPaymentFromStore;

use App\Entity\AdminProfileEntity;
use App\Entity\EPaymentFromStoreEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Message\EPaymentFromStore\EPaymentFromStoreLogCreateMessage;
use App\Repository\AdminProfileEntityRepository;
use App\Repository\EPaymentFromStoreEntityRepository;
use App\Repository\StoreOwnerProfileEntityRepository;
use App\Service\EPaymentFromStoreLog\EPaymentFromStoreLogToMySqlService;
use Symfony\Component\Messenger\Attribute\AsMessageHandler;

#[AsMessageHandler]
class EPaymentFromStoreLogMessageHandler
{
    public function __construct(
        private EPaymentFromStoreEntityRepository $ePaymentFromStoreEntityRepository,
        private StoreOwnerProfileEntityRepository $storeOwnerProfileEntityRepository,
        private AdminProfileEntityRepository $adminProfileEntityRepository,
        private EPaymentFromStoreLogToMySqlService $ePaymentFromStoreLogToMySqlService
    )
    {
    }

    public function __invoke(EPaymentFromStoreLogCreateMessage $ePaymentFromStoreLogCreateMessage)
    {
        $this->handleCreateEPaymentFromStoreLogMessage($ePaymentFromStoreLogCreateMessage);
    }

    public function getEPaymentFromStoreEntityById(int $ePaymentFromStoreId): ?EPaymentFromStoreEntity
    {
        return $this->ePaymentFromStoreEntityRepository->findOneBy(['id' => $ePaymentFromStoreId]);
    }

    public function getStoreOwnerProfileById(int $storeOwnerProfileId): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileEntityRepository->findOneBy(['id' => $storeOwnerProfileId]);
    }

    public function getAdminProfileById(int $adminProfileId): ?AdminProfileEntity
    {
        return $this->adminProfileEntityRepository->findOneBy(['id' => $adminProfileId]);
    }

    public function createEPaymentFromStoreLog(
        int $createdByUserId,
        int $action,
        ?StoreOwnerProfileEntity $storeOwnerProfile = null,
        ?EPaymentFromStoreEntity $ePaymentFromStore = null,
        ?AdminProfileEntity $adminProfile = null,
        ?string $details = null): void
    {
        $this->ePaymentFromStoreLogToMySqlService->createEPaymentFromStoreLog($createdByUserId, $action, $storeOwnerProfile,
        $ePaymentFromStore, $adminProfile, $details);
    }

    public function handleCreateEPaymentFromStoreLogMessage(EPaymentFromStoreLogCreateMessage $ePaymentFromStoreLogCreateMessage): void
    {
        $ePaymentFromStore = null;
        $storeOwnerProfile = null;
        $adminProfile = null;

        if ($ePaymentFromStoreLogCreateMessage->getEPaymentFromStore()) {
            $ePaymentFromStore = $this->getEPaymentFromStoreEntityById($ePaymentFromStoreLogCreateMessage->getEPaymentFromStore());
        }

        if ($ePaymentFromStoreLogCreateMessage->getStoreOwnerProfile()) {
            $storeOwnerProfile = $this->getStoreOwnerProfileById($ePaymentFromStoreLogCreateMessage->getStoreOwnerProfile());
        }

        if ($ePaymentFromStoreLogCreateMessage->getAdminProfile()) {
            $adminProfile = $this->getAdminProfileById($ePaymentFromStoreLogCreateMessage->getAdminProfile());
        }

        $this->createEPaymentFromStoreLog($ePaymentFromStoreLogCreateMessage->getCreatedByUserId(),
            $ePaymentFromStoreLogCreateMessage->getAction(), $storeOwnerProfile, $ePaymentFromStore, $adminProfile,
            $ePaymentFromStoreLogCreateMessage->getDetails());
    }
}
