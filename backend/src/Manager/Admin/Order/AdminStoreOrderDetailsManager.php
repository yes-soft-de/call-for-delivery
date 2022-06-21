<?php

namespace App\Manager\Admin\Order;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Entity\ImageEntity;
use App\Entity\StoreOrderDetailsEntity;
use App\Repository\StoreOrderDetailsEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\Admin\StoreOwnerBranch\AdminStoreOwnerBranchManager;
use App\Manager\Image\ImageManager;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Request\Image\ImageCreateRequest;
use App\Request\Admin\Order\UpdateOrderByAdminRequest;

class AdminStoreOrderDetailsManager
{
    private $imageManager;
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
}
