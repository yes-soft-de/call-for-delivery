<?php

namespace App\Entity;

use App\Repository\CaptainAmountFromOrderCashEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: CaptainAmountFromOrderCashEntityRepository::class)]
//The cash is with the captain from orders
class CaptainAmountFromOrderCashEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\ManyToOne(targetEntity: CaptainEntity::class, inversedBy: 'captainAmountFromOrderCash')]
    #[ORM\JoinColumn(nullable: false)]
    private $captain;

    #[ORM\OneToOne(targetEntity: OrderEntity::class, cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private $orderId;

    #[ORM\Column(type: 'float')]
    private $amount;

    #[ORM\Column(type: 'integer')]
    private $flag;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\ManyToOne(targetEntity: CaptainPaymentToCompanyEntity::class, inversedBy: 'captainAmountFromOrderCashEntities')]
    private $captainPaymentToCompany;
   
    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'date', nullable: true)]
    private $createdDate;

    #[ORM\Column(type: 'float', nullable: true)]
    private $storeAmount;

    #[ORM\Column(type: 'text', nullable: true)]
    private $captainNote;
    //When paying (storeAmount) from captain to the company, the captain is prevented from modifying the field (flag)
    //false means unmodifiable
    #[ORM\Column(type: 'boolean', nullable: true)]
    private $editingByCaptain;

    public function getId(): ?int
    {
        return $this->id;
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

    public function getOrderId(): ?OrderEntity
    {
        return $this->orderId;
    }

    public function setOrderId(OrderEntity $orderId): self
    {
        $this->orderId = $orderId;

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

    public function getCaptainPaymentToCompany(): ?CaptainPaymentToCompanyEntity
    {
        return $this->captainPaymentToCompany;
    }

    public function setCaptainPaymentToCompany(?CaptainPaymentToCompanyEntity $captainPaymentToCompany): self
    {
        $this->captainPaymentToCompany = $captainPaymentToCompany;

        return $this;
    }

    public function getCreatedDate(): ?\DateTimeInterface
    {
        return $this->createdDate;
    }

    public function setCreatedDate(\DateTimeInterface $createdDate): self
    {
        $this->createdDate = $createdDate;

        return $this;
    }

    public function getStoreAmount(): ?float
    {
        return $this->storeAmount;
    }

    public function setStoreAmount(?float $storeAmount): self
    {
        $this->storeAmount = $storeAmount;

        return $this;
    }

    public function getCaptainNote(): ?string
    {
        return $this->captainNote;
    }

    public function setCaptainNote(?string $captainNote): self
    {
        $this->captainNote = $captainNote;

        return $this;
    }

    public function getEditingByCaptain(): ?bool
    {
        return $this->editingByCaptain;
    }

    public function setEditingByCaptain(?bool $editingByCaptain): self
    {
        $this->editingByCaptain = $editingByCaptain;

        return $this;
    }
}
