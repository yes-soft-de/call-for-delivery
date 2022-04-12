<?php

namespace App\Request\Admin\CaptainFinancialSystem;

class AdminCaptainFinancialSystemAccordingToCountOfHoursUpdateRequest
{
    private int $id;

    private int $countHours;
    
    private float $compensationForEveryOrder;

    private float $salary;

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
