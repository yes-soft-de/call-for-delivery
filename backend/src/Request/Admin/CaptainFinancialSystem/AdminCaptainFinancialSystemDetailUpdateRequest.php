<?php

namespace App\Request\Admin\CaptainFinancialSystem;


class AdminCaptainFinancialSystemDetailUpdateRequest
{    
    private int $id;

    private bool $status;

    private int $updatedBy;

    private int $captainFinancialSystemId;

    private int $captainFinancialSystemType;
    

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set the value of id
     *
     * @return  self
     */ 
    public function setId(int $id)
    {
        $this->id = $id;

        return $this;
    }

    /**
     * Get the value of updatedBy
     */ 
    public function getUpdatedBy()
    {
        return $this->updatedBy;
    }

    /**
     * Set the value of updatedBy
     *
     * @return  self
     */ 
    public function setUpdatedBy(int $updatedBy)
    {
        $this->updatedBy = $updatedBy;

        return $this;
    }
}
