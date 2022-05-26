<?php

namespace App\Request\Admin\CaptainFinancialSystem;

class AdminCaptainFinancialSystemAccordingOnOrderUpdateRequest
{
    private int $id;

    private string $categoryName;
    
    private float $countKilometersFrom;

    private float $countKilometersTo;

    private float $amount;

    private float|null $bounce;
    
    private float|null $bounceCountOrdersInMonth;

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