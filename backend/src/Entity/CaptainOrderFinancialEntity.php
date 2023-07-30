<?php

namespace App\Entity;

use App\Repository\CaptainOrderFinancialEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: CaptainOrderFinancialEntityRepository::class)]
class CaptainOrderFinancialEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\OneToOne(inversedBy: 'captainOrderFinancialEntity', targetEntity: OrderEntity::class, cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private $orderId;

    #[ORM\ManyToOne(targetEntity: CaptainEntity::class, inversedBy: 'captainOrderFinancialEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $captain;

    #[ORM\Column(type: 'float')]
    private $amount;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\Column(type: 'float', nullable: true)]
    private $cashAmount;

    public function getId(): ?int
    {
        return $this->id;
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

    public function getCaptain(): ?CaptainEntity
    {
        return $this->captain;
    }

    public function setCaptain(?CaptainEntity $captain): self
    {
        $this->captain = $captain;

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

    public function getCreatedAt(): ?\DateTimeInterface
    {
        return $this->createdAt;
    }

    public function setCreatedAt(\DateTimeInterface $createdAt): self
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    public function getCashAmount(): ?float
    {
        return $this->cashAmount;
    }

    public function setCashAmount(?float $cashAmount): self
    {
        $this->cashAmount = $cashAmount;

        return $this;
    }
}
