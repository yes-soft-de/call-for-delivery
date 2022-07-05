<?php

namespace App\Entity;

use App\Repository\OrderLogEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: OrderLogEntityRepository::class)]
class OrderLogEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\ManyToOne(targetEntity: OrderEntity::class, inversedBy: 'orderLogEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $orderId;

    #[ORM\Column(type: 'integer')]
    private $type;

    #[ORM\Column(type: 'integer')]
    private $action;

    #[ORM\Column(type: 'string', length: 100)]
    private $state;

    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\Column(type: 'integer')]
    private $createdBy;

    #[ORM\Column(type: 'integer')]
    private $createdByUserType;

    #[ORM\Column(type: 'boolean')]
    private $isCaptainArrivedConfirmation;

    #[ORM\ManyToOne(targetEntity: StoreOwnerBranchEntity::class, inversedBy: 'orderLogEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $storeOwnerBranch;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'orderLogEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $storeOwnerProfile;

    #[ORM\ManyToOne(targetEntity: CaptainEntity::class, inversedBy: 'orderLogEntities')]
    private $captainProfile;

    #[ORM\ManyToOne(targetEntity: SupplierProfileEntity::class, inversedBy: 'orderLogEntities')]
    private $supplierProfile;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getOrderId(): ?OrderEntity
    {
        return $this->orderId;
    }

    public function setOrderId(?OrderEntity $orderId): self
    {
        $this->orderId = $orderId;

        return $this;
    }

    public function getType(): ?int
    {
        return $this->type;
    }

    public function setType(int $type): self
    {
        $this->type = $type;

        return $this;
    }

    public function getAction(): ?int
    {
        return $this->action;
    }

    public function setAction(int $action): self
    {
        $this->action = $action;

        return $this;
    }

    public function getState(): ?string
    {
        return $this->state;
    }

    public function setState(string $state): self
    {
        $this->state = $state;

        return $this;
    }

    public function getCreatedAt(): ?\DateTimeInterface
    {
        return $this->createdAt;
    }

    public function setCreatedAt(\DateTimeInterface $createdAt): self
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    public function getCreatedBy(): ?int
    {
        return $this->createdBy;
    }

    public function setCreatedBy(int $createdBy): self
    {
        $this->createdBy = $createdBy;

        return $this;
    }

    public function getCreatedByUserType(): ?int
    {
        return $this->createdByUserType;
    }

    public function setCreatedByUserType(int $createdByUserType): self
    {
        $this->createdByUserType = $createdByUserType;

        return $this;
    }

    public function getIsCaptainArrivedConfirmation(): ?bool
    {
        return $this->isCaptainArrivedConfirmation;
    }

    public function setIsCaptainArrivedConfirmation(bool $isCaptainArrivedConfirmation): self
    {
        $this->isCaptainArrivedConfirmation = $isCaptainArrivedConfirmation;

        return $this;
    }

    public function getStoreOwnerBranch(): ?StoreOwnerBranchEntity
    {
        return $this->storeOwnerBranch;
    }

    public function setStoreOwnerBranch(?StoreOwnerBranchEntity $storeOwnerBranch): self
    {
        $this->storeOwnerBranch = $storeOwnerBranch;

        return $this;
    }

    public function getStoreOwnerProfile(): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfile;
    }

    public function setStoreOwnerProfile(?StoreOwnerProfileEntity $storeOwnerProfile): self
    {
        $this->storeOwnerProfile = $storeOwnerProfile;

        return $this;
    }

    public function getCaptainProfile(): ?CaptainEntity
    {
        return $this->captainProfile;
    }

    public function setCaptainProfile(?CaptainEntity $captainProfile): self
    {
        $this->captainProfile = $captainProfile;

        return $this;
    }

    public function getSupplierProfile(): ?SupplierProfileEntity
    {
        return $this->supplierProfile;
    }

    public function setSupplierProfile(?SupplierProfileEntity $supplierProfile): self
    {
        $this->supplierProfile = $supplierProfile;

        return $this;
    }
}
