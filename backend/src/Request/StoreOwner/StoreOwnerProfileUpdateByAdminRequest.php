<?php

namespace App\Request\StoreOwner;

class StoreOwnerProfileUpdateByAdminRequest
{
    private $id;

    private $storeOwnerName;

    private $images;

    private $phone;

    private $storeCategoryId;

    private $openingTime;

    private $closingTime;

    private $commission;

    private $bankName;

    private $bankAccountNumber;

    private $stcPay;

    private $employeeCount;

    /**
     * @var float|null
     */
    private $profitMargin;

    /**
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @return null|string
     */
    public function getOpeningTime(): ?string
    {
        return $this->openingTime;
    }

    /**
     * @return null|string
     */
    public function getClosingTime(): ?string
    {
        return $this->closingTime;
    }
}
