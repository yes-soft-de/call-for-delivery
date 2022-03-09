<?php

namespace App\Request\Admin\Notification;

class AdminNotificationCreateRequest
{
    private string $title;
   
    private string $msg;

    private string $appType;

    /**
     * Get the value of title
     */ 
    public function getTitle(): string
    {
        return $this->title;
    }

    /**
     * Set the value of title
     *
     * @return  self
     */ 
    public function setTitle(string $title)
    {
        $this->title = $title;

        return $this;
    }

    /**
     * Get the value of appType
     */ 
    public function getAppType(): string
    {
        return $this->appType;
    }

    /**
     * Set the value of appType
     *
     * @return  self
     */ 
    public function setAppType(string $appType)
    {
        $this->appType = $appType;

        return $this;
    }

    /**
     * Get the value of msg
     */ 
    public function getMsg(): string
    {
        return $this->msg;
    }

    /**
     * Set the value of msg
     *
     * @return  self
     */ 
    public function setMsg(string $msg)
    {
        $this->msg = $msg;

        return $this;
    }
}
