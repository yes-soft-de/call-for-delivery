<?php

namespace App\Service\Image;

use App\AutoMapping;
use App\Entity\ImageEntity;
use App\Manager\Image\ImageManager;
use App\Request\Image\ImageCreateRequest;
use App\Response\Image\ImageCreateResponse;
use App\Response\Image\ImageGetResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class ImageService implements ImageServiceInterface
{
    private string $params;

    public function __construct(private AutoMapping $autoMapping, private ImageManager $imageManager, ParameterBagInterface $params)
    {
        $this->params = $params->get('upload_base_url') . '/';
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
                $response[] = $this->autoMapping->map(ImageEntity::class, ImageGetResponse::class, $imageEntity);
            }
        }

        return $response;
    }

    public function getImageParams($imageURL, $image, $baseURL): array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }
}
