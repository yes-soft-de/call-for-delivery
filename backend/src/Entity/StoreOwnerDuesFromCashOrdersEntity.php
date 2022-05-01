<?php

namespace App\Entity;

use App\Repository\StoreOwnerDuesFromCashOrdersEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: StoreOwnerDuesFromCashOrdersEntityRepository::class)]
class StoreOwnerDuesFromCashOrdersEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'storeOwnerDuesFromCashOrders')]
    #[ORM\JoinColumn(nullable: false)]
    private $store;

    #[ORM\OneToOne(targetEntity: OrderEntity::class, cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private $orderId;

    #[ORM\Column(type: 'integer')]
    private $flag;

    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\Column(type: 'float')]
    private $amount;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getStore(): ?StoreOwnerProfileEntity
    {
        return $this->store;
    }

    public function setStore(?StoreOwnerProfileEntity $store): self
    {
        $this->store = $store;

        return $this;
    }

    public function getOrderId(): ?OrderEntity
    {
        return $this->orderId;
    }

    public function setOrderId(OrderEntity $orderId): self
    {
        $this->orderId = $orderId;

        return $this;
    }

    public function getFlag(): ?int
    {
        return $this->flag;
    }

    public function setFlag(int $flag): self
    {
        $this->flag = $flag;

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

    public function getAmount(): ?float
    {
        return $this->amount;
    }

    public function setAmount(float $amount): self
    {
        $this->amount = $amount;

        return $this;
    }
}
