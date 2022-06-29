<?php

namespace App\Entity;

use App\Repository\OrderTimeLineEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: OrderTimeLineEntityRepository::class)]
class OrderTimeLineEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\ManyToOne(targetEntity: OrderEntity::class, inversedBy: 'OrderTimeLineEntity')]
    #[ORM\JoinColumn(nullable: false)]
    private $orderId;

    #[ORM\ManyToOne(targetEntity: CaptainEntity::class, inversedBy: 'OrderTimeLineEntity')]
    #[ORM\JoinColumn(nullable: true)]
    private $captainProfile;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'OrderTimeLineEntity')]
    #[ORM\JoinColumn(nullable: true)]
    private $storeOwnerProfile;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\Column(type: 'string', length: 255)]
    private $orderState;

    #[ORM\Column(type: 'boolean', nullable: true)]
    private $isCaptainArrived;

    #[ORM\ManyToOne(targetEntity: StoreOwnerBranchEntity::class, inversedBy: 'OrderTimeLineEntity')]
    private $storeOwnerBranch;

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

    public function getCaptainProfile(): ?CaptainEntity
    {
        return $this->captainProfile;
    }

    public function setCaptainProfile(?CaptainEntity $captainProfile): self
    {
        $this->captainProfile = $captainProfile;

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

    public function getCreatedAt(): ?\DateTimeInterface
    {
        return $this->createdAt;
    }

    public function setCreatedAt(\DateTimeInterface $createdAt): self
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    public function getOrderState(): ?string
    {
        return $this->orderState;
    }

    public function setOrderState(string $orderState): self
    {
        $this->orderState = $orderState;

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

    public function getIsCaptainArrived(): ?bool
    {
        return $this->isCaptainArrived;
    }

    public function setIsCaptainArrived(?bool $isCaptainArrived): self
    {
        $this->isCaptainArrived = $isCaptainArrived;
        return $this;
    }
}
