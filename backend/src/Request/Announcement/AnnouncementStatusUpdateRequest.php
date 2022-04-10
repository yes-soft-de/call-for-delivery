<?php

namespace App\Request\Announcement;

class AnnouncementStatusUpdateRequest
{
    private int $id;

    private bool $status;

    public function getId(): int
    {
        return $this->id;
    }
}
