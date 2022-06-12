<?php


namespace App\Request\Notification;

use App\Constant\Notification\NotificationTokenConstant;

class NotificationTokensCreateRequest
{
    private int $userId;

    private string $token;

    private string $appType;

    private string $sound = NotificationTokenConstant::SOUND;

    /**
     * @return mixed
     */
    public function getUserId()
    {
        return $this->userId;
    }

    /**
     * @param mixed $userID
     */
    public function setUserId(int $userId): void
    {
        $this->userId = $userId;
    }

    /**
     * @return mixed
     */
    public function getToken()
    {
        return $this->token;
    }

    /**
     * @param mixed $token
     */
    public function setToken(string $token): void
    {
        $this->token = $token;
    }

    /**
     * Get the value of appType
     */ 
    public function getAppType()
    {
        return $this->appType;
    }

    /**
     * Set the value of appType
     *
     * @return  self
     */ 
    public function setAppType($appType)
    {
        $this->appType = $appType;

        return $this;
    }

    /**
     * Get the value of sound
     */ 
    public function getSound()
    {
        return $this->sound;
    }

    /**
     * Set the value of sound
     *
     * @return  self
     */ 
    public function setSound($sound)
    {
        $this->sound = $sound;

        return $this;
    }
}
