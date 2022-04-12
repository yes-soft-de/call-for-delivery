<?php

namespace App\Request\Admin\CaptainFinancialSystem;


class AdminCaptainFinancialSystemAccordingToCountOfOrdersUpdateRequest
{    
    private int $id;

    private int $countOrdersInMonth;

    private float $salary;

    private float $monthCompensation;

    private float $bounceMaxCountOrdersInMonth;
    
    private float $bounceMinCountOrdersInMonth;

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
}