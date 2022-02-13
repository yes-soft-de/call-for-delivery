<?php

namespace App\Entity;
use App\Repository\Profile\StoreOwnerProfileEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: StoreOwnerProfileEntityRepository::class)]
class StoreOwnerProfileEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $storeOwnerID;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $storeOwnerName;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $image;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $status;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $roomID;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $city;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $storeCategoryId;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $phone;

    #[ORM\Column(type: 'boolean', nullable: true)]
    private $is_best;

    #[ORM\Column(type: 'time', nullable: true)]
    private $openingTime;

    #[ORM\Column(type: 'time', nullable: true)]
    private $closingTime;

    #[ORM\Column(type: 'float', nullable: true)]
    private $commission;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $bankName;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $bankAccountNumber;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $stcPay;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $employeeCount;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getStoreOwnerID(): ?string
    {
        return $this->storeOwnerID;
    }

    public function setStoreOwnerID(?string $storeOwnerID): self
    {
        $this->storeOwnerID = $storeOwnerID;

        return $this;
    }

    public function getStoreOwnerName(): ?string
    {
        return $this->storeOwnerName;
    }

    public function setStoreOwnerName(?string $storeOwnerName): self
    {
        $this->storeOwnerName = $storeOwnerName;

        return $this;
    }

    public function getImage(): ?string
    {
        return $this->image;
    }

    public function setImage(?string $image): self
    {
        $this->image = $image;

        return $this;
    }

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(?string $status): self
    {
        $this->status = $status;

        return $this;
    }

    public function getRoomID(): ?string
    {
        return $this->roomID;
    }

    public function setRoomID(?string $roomID): self
    {
        $this->roomID = $roomID;

        return $this;
    }

    public function getCity(): ?string
    {
        return $this->city;
    }

    public function setCity(?string $city): self
    {
        $this->city = $city;

        return $this;
    }

    public function getStoreCategoryId(): ?int
    {
        return $this->storeCategoryId;
    }

    public function setStoreCategoryId(?int $storeCategoryId): self
    {
        $this->storeCategoryId = $storeCategoryId;

        return $this;
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

    public function getIsBest(): ?bool
    {
        return $this->is_best;
    }

    public function setIsBest(?bool $is_best): self
    {
        $this->is_best = $is_best;

        return $this;
    }

    public function getOpeningTime()
    {
        return $this->openingTime;
    }

    public function setOpeningTime($openingTime): self
    {
        $this->openingTime = new \DateTime ($openingTime);

        return $this;
    }

    public function getClosingTime()
    {
        return $this->closingTime;
    }

    public function setClosingTime($closingTime): self
    {
        $this->closingTime = new \DateTime ($closingTime);

        return $this;
    }

    public function getCommission(): ?float
    {
        return $this->commission;
    }

    public function setCommission(?float $commission): self
    {
        $this->commission = $commission;

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

    public function getBankAccountNumber(): ?string
    {
        return $this->bankAccountNumber;
    }

    public function setBankAccountNumber(?string $bankAccountNumber): self
    {
        $this->bankAccountNumber = $bankAccountNumber;

        return $this;
    }

    public function getStcPay(): ?string
    {
        return $this->stcPay;
    }

    public function setStcPay(?string $stcPay): self
    {
        $this->stcPay = $stcPay;

        return $this;
    }

    public function getEmployeeCount(): ?int
    {
        return $this->employeeCount;
    }

    public function setEmployeeCount(?int $employeeCount): self
    {
        $this->employeeCount = $employeeCount;

        return $this;
    }
}
