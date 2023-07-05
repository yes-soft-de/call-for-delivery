<?php

namespace App\Request\StoreOwner;

class StoreOwnerProfileUpdateRequest
{
    private $userId;

    private $storeOwnerName;

    private $images;

    private $phone;

    private $city;

    private $storeCategoryId;

    private $openingTime;

    private $closingTime;

    private $bankName;

    private $bankAccountNumber;

    private $stcPay;

    private $employeeCount;

    // branch info
    private $location = [];

//    private $isActive;
//
//    private string|null $branchPhone;

    /**
     * Get the value of userID
     */
    public function getUserId()
    {
        return $this->userId;
    }

    /**
     * Set the value of userID
     *
     * @return  self
     */
    public function setUserId($userId)
    {
        $this->userId = $userId;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getStoreOwnerName()
    {
        return $this->storeOwnerName;
    }

    /**
     * @param mixed $storeOwnerName
     */
    public function setStoreOwnerName($storeOwnerName): void
    {
        $this->storeOwnerName = $storeOwnerName;
    }

    /**
     * @return mixed
     */
    public function getImage()
    {
        return $this->image;
    }

    /**
     * @param mixed $image
     */
    public function setImage($image): void
    {
        $this->image = $image;
    }

    /**
     * Get the value of storeCategoryId
     */
    public function getStoreCategoryId()
    {
        return $this->storeCategoryId;
    }

    /**
     * Set the value of storeCategoryId
     *
     * @return  self
     */
    public function setStoreCategoryId($storeCategoryId)
    {
        $this->storeCategoryId = $storeCategoryId;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getPhone()
    {
        return $this->phone;
    }

    /**
     * @return mixed
     */
    public function getCity()
    {
        return $this->city;
    }
}
