<?php

namespace App\Manager\Order;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Entity\ImageEntity;
use App\Entity\StoreOrderDetailsEntity;
use App\Repository\StoreOrderDetailsEntityRepository;
use App\Request\Order\OrderCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\StoreOwnerBranch\StoreOwnerBranchManager;
use App\Manager\Image\ImageManager;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Request\Image\ImageCreateRequest;

class StoreOrderDetailsManager
{
    private $imageManager;
    private StoreOrderDetailsEntityRepository $storeOrderDetailsEntityRepository;
    
    public function __construct(private AutoMapping $autoMapping, private EntityManagerInterface $entityManager, StoreOrderDetailsEntityRepository $storeOrderDetailsEntityRepository, private StoreOwnerBranchManager $storeOwnerBranchManager, ImageManager $imageManager)
    {
        $this->imageManager = $imageManager;
        $this->storeOrderDetailsEntityRepository = $storeOrderDetailsEntityRepository;
    }
    
    /**
     * @param OrderCreateRequest $request
     * @param OrderEntity $orderEntity
     * @return StoreOrderDetailsEntity|null
     */
    public function createOrderDetail(OrderEntity $orderEntity, OrderCreateRequest $request): ?StoreOrderDetailsEntity
    {      
       $branch = $this->storeOwnerBranchManager->getBranchById($request->getBranch());
       $request->setBranch($branch);

       $orderDetailEntity = $this->autoMapping->map(OrderCreateRequest::class, StoreOrderDetailsEntity::class, $request);

       $orderDetailEntity->setOrderId($orderEntity);
    
       if($request->getImages()) {
      
            $imageEntity = $this->createImage($request->getImages(), $orderEntity->getId());
      
            $orderDetailEntity->setImages($imageEntity);        
        }
    
       $this->entityManager->persist($orderDetailEntity);
       $this->entityManager->flush();

       return  $orderDetailEntity;
    }

    public function createImage(string $image, int $id): ImageEntity
    {
        $request = new ImageCreateRequest();
       
        $request->setImagePath($image);
        $request->setEntityType(ImageEntityTypeConstant::ENTITY_TYPE_ORDER);
        $request->setUsedAs(ImageUseAsConstant::IMAGE_USE_AS_ORDER_IMAGE);
        $request->setItemId($id);

        return $this->imageManager->create($request);
        return $request;
    }

    public function getOrderDetailsByOrderId(int $orderId): ?StoreOrderDetailsEntity
    {
        return $this->storeOrderDetailsEntityRepository->findOneBy(['orderId' =>$orderId]);
    }
}
