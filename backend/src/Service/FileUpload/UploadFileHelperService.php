<?php

namespace App\Service\FileUpload;

use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class UploadFileHelperService
{
    private string $params;

    public function __construct(ParameterBagInterface $params)
    {
        $this->params = $params->get('upload_base_url') . '/';
    }

    public function getUploadBaseURL(): string
    {
        return $this->params;
    }

    public function getImageParams(string|null $imageURL): ?array
    {
        if ($imageURL !== null) {
            //return null;
            $item = [];
            $item['imageURL'] = $imageURL;
            $item['image'] = $this->params . $imageURL;
            $item['baseURL'] = $this->params;

            return $item;

        }
//        else {
//            $item = [];
//            $item['imageURL'] = $imageURL;
//            $item['image'] = $this->params . $imageURL;
//            $item['baseURL'] = $this->params;
//
//            return $item;
//        }
        return $imageURL;
    }
}
