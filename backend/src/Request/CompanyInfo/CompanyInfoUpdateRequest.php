<?php

namespace App\Request\CompanyInfo;

class CompanyInfoUpdateRequest
{
    private int $id;

    private string $phone;

    private string $phoneTwo;

    private string $whatsapp;

    private string $fax;

    private string $email;

    private string $bankName;

    private string $stc;

    private float $kilometers;

    private float $maxKilometerBonus;

    private float $minKilometerBonus;

    /**
     * @return int
     */
    public function getId(): int
    {
        return $this->id;
    }
}
