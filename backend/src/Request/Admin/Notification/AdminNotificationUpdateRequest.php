<?php

namespace App\Request\Admin\Notification;

class AdminNotificationUpdateRequest
{
    private int $id;
   
    private string $title;
   
    private string $msg;

    private string $appType;

    /**
     * @var array|null
     */
    private $images;

    /**
     * Get the value of id
     */ 
    public function getId(): int
    {
        return $this->id;
    }

    /**
     * Set the value of id
     *
     * @return  self
     */ 
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }

    public function getImages(): ?array
    {
        return $this->images;
    }
}
