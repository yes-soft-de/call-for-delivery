<?php


namespace App\Request\Notification;


class NotificationTokensCreateRequest
{
    private int $userId;

    private string $token;

    private string $appType;

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
}
