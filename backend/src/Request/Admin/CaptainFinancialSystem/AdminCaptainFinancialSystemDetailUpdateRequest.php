<?php

namespace App\Request\Admin\CaptainFinancialSystem;


class AdminCaptainFinancialSystemDetailUpdateRequest
{    
    private int $id;

    private bool $status;
    

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
}
