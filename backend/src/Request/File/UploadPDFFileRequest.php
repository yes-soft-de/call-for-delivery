<?php

namespace App\Request\File;

class UploadPDFFileRequest
{
    private string $uploadedFile;

    public function getUploadedFile(): string
    {
        return $this->uploadedFile;
    }

    public function setUploadedFile(string $uploadedFile): void
    {
        $this->uploadedFile = $uploadedFile;
    }
}
