<?php

namespace App\Request\Admin\Order;

class OrderStoreBranchToClientDistanceByAdminRequest
{   
    private int $id;

    private float $storeBranchToClientDistance;


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
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }

    /**
     * Get the value of storeBranchToClientDistance
     */ 
    public function getStoreBranchToClientDistance()
    {
        return $this->storeBranchToClientDistance;
    }

    /**
     * Set the value of storeBranchToClientDistance
     *
     * @return  self
     */ 
    public function setStoreBranchToClientDistance($storeBranchToClientDistance)
    {
        $this->storeBranchToClientDistance = $storeBranchToClientDistance;

        return $this;
    }
}
