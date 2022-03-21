<?php

namespace App\Service\Image;

use App\AutoMapping;
use App\Constant\Image\ImageResultConstant;
use App\Entity\ImageEntity;
use App\Manager\Image\ImageManager;
use App\Request\Image\ImageCreateRequest;
use App\Request\Image\ImageUpdateRequest;
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

    public function update(ImageUpdateRequest $request): string|ImageGetResponse
    {
        $imageResult = $this->imageManager->update($request);

        if ($imageResult === ImageResultConstant::IMAGE_WAS_NOT_FOUND) {
            return ImageResultConstant::IMAGE_WAS_NOT_FOUND;

        } else {
            return $this->autoMapping->map(ImageEntity::class, ImageGetResponse::class, $imageResult);
        }
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

    /**
     * This function return either null or object of image URLs: baseURL, imageURL, and image
     */
    public function getOneImageByItemIdAndEntityTypeAndImageAim(int $itemId, int $entityType, int $usedAs): ?array
    {
        $imageEntityResult = $this->imageManager->getOneImageByItemIdAndEntityTypeAndImageAim($itemId, $entityType, $usedAs);

        if (! $imageEntityResult) {
            return null;

        } else {
            return $this->uploadFileHelperService->getImageParams($imageEntityResult->getImagePath());
        }
    }

    /**
     * This function return either null or full image information
     */
    public function getImageByItemIdAndEntityTypeAndImageAim(int $itemId, int $entityType, int $usedAs): ?ImageEntity
    {
        return $this->imageManager->getOneImageByItemIdAndEntityTypeAndImageAim($itemId, $entityType, $usedAs);
    }
}
