<?php

namespace App\Entity;

use App\Repository\CompanyInfoEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: CompanyInfoEntityRepository::class)]
class CompanyInfoEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 50, nullable: true)]
    private $phone;

    #[ORM\Column(type: 'string', length: 50, nullable: true)]
    private $phoneTwo;

    #[ORM\Column(type: 'string', length: 50, nullable: true)]
    private $whatsapp;

    #[ORM\Column(type: 'string', length: 50, nullable: true)]
    private $fax;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $email;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $bankName;

    #[ORM\Column(type: 'string', length: 50, nullable: true)]
    private $stc;

    #[ORM\Column(type: 'float', nullable: true)]
    private $kilometers;

    #[ORM\Column(type: 'float', nullable: true)]
    private $maxKilometerBonus;

    #[ORM\Column(type: 'float', nullable: true)]
    private $minKilometerBonus;

    #[ORM\Column(type: 'float', nullable: true)]
    private $supplierProfitMargin;

    #[ORM\Column(type: 'float', nullable: true)]
    private $storeProfitMargin;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getPhone(): ?string
    {
        return $this->phone;
    }

    public function setPhone(?string $phone): self
    {
        $this->phone = $phone;

        return $this;
    }

    public function getPhoneTwo(): ?string
    {
        return $this->phoneTwo;
    }

    public function setPhoneTwo(?string $phoneTwo): self
    {
        $this->phoneTwo = $phoneTwo;

        return $this;
    }

    public function getWhatsapp(): ?string
    {
        return $this->whatsapp;
    }

    public function setWhatsapp(?string $whatsapp): self
    {
        $this->whatsapp = $whatsapp;

        return $this;
    }

    public function getFax(): ?string
    {
        return $this->fax;
    }

    public function setFax(?string $fax): self
    {
        $this->fax = $fax;

        return $this;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(?string $email): self
    {
        $this->email = $email;

        return $this;
    }

    public function getBankName(): ?string
    {
        return $this->bankName;
    }

    public function setBankName(?string $bankName): self
    {
        $this->bankName = $bankName;

        return $this;
    }

    public function getStc(): ?string
    {
        return $this->stc;
    }

    public function setStc(?string $stc): self
    {
        $this->stc = $stc;

        return $this;
    }

    public function getKilometers(): ?float
    {
        return $this->kilometers;
    }

    public function setKilometers(?float $kilometers): self
    {
        $this->kilometers = $kilometers;

        return $this;
    }

    public function getMaxKilometerBonus(): ?float
    {
        return $this->maxKilometerBonus;
    }

    public function setMaxKilometerBonus(?float $maxKilometerBonus): self
    {
        $this->maxKilometerBonus = $maxKilometerBonus;

        return $this;
    }

    public function getMinKilometerBonus(): ?float
    {
        return $this->minKilometerBonus;
    }

    public function setMinKilometerBonus(?float $minKilometerBonus): self
    {
        $this->minKilometerBonus = $minKilometerBonus;

        return $this;
    }

    public function getSupplierProfitMargin(): ?float
    {
        return $this->supplierProfitMargin;
    }

    public function setSupplierProfitMargin(?float $supplierProfitMargin): self
    {
        $this->supplierProfitMargin = $supplierProfitMargin;

        return $this;
    }

    public function getStoreProfitMargin(): ?float
    {
        return $this->storeProfitMargin;
    }

    public function setStoreProfitMargin(?float $storeProfitMargin): self
    {
        $this->storeProfitMargin = $storeProfitMargin;

        return $this;
    }
}
