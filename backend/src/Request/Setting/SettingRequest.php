<?php

namespace App\Request\Setting;

class SettingRequest
{
    private $uploadSubFolder;

    /**
     * @return mixed
     */
    public function getUploadSubFolder()
    {
        return $this->uploadSubFolder;
    }

    /**
     * @param mixed $uploadSubFolder
     */
    public function setUploadSubFolder($uploadSubFolder): void
    {
        $this->uploadSubFolder = $uploadSubFolder;
    }
}
