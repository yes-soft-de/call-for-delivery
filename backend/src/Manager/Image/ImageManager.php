<?php

namespace App\Manager\Image;

use App\AutoMapping;
use App\Entity\ImageEntity;
use App\Repository\ImageEntityRepository;
use App\Request\Image\ImageCreateRequest;
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

    public function getImagesByItemIdAndEntityTypeAndImageAim(int $itemId, int $entityType, int $usedAs): ?array
    {
        return $this->imageEntityRepository->getImagesByItemIdAndEntityTypeAndImageAim($itemId, $entityType, $usedAs);
    }
}
