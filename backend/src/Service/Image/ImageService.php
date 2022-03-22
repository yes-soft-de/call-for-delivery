<?php

namespace App\Service\Image;

use App\AutoMapping;
use App\Entity\ImageEntity;
use App\Manager\Image\ImageManager;
use App\Request\Image\ImageCreateRequest;
use App\Response\Image\ImageCreateResponse;
use App\Response\Image\ImageGetResponse;
use App\Service\FileUpload\UploadFileHelperService;

class ImageService implements ImageServiceInterface
{
    private AutoMapping $autoMapping;
    private ImageManager $imageManager;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, ImageManager $imageManager, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->imageManager = $imageManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
    }

    public function create(ImageCreateRequest $request): ImageCreateResponse
    {
        $imageResult = $this->imageManager->create($request);

        return $this->autoMapping->map(ImageEntity::class, ImageCreateResponse::class, $imageResult);
    }

    public function getImagesByItemIdAndEntityTypeAndImageAim(int $itemId, int $entityType, int $usedAs): ?array
    {
        $response = [];

        $imageEntityResults = $this->imageManager->getImagesByItemIdAndEntityTypeAndImageAim($itemId, $entityType, $usedAs);

        if($imageEntityResults) {
            foreach ($imageEntityResults as $imageEntity) {
                $imageResponse = $this->autoMapping->map(ImageEntity::class, ImageGetResponse::class, $imageEntity);

                $imageResponse->image = $this->uploadFileHelperService->getImageParams($imageEntity->getImagePath());

                $response[] = $imageResponse;
            }
        }

        return $response;
    }

    public function getOneImageByItemIdAndEntityTypeAndImageAim(int $itemId, int $entityType, int $usedAs): ?array
    {
        $imageEntityResult = $this->imageManager->getOneImageByItemIdAndEntityTypeAndImageAim($itemId, $entityType, $usedAs);

        if (! $imageEntityResult) {
            return null;

        } else {
            return $this->uploadFileHelperService->getImageParams($imageEntityResult->getImagePath());
        }
    }
}
