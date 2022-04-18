<?php

namespace App\Manager\BidOrder;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Entity\BidOrderEntity;
use App\Manager\Image\ImageManager;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Manager\SupplierCategory\SupplierCategoryManager;
use App\Repository\BidOrderEntityRepository;
use App\Request\BidOrder\BidOrderCreateRequest;
use App\Request\BidOrder\BidOrderFilterBySupplierRequest;
use Doctrine\ORM\EntityManagerInterface;

class BidOrderManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private SupplierCategoryManager $supplierCategoryManager;
    private StoreOwnerProfileManager $storeOwnerProfileManager;
    private ImageManager $imageManager;
    private BidOrderEntityRepository $bidOrderEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, SupplierCategoryManager $supplierCategoryManager, StoreOwnerProfileManager $storeOwnerProfileManager,
                                ImageManager $imageManager, BidOrderEntityRepository $bidOrderEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->supplierCategoryManager = $supplierCategoryManager;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
        $this->imageManager= $imageManager;
        $this->bidOrderEntityRepository= $bidOrderEntityRepository;
    }

    public function createBidOrder(BidOrderCreateRequest $request): string|BidOrderEntity
    {
        $storeOwnerProfileEntity = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($request->getStoreOwnerProfile());
        $request->setStoreOwnerProfile($storeOwnerProfileEntity);

        if ($storeOwnerProfileEntity->getStatus() !== StoreProfileConstant::STORE_OWNER_PROFILE_ACTIVE_STATUS) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS;
        }

        $supplierCategoryEntity = $this->supplierCategoryManager->getSupplierCategoryEntityByCategoryId($request->getSupplierCategory());
        $request->setSupplierCategory($supplierCategoryEntity);

        $bidOrderEntity = $this->autoMapping->map(BidOrderCreateRequest::class, BidOrderEntity::class, $request);

        $this->entityManager->persist($bidOrderEntity);
        $this->entityManager->flush();

        if (! empty($request->getImagesArray())) {
            $this->createBidOrderImages($request->getImagesArray(), $bidOrderEntity);
        }

        return $bidOrderEntity;
    }

    public function createBidOrderImages(array $images, BidOrderEntity $bidOrderEntity): void
    {
        $this->imageManager->createBidOrderImages($images, $bidOrderEntity);
    }

    public function filterBidOrdersBySupplier(BidOrderFilterBySupplierRequest $request): array
    {
        return $this->bidOrderEntityRepository->filterBidOrdersBySupplier($request);
    }

    public function getBidOrderEntityByBidOrderId(int $id): ?BidOrderEntity
    {
        return $this->bidOrderEntityRepository->find($id);
    }
}
