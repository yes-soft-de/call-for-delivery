<?php

namespace App\Entity;

use App\Repository\SubscriptionDetailsEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: SubscriptionDetailsEntityRepository::class)]
class SubscriptionDetailsEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'integer')]
    private $remainingOrders;

    #[ORM\Column(type: 'integer', length: 255)]
    private $remainingCars;

    #[ORM\Column(type: 'integer', length: 100)]
    private $remainingTime;

    #[ORM\Column(type: 'string', length: 100, nullable: true)]
    private $status;

    #[ORM\OneToOne(targetEntity: StoreOwnerProfileEntity::class, cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private $storeOwner;

    #[ORM\OneToOne(targetEntity: SubscriptionEntity::class, cascade: ['persist', 'remove'])]
    private $lastSubscription;

    #[ORM\Column(type: 'boolean', nullable: true)]
    private $hasExtra;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getRemainingOrders(): ?int
    {
        return $this->remainingOrders;
    }

    public function setRemainingOrders(int $remainingOrders): self
    {
        $this->remainingOrders = $remainingOrders;

        return $this;
    }

    public function getRemainingCars(): ?int
    {
        return $this->remainingCars;
    }

    public function setRemainingCars(int $remainingCars): self
    {
        $this->remainingCars = $remainingCars;

        return $this;
    }

    public function getRemainingTime(): ?int
    {
        return $this->remainingTime;
    }

    public function setRemainingTime(int $remainingTime): self
    {
        $this->remainingTime = $remainingTime;

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

    public function getStoreOwner(): ?StoreOwnerProfileEntity
    {
        return $this->storeOwner;
    }

    public function setStoreOwner(?StoreOwnerProfileEntity $storeOwner): self
    {
        $this->storeOwner = $storeOwner;

        return $this;
    }

    public function getLastSubscription(): ?SubscriptionEntity
    {
        return $this->lastSubscription;
    }

    public function setLastSubscription(?SubscriptionEntity $lastSubscription): self
    {
        $this->lastSubscription = $lastSubscription;

        return $this;
    }

    public function getHasExtra(): ?bool
    {
        return $this->hasExtra;
    }

    public function setHasExtra(?bool $hasExtra): self
    {
        $this->hasExtra = $hasExtra;

        return $this;
    }
}
