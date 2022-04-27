<?php

namespace App\Manager\BidDetails;

use App\AutoMapping;
use App\Constant\BidDetails\BidDetailsOpenToPriceOfferStatusConstant;
use App\Entity\BidDetailsEntity;
use App\Entity\OrderEntity;
use App\Manager\Image\ImageManager;
use App\Manager\SupplierCategory\SupplierCategoryManager;
use App\Repository\BidDetailsEntityRepository;
use App\Request\Order\BidDetailsCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class BidDetailsManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private SupplierCategoryManager $supplierCategoryManager;
    private ImageManager $imageManager;
    private BidDetailsEntityRepository $bidDetailsEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, SupplierCategoryManager $supplierCategoryManager, ImageManager $imageManager,
                                BidDetailsEntityRepository $bidDetailsEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->supplierCategoryManager = $supplierCategoryManager;
        $this->imageManager= $imageManager;
        $this->bidDetailsEntityRepository= $bidDetailsEntityRepository;
    }

    public function createBidDetails(BidDetailsCreateRequest $request, OrderEntity $orderEntity): string|BidDetailsEntity
    {
//        $storeOwnerProfileEntity = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($request->getStoreOwnerProfile());
//        $request->setStoreOwnerProfile($storeOwnerProfileEntity);
//
//        if ($storeOwnerProfileEntity->getStatus() !== StoreProfileConstant::STORE_OWNER_PROFILE_ACTIVE_STATUS) {
//            return StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS;
//        }

        $supplierCategoryEntity = $this->supplierCategoryManager->getSupplierCategoryEntityByCategoryId($request->getSupplierCategory());
        $request->setSupplierCategory($supplierCategoryEntity);

        $bidDetailsEntity = $this->autoMapping->map(BidDetailsCreateRequest::class, BidDetailsEntity::class, $request);

        $bidDetailsEntity->setOrderId($orderEntity);
        $bidDetailsEntity->setOpenToPriceOffer(BidDetailsOpenToPriceOfferStatusConstant::BID_ORDER_OPEN_TO_PRICE_OFFER);

        $this->entityManager->persist($bidDetailsEntity);
        $this->entityManager->flush();

        if (! empty($request->getImagesArray())) {
            $this->createBidDetailsImages($request->getImagesArray(), $bidDetailsEntity);
        }

        return $bidDetailsEntity;
    }

    public function createBidDetailsImages(array $images, BidDetailsEntity $bidDetailsEntity): void
    {
        $this->imageManager->createBidDetailsImages($images, $bidDetailsEntity);
    }

    public function getBidDetailsEntityByBidOrderId(int $id): ?BidDetailsEntity
    {
        return $this->bidDetailsEntityRepository->find($id);
    }

    public function updateBidDetailsToBeClosedForPriceOffer(int $bidDetailsId): ?BidDetailsEntity
    {
        $bidDetailsEntity = $this->bidDetailsEntityRepository->find($bidDetailsId);

        if (! $bidDetailsEntity) {
            return $bidDetailsEntity;
        }

        $bidDetailsEntity->setOpenToPriceOffer(BidDetailsOpenToPriceOfferStatusConstant::BID_ORDER_CLOSED_TO_PRICE_OFFER);

        $this->entityManager->flush();

        return $bidDetailsEntity;
    }
}
