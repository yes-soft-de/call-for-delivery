<?php

namespace App\Request\Image;

class UploadImageRequest
{
    private $uploadedFile;

    /**
     * @return mixed
     */
    public function getUploadedFile()
    {
        return $this->uploadedFile;
    }

    /**
     * @param mixed $uploadedFile
     */
    public function setUploadedFile($uploadedFile): void
    {
        $this->uploadedFile = $uploadedFile;
    }
}
