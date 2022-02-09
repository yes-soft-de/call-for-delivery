<?php

namespace App\Request\Main;

class CheckBackendHeathRequest
{
    private $userId;

    /**
     * @return mixed
     */
    public function getUserId()
    {
        return $this->userId;
    }
}
