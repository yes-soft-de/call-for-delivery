<?php

namespace App\Entity;

use App\Repository\StoreOwnerPaymentEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: StoreOwnerPaymentEntityRepository::class)]
class StoreOwnerPaymentEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'float')]
    private $amount;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $date;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'storeOwnerPaymentEntity')]
    #[ORM\JoinColumn(nullable: false)]
    private $store;

    #[ORM\Column(type: 'text', nullable: true)]
    private $note;

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

    public function getDate(): ?\DateTimeInterface
    {
        return $this->date;
    }

    public function setDate(\DateTimeInterface $date): self
    {
        $this->date = $date;

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
}
