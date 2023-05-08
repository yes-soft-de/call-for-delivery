<?php

namespace App\Entity;

use App\Repository\StoreOwnerPaymentFromCompanyEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: StoreOwnerPaymentFromCompanyEntityRepository::class)]
class StoreOwnerPaymentFromCompanyEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'float')]
    private $amount;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'storeOwnerPaymentFromCompanyEntity')]
    #[ORM\JoinColumn(nullable: false)]
    private $store;

    #[ORM\Column(type: 'text', nullable: true)]
    private $note;

    #[ORM\Column(type: 'array', nullable: true)]
    private $storeDueFromCashOrder = [];

    public function __construct()
    {
    }

    public function getId(): ?int
    {
        return $this->id;
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

    public function getStore(): ?StoreOwnerProfileEntity
    {
        return $this->store;
    }

    public function setStore(?StoreOwnerProfileEntity $store): self
    {
        $this->store = $store;

        return $this;
    }

    public function getNote(): ?string
    {
        return $this->note;
    }

    public function setNote(?string $note): self
    {
        $this->note = $note;

        return $this;
    }

    public function getStoreDueFromCashOrder(): ?array
    {
        return $this->storeDueFromCashOrder;
    }

    public function setStoreDueFromCashOrder(?array $storeDueFromCashOrder): self
    {
        $this->storeDueFromCashOrder = $storeDueFromCashOrder;

        return $this;
    }
}
