<?php

namespace App\Manager\Image;

use App\AutoMapping;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageResultConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Entity\AdminProfileEntity;
use App\Entity\AnnouncementEntity;
use App\Entity\BidOrderEntity;
use App\Entity\ImageEntity;
use App\Entity\SupplierProfileEntity;
use App\Repository\ImageEntityRepository;
use App\Request\Image\ImageCreateRequest;
use App\Request\Image\ImageUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class ImageManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private ImageEntityRepository $imageEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ImageEntityRepository $imageEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->imageEntityRepository = $imageEntityRepository;
    }

    public function create(ImageCreateRequest $request): ImageEntity
    {
        $imageEntity = $this->autoMapping->map(ImageCreateRequest::class, ImageEntity::class, $request);

        $this->entityManager->persist($imageEntity);
        $this->entityManager->flush();

        return $imageEntity;
    }

    public function update(ImageUpdateRequest $request): string|ImageEntity
    {
        $imageEntity = $this->imageEntityRepository->find($request->getId());

        if (! $imageEntity) {
            return ImageResultConstant::IMAGE_WAS_NOT_FOUND;

        } else {
            $imageEntity = $this->autoMapping->mapToObject(ImageUpdateRequest::class, ImageEntity::class, $request, $imageEntity);

            $this->entityManager->flush();

            return $imageEntity;
        }
    }

    public function getImagesByItemIdAndEntityTypeAndImageAim(int $itemId, int $entityType, int $usedAs): ?array
    {
        return $this->imageEntityRepository->getImagesByItemIdAndEntityTypeAndImageAim($itemId, $entityType, $usedAs);
    }

    public function getOneImageByItemIdAndEntityTypeAndImageAim(int $itemId, int $entityType, int $usedAs): ?ImageEntity
    {
        return $this->imageEntityRepository->getOneImageByItemIdAndEntityTypeAndImageAim($itemId, $entityType, $usedAs);
    }

    public function createImage(string $image, int $id, int $entity, int $usedAs): ?ImageEntity
    {
        $request = new ImageCreateRequest();
           
        $request->setImagePath($image);
        $request->setEntityType( $entity);
        $request->setUsedAs($usedAs);
        $request->setItemId($id);
    
        return $this->create($request);
    }
    
    public function getImagesByItemIdAndEntityType(int $itemId, int $entityType): ?array
    {
        return $this->imageEntityRepository->getImagesByItemIdAndEntityType($itemId, $entityType);
    }
    
    public function createImageOrUpdate(string $image, string $id, int $entity, int $usedAs): ?ImageEntity
    {       
       $imageEntity = $this->imageEntityRepository->findOneBy(["entityType" => $entity , "usedAs" => $usedAs, "itemId" => $id]);

       if(! $imageEntity) {
            $request = new ImageCreateRequest();
            
            $request->setImagePath($image);
            $request->setEntityType( $entity);
            $request->setUsedAs($usedAs);
            $request->setItemId($id);
          
            return $this->create($request);
       }
    
       return  $this->updateImage($image, $imageEntity);
    }

    public function createOrUpdateAdminProfileImages(array $images, AdminProfileEntity $adminProfileEntity): array
    {
        $response = [];

        foreach ($images as $image) {
            $imageEntity = $this->imageEntityRepository->findOneBy(["user" => $adminProfileEntity->getId()]);

            if(! $imageEntity) {
                $request = new ImageCreateRequest();

                $request->setImagePath($image['image']);
                $request->setEntityType(ImageEntityTypeConstant::ENTITY_TYPE_ADMIN_PROFILE);
                $request->setUsedAs(ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);
                $request->setItemId($adminProfileEntity->getId());
                $request->setUser($adminProfileEntity);

                $response[] = $this->create($request);

            } else {
                $response[] = $this->updateImage($image['image'], $imageEntity);
            }
        }

        return $response;
    }

    public function createOrUpdateSupplierProfileImages(array $images, SupplierProfileEntity $supplierProfileEntity): array
    {
        $response = [];

        foreach ($images as $image) {
            $imageEntity = $this->imageEntityRepository->findOneBy(["supplierProfile" => $supplierProfileEntity->getId()]);

            if(! $imageEntity) {
                $request = new ImageCreateRequest();

                $request->setImagePath($image['image']);
                $request->setEntityType(ImageEntityTypeConstant::ENTITY_TYPE_SUPPLIER_PROFILE);
                $request->setUsedAs(ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);
                $request->setItemId($supplierProfileEntity->getId());
                $request->setSupplierProfile($supplierProfileEntity);

                $response[] = $this->create($request);

            } else {
                $response[] = $this->updateImage($image['image'], $imageEntity);
            }
        }

        return $response;
    }

    public function createAnnouncementImages(array $images, AnnouncementEntity $announcementEntity): array
    {
        $response = [];

        foreach ($images as $image) {
            $request = new ImageCreateRequest();

            $request->setImagePath($image['image']);
            $request->setEntityType(ImageEntityTypeConstant::ENTITY_TYPE_ANNOUNCEMENT);
            $request->setUsedAs(ImageUseAsConstant::IMAGE_USE_AS_ANNOUNCEMENT);
            $request->setItemId($announcementEntity->getId());
            $request->setAnnouncement($announcementEntity);

            $response[] = $this->create($request);
        }

        return $response;
    }

    public function createOrUpdateAnnouncementImages(array $images, AnnouncementEntity $announcementEntity): array
    {
        $response = [];

        foreach ($images as $image) {
            $imageEntity = $this->imageEntityRepository->findOneBy(["announcement" => $announcementEntity->getId()]);

            if(! $imageEntity) {
                $request = new ImageCreateRequest();

                $request->setImagePath($image['image']);
                $request->setEntityType(ImageEntityTypeConstant::ENTITY_TYPE_ANNOUNCEMENT);
                $request->setUsedAs(ImageUseAsConstant::IMAGE_USE_AS_ANNOUNCEMENT);
                $request->setItemId($announcementEntity->getId());
                $request->setAnnouncement($announcementEntity);

                $response[] = $this->create($request);

            } else {
                $response[] = $this->updateImage($image['image'], $imageEntity);
            }
        }

        return $response;
    }

    public function updateImage(string $image, ImageEntity $imageEntity): ?ImageEntity
    {
        if($imageEntity) {
            $imageEntity->setImagePath($image);
        }

        $this->entityManager->flush();    

        return $imageEntity;
    }

    public function createBidOrderImages(array $images, BidOrderEntity $bidOrderEntity): array
    {
        $response = [];

        foreach ($images as $image) {
            $request = new ImageCreateRequest();

            $request->setImagePath($image['image']);
            $request->setEntityType(ImageEntityTypeConstant::ENTITY_TYPE_BID_ORDER);
            $request->setUsedAs(ImageUseAsConstant::IMAGE_USE_AS_ORDER_IMAGE);
            $request->setItemId($bidOrderEntity->getId());
            $request->setBidOrder($bidOrderEntity);

            $response[] = $this->create($request);
        }

        return $response;
    }
}
