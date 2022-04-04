<?php

namespace App\Manager\Admin\StoreOwnerPayment;

use App\AutoMapping;
use App\Entity\StoreOwnerPaymentEntity;
use App\Repository\StoreOwnerPaymentEntityRepository;
use App\Request\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentCreateRequest;
use App\Request\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\StoreOwner\StoreOwnerProfileManager;

class AdminStoreOwnerPaymentManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private StoreOwnerPaymentEntityRepository $storeOwnerPaymentEntityRepository;
    private StoreOwnerProfileManager $storeOwnerProfileManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, StoreOwnerPaymentEntityRepository $storeOwnerPaymentEntityRepository, StoreOwnerProfileManager $storeOwnerProfileManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->storeOwnerPaymentEntityRepository = $storeOwnerPaymentEntityRepository;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
    }

    public function createStoreOwnerPayment(AdminStoreOwnerPaymentCreateRequest $request): StoreOwnerPaymentEntity
    {
        $request->setStore($this->storeOwnerProfileManager->getStoreOwnerProfile($request->getStore()));

        $storeOwnerPaymentEntity = $this->autoMapping->map(AdminStoreOwnerPaymentCreateRequest::class, StoreOwnerPaymentEntity::class, $request);

        $this->entityManager->persist($storeOwnerPaymentEntity);
        $this->entityManager->flush();

        return $storeOwnerPaymentEntity;
    }

    public function updateStoreOwnerPayment(AdminStoreOwnerPaymentUpdateRequest $request): ?StoreOwnerPaymentEntity 
    {
        $storeOwnerPaymentEntity = $this->storeOwnerPaymentEntityRepository->find($request->getId());

        if ($storeOwnerPaymentEntity) {
   
            $request->setStore($this->storeOwnerProfileManager->getStoreOwnerProfile($request->getStore()));

            $storeOwnerPaymentEntity = $this->autoMapping->mapToObject(AdminStoreOwnerPaymentUpdateRequest::class, StoreOwnerPaymentEntity::class, $request, $storeOwnerPaymentEntity);

            $this->entityManager->flush();
        }

        return $storeOwnerPaymentEntity;
    }

    public function getAllStorePayments(int $storeId): ?array
    {
        return $this->storeOwnerPaymentEntityRepository->getAllStorePayments($storeId);
    }
}
