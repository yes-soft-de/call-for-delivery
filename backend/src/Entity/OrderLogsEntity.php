<?php

namespace App\Entity;

use App\Repository\OrderLogsEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: OrderLogsEntityRepository::class)]
class OrderLogsEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\ManyToOne(targetEntity: OrderEntity::class, inversedBy: 'OrderLogsEntity')]
    #[ORM\JoinColumn(nullable: false)]
    private $orderId;

    #[ORM\ManyToOne(targetEntity: CaptainEntity::class, inversedBy: 'OrderLogsEntity')]
    private $captainProfile;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'OrderLogsEntity')]
    private $storeOwnerProfile;

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
}
