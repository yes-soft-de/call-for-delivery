<?php

namespace App\Response\Admin\AppFeature;

use DateTime;

class AppFeatureForAdminGetResponse
{
    public int $id;

    public string $featureName;

    public bool $featureStatus;

    public DateTime $createdAt;

    public DateTime $updatedAt;
}
