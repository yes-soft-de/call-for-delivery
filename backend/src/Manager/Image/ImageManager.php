<?php

namespace App\Manager\Image;

use App\AutoMapping;
use App\Constant\Image\ImageResultConstant;
use App\Entity\ImageEntity;
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

    public function createImage(string $image, string $id, int $entity, int $usedAs): ?ImageEntity
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

}
