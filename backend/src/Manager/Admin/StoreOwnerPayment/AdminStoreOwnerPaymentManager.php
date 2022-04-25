<?php

namespace App\Manager\Admin\StoreOwnerPayment;

use App\AutoMapping;
use App\Entity\StoreOwnerPaymentEntity;
use App\Repository\StoreOwnerPaymentEntityRepository;
use App\Request\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Payment\PaymentConstant;
use App\Manager\Subscription\SubscriptionManager;

class AdminStoreOwnerPaymentManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private StoreOwnerPaymentEntityRepository $storeOwnerPaymentEntityRepository;
    private StoreOwnerProfileManager $storeOwnerProfileManager;
    private SubscriptionManager $subscriptionManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, StoreOwnerPaymentEntityRepository $storeOwnerPaymentEntityRepository, StoreOwnerProfileManager $storeOwnerProfileManager, SubscriptionManager $subscriptionManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->storeOwnerPaymentEntityRepository = $storeOwnerPaymentEntityRepository;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
        $this->subscriptionManager = $subscriptionManager;
    }

    public function createStoreOwnerPayment(AdminStoreOwnerPaymentCreateRequest $request): StoreOwnerPaymentEntity|string
    {
        $subscriptionEntity = null;
       
        $store = $this->storeOwnerProfileManager->getStoreOwnerProfile($request->getStore());
       
        if(! $store) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }
       
        $request->setStore($store);
        
        if($request->getSubscriptionId() > 0 && $request->getSubscriptionFlag() > 0) {
            $subscriptionEntity = $this->subscriptionManager->getSubscriptionById($request->getSubscriptionId());
        } 

        $storeOwnerPaymentEntity = $this->autoMapping->map(AdminStoreOwnerPaymentCreateRequest::class, StoreOwnerPaymentEntity::class, $request);
        $storeOwnerPaymentEntity->setSubscription($subscriptionEntity);

        $this->entityManager->persist($storeOwnerPaymentEntity);
        $this->entityManager->flush();
        
        if($subscriptionEntity) {
           $this->subscriptionManager->updateSubscriptionFlag($subscriptionEntity, $request->getSubscriptionFlag());
        }
        
        return $storeOwnerPaymentEntity;
    }

    public function deleteStoreOwnerPayment($id): StoreOwnerPaymentEntity|string
    {
        $storeOwnerPaymentEntity = $this->storeOwnerPaymentEntityRepository->find($id);

        if (! $storeOwnerPaymentEntity) {     
            
            return PaymentConstant::PAYMENT_NOT_EXISTS;
        }
       
        $this->entityManager->remove($storeOwnerPaymentEntity);
        $this->entityManager->flush();
       
        return $storeOwnerPaymentEntity;
    }

    public function getAllStorePayments(int $storeId): ?array
    {
        return $this->storeOwnerPaymentEntityRepository->getAllStorePayments($storeId);
    }
}
