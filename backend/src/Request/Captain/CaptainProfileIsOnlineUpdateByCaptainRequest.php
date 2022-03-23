<?php

namespace App\Request\Captain;

class CaptainProfileIsOnlineUpdateByCaptainRequest
{
    private int $captainId;

    private bool $isOnline;


    /**
     * Get the value of captainId
     */ 
    public function getCaptainId()
    {
        return $this->captainId;
    }

    /**
     * Set the value of captainId
     *
     * @return  self
     */ 
    public function setCaptainId($captainId)
    {
        $this->captainId = $captainId;

        return $this;
    }
}
