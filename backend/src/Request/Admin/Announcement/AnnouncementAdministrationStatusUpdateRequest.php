<?php

namespace App\Request\Admin\Announcement;

class AnnouncementAdministrationStatusUpdateRequest
{
    private int $id;

    private bool $administrationStatus;

    public function getId(): int
    {
        return $this->id;
    }
}
