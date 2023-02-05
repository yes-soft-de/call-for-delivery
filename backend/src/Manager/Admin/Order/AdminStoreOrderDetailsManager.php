<?php

namespace App\Manager\Admin\Order;

use App\AutoMapping;
use App\Constant\Order\OrderDestinationConstant;
use App\Constant\StoreOrderDetails\StoreOrderDetailsConstant;
use App\Entity\OrderEntity;
use App\Entity\ImageEntity;
use App\Entity\StoreOrderDetailsEntity;
use App\Repository\StoreOrderDetailsEntityRepository;
use App\Request\Admin\Order\OrderCreateByAdminRequest;
use App\Request\Admin\Order\OrderRecycleOrCancelByAdminRequest;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceAdditionByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\Admin\StoreOwnerBranch\AdminStoreOwnerBranchManager;
use App\Manager\Image\ImageManager;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Request\Image\ImageCreateRequest;
use App\Request\Admin\Order\UpdateOrderByAdminRequest;

class AdminStoreOrderDetailsManager
{
    private ImageManager $imageManager;
    private StoreOrderDetailsEntityRepository $storeOrderDetailsEntityRepository;
    private AdminStoreOwnerBranchManager $adminStoreOwnerBranchManager;
    private EntityManagerInterface $entityManager;
    private AutoMapping $autoMapping;
    
    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, StoreOrderDetailsEntityRepository $storeOrderDetailsEntityRepository, ImageManager $imageManager, AdminStoreOwnerBranchManager $adminStoreOwnerBranchManager)
    {
        $this->imageManager = $imageManager;
        $this->storeOrderDetailsEntityRepository = $storeOrderDetailsEntityRepository;
        $this->adminStoreOwnerBranchManager = $adminStoreOwnerBranchManager;
        $this->entityManager = $entityManager;
        $this->autoMapping = $autoMapping;
    }

    public function updateOrderDetail(OrderEntity $orderEntity, UpdateOrderByAdminRequest $request): ?StoreOrderDetailsEntity
    {
        $storeOrderDetailsEntity = $this->storeOrderDetailsEntityRepository->findOneBy(["orderId"=>$orderEntity->getId()]);

        if ($storeOrderDetailsEntity) {
            $request->setId($storeOrderDetailsEntity->getId());

            $branch = $this->adminStoreOwnerBranchManager->getBranchById($request->getBranch());

            if ($branch) {
                $request->setBranch($branch);
            }

            if ($request->getImages()) {
                $imageEntity = $this->createImageOrUpdate($request->getImages(), $orderEntity->getId());

                $request->setImages($imageEntity);
            }

            $storeOrderDetailsEntity = $this->autoMapping->mapToObject(UpdateOrderByAdminRequest::class, StoreOrderDetailsEntity::class,
                $request, $storeOrderDetailsEntity);

            $this->entityManager->persist($storeOrderDetailsEntity);
            $this->entityManager->flush();
        }

        return $storeOrderDetailsEntity;
    }

    public function createImageOrUpdate(string $image, int $id): ?ImageEntity
    {
        return $this->imageManager->createImageOrUpdate($image, $id, ImageEntityTypeConstant::ENTITY_TYPE_ORDER, ImageUseAsConstant::IMAGE_USE_AS_ORDER_IMAGE);
    }

    public function createOrderDetailsByAdmin(OrderEntity $orderEntity, OrderCreateByAdminRequest $request): StoreOrderDetailsEntity
    {
        $orderDetailEntity = $this->autoMapping->map(OrderCreateByAdminRequest::class, StoreOrderDetailsEntity::class, $request);

        $orderDetailEntity->setOrderId($orderEntity);

        if ($request->getImages()) {
            $imageEntity = $this->createImage($request->getImages(), $orderEntity->getId());

            $orderDetailEntity->setImages($imageEntity);
        }

        $this->entityManager->persist($orderDetailEntity);
        $this->entityManager->flush();

        return $orderDetailEntity;
    }

    public function createImage(string $image, int $id): ImageEntity
    {
        $request = new ImageCreateRequest();

        $request->setImagePath($image);
        $request->setEntityType(ImageEntityTypeConstant::ENTITY_TYPE_ORDER);
        $request->setUsedAs(ImageUseAsConstant::IMAGE_USE_AS_ORDER_IMAGE);
        $request->setItemId($id);

        return $this->imageManager->create($request);
    }
    
    public function updateDestination(int $orderId, array $destination): ?StoreOrderDetailsEntity
    {
        $storeOrderDetailsEntity = $this->storeOrderDetailsEntityRepository->findOneBy(["orderId"=>$orderId]);

        if ($storeOrderDetailsEntity) {
            $storeOrderDetailsEntity->setDestination($destination);
            $this->entityManager->flush();
        }

        return $storeOrderDetailsEntity;
    }

    public function updateDestinationByAddition(int $orderId, array $destination): ?StoreOrderDetailsEntity
    {
        $storeOrderDetailsEntity = $this->storeOrderDetailsEntityRepository->findOneBy(["orderId"=>$orderId]);

        if ($storeOrderDetailsEntity) {
            $storeOrderDetailsEntity->setDestination($destination);
            // set that the receiver location is different, and had been updated by the admin
            $storeOrderDetailsEntity->setDifferentReceiverDestination(OrderDestinationConstant::ORDER_DESTINATION_IS_DIFFERENT_AND_UPDATED_BY_ADMIN_CONST);

            $this->entityManager->flush();
        }

        return $storeOrderDetailsEntity;
    }

    public function updateStoreOrderDetailsAfterRecyclingByAdmin(OrderEntity $orderEntity, OrderRecycleOrCancelByAdminRequest $request): ?StoreOrderDetailsEntity
    {
        $storeOrderDetailsEntity = $this->storeOrderDetailsEntityRepository->findOneBy(["orderId"=>$orderEntity->getId()]);

        if ($storeOrderDetailsEntity) {
            $request->setId($storeOrderDetailsEntity->getId());

            $branch = $this->adminStoreOwnerBranchManager->getBranchById($request->getBranch());

            if ($branch) {
                $request->setBranch($branch);
            }

            if ($request->getImages()) {
                $imageEntity = $this->createImageOrUpdate($request->getImages(), $orderEntity->getId());

                $request->setImages($imageEntity);
            }

            $storeOrderDetailsEntity = $this->autoMapping->mapToObject(OrderRecycleOrCancelByAdminRequest::class, StoreOrderDetailsEntity::class,
                $request, $storeOrderDetailsEntity);

            $this->entityManager->persist($storeOrderDetailsEntity);
            $this->entityManager->flush();
        }

        return $storeOrderDetailsEntity;
    }

    /**
     * Update differentReceiverDestination field of store order details
     */
    public function updateStoreOrderDetailsDifferentReceiverDestinationByOrderId(int $orderId, int $differentReceiverDestination): int|StoreOrderDetailsEntity
    {
        $storeOrderDetailsEntity = $this->storeOrderDetailsEntityRepository->findOneBy(["orderId" => $orderId]);

        if (! $storeOrderDetailsEntity) {
            return StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND;
        }

        // set that the receiver location is different, and had been updated by the admin
        $storeOrderDetailsEntity->setDifferentReceiverDestination($differentReceiverDestination);

        $this->entityManager->flush();

        return $storeOrderDetailsEntity;
    }
}
