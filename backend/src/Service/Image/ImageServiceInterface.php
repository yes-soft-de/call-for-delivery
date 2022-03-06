<?php

namespace App\Service\Image;

use App\Request\Image\ImageCreateRequest;

interface ImageServiceInterface
{
    public function create(ImageCreateRequest $request);

    public function getImagesByItemIdAndEntityTypeAndImageAim(int $itemId, int $entityType, int $usedAs);
}
