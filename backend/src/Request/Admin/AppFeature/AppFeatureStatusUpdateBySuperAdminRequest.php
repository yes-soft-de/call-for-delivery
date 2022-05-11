<?php

namespace App\Request\Admin\AppFeature;

class AppFeatureStatusUpdateBySuperAdminRequest
{
    private int $id;

    private bool $featureStatus;

    public function getId(): int
    {
        return $this->id;
    }
}
