<?php

namespace App\Manager\Image;

use App\AutoMapping;
use App\Entity\ImageEntity;
use App\Repository\ImageEntityRepository;
use App\Request\Image\ImageCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class ImageManager
{
    public function __construct(private AutoMapping $autoMapping, private EntityManagerInterface $entityManager, private ImageEntityRepository $imageEntityRepository)
    {
    }

    public function create(ImageCreateRequest $request)
    {
        $imageEntity = $this->autoMapping->map(ImageCreateRequest::class, ImageEntity::class, $request);

        $this->entityManager->persist($imageEntity);
        $this->entityManager->flush();

        return $imageEntity;
    }

    public function getImagesByItemIdAndEntityTypeAndImageAim(int $itemId, string $entityType, string $imageAim): ?array
    {
        return $this->imageEntityRepository->getImagesByItemIdAndEntityTypeAndImageAim($itemId, $entityType, $imageAim);
    }
}
