<?php

namespace App\Service\Image;

use App\AutoMapping;
use App\Entity\ImageEntity;
use App\Manager\Image\ImageManager;
use App\Request\Image\ImageCreateRequest;
use App\Response\Image\ImageCreateResponse;
use App\Response\Image\ImageGetResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class ImageService
{
    private string $params;

    public function __construct(private AutoMapping $autoMapping, private ImageManager $imageManager, ParameterBagInterface $params)
    {
        $this->params = $params->get('upload_base_url') . '/';
    }

    public function create(ImageCreateRequest $request)
    {
        $imageResult = $this->imageManager->create($request);

        return $this->autoMapping->map(ImageEntity::class, ImageCreateResponse::class, $imageResult);
    }

    public function getImagesByItemIdAndEntityTypeAndImageAim(int $itemId, string $entityType, string $imageAim): ?array
    {
        $response = [];

        $imagesResult = $this->imageManager->getImagesByItemIdAndEntityTypeAndImageAim($itemId, $entityType, $imageAim);

        if($imagesResult) {
            foreach ($imagesResult as $image) {
                $image['image'] = $this->getImageParams($image['imagePath'], $this->params.$image['imagePath'], $this->params);

                $response[] = $this->autoMapping->map('array', ImageGetResponse::class, $image);
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
