<?php

namespace App\Manager\Admin\StoreOwnerPayment;

use App\AutoMapping;
use App\Entity\StoreOwnerPaymentFromCompanyEntity;
use App\Repository\StoreOwnerPaymentFromCompanyEntityRepository;
use App\Request\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Payment\PaymentConstant;

class AdminStoreOwnerPaymentFromCompanyManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private StoreOwnerPaymentFromCompanyEntityRepository $storeOwnerPaymentFromCompanyEntityRepository;
    private StoreOwnerProfileManager $storeOwnerProfileManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, StoreOwnerPaymentFromCompanyEntityRepository $storeOwnerPaymentFromCompanyEntityRepository, StoreOwnerProfileManager $storeOwnerProfileManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->storeOwnerPaymentFromCompanyEntityRepository = $storeOwnerPaymentFromCompanyEntityRepository;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
    }

    public function createStoreOwnerPaymentFromCompany(AdminStoreOwnerPaymentCreateRequest $request): StoreOwnerPaymentFromCompanyEntity|string
    {
        $store = $this->storeOwnerProfileManager->getStoreOwnerProfile($request->getStore());
       
        if(! $store) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $request->setStore($store);

        $storeOwnerPaymentFromCompanyEntity = $this->autoMapping->map(AdminStoreOwnerPaymentCreateRequest::class, StoreOwnerPaymentFromCompanyEntity::class, $request);

        $this->entityManager->persist($storeOwnerPaymentFromCompanyEntity);
        $this->entityManager->flush();

        return $storeOwnerPaymentFromCompanyEntity;
    }

    public function deleteStoreOwnerPaymentFromCompany($id): StoreOwnerPaymentFromCompanyEntity|string
    {
        $storeOwnerPaymentFromCompanyEntity = $this->storeOwnerPaymentFromCompanyEntityRepository->find($id);

        if (! $storeOwnerPaymentFromCompanyEntity) {     
            
            return PaymentConstant::PAYMENT_NOT_EXISTS;
        }
       
        $this->entityManager->remove($storeOwnerPaymentFromCompanyEntity);
        $this->entityManager->flush();
       
        return $storeOwnerPaymentFromCompanyEntity;
    }

    public function getAllStorePaymentsFromCompany(int $storeId): ?array
    {
        return $this->storeOwnerPaymentFromCompanyEntityRepository->getAllStorePaymentsFromCompany($storeId);
    }

    public function getSumPaymentsFromCompany(int $storeId): ?array
    {
        return $this->storeOwnerPaymentFromCompanyEntityRepository->getSumPaymentsFromCompany($storeId);
    }
}
