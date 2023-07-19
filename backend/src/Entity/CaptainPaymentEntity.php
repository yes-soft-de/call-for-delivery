<?php

namespace App\Entity;

use App\Constant\CaptainPayment\PaymentToCaptain\CaptainPaymentConstant;
use App\Repository\CaptainPaymentEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

// Payments from Company to Captains
#[ORM\Entity(repositoryClass: CaptainPaymentEntityRepository::class)]
class CaptainPaymentEntity
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

    #[ORM\Column(type: 'text', nullable: true)]
    private $note;

    #[ORM\ManyToOne(targetEntity: CaptainEntity::class, inversedBy: 'captainPaymentEntity')]
    #[ORM\JoinColumn(nullable: false)]
    private $captain;

    #[ORM\ManyToOne(targetEntity: CaptainFinancialDuesEntity::class, inversedBy: 'captainPaymentEntities')]
    private $captainFinancialDues;

    #[ORM\ManyToOne(targetEntity: CaptainFinancialDailyEntity::class, inversedBy: 'captainPayment')]
    private $captainFinancialDailyEntity;

    #[ORM\Column(type: 'text')]
    private $paymentId;

    #[ORM\Column(type: 'smallint', options: ["default" => CaptainPaymentConstant::PAYMENT_GETAWAY_NOT_SPECIFIED_CONST])]
    private $paymentGetaway;

    #[ORM\Column(type: 'smallint', options: ["default" => CaptainPaymentConstant::PAYMENT_FOR_ORDER_DELIVERY_CONST])]
    private $paymentFor;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime', nullable: true)]
    private $updatedAt;

    #[ORM\Column(type: 'smallint', nullable: true)]
    private $paymentType;

    #[ORM\Column(type: 'integer', options: ["default" => 0])]
    private $createdBy;

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

    public function getNote(): ?string
    {
        return $this->note;
    }

    public function setNote(?string $note): self
    {
        $this->note = $note;

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

    public function getCaptainFinancialDues(): ?CaptainFinancialDuesEntity
    {
        return $this->captainFinancialDues;
    }

    public function setCaptainFinancialDues(?CaptainFinancialDuesEntity $captainFinancialDues): self
    {
        $this->captainFinancialDues = $captainFinancialDues;

        return $this;
    }

    public function getCaptainFinancialDailyEntity(): ?CaptainFinancialDailyEntity
    {
        return $this->captainFinancialDailyEntity;
    }

    public function setCaptainFinancialDailyEntity(?CaptainFinancialDailyEntity $captainFinancialDailyEntity): self
    {
        $this->captainFinancialDailyEntity = $captainFinancialDailyEntity;

        return $this;
    }

    public function getPaymentId(): ?string
    {
        return $this->paymentId;
    }

    public function setPaymentId(string $paymentId): self
    {
        $this->paymentId = $paymentId;

        return $this;
    }

    public function getPaymentGetaway(): ?int
    {
        return $this->paymentGetaway;
    }

    public function setPaymentGetaway(int $paymentGetaway): self
    {
        $this->paymentGetaway = $paymentGetaway;

        return $this;
    }

    public function getPaymentFor(): ?int
    {
        return $this->paymentFor;
    }

    public function setPaymentFor(int $paymentFor): self
    {
        $this->paymentFor = $paymentFor;

        return $this;
    }

    public function getUpdatedAt(): ?\DateTimeInterface
    {
        return $this->updatedAt;
    }

    public function setUpdatedAt(?\DateTimeInterface $updatedAt): self
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    public function getPaymentType(): ?int
    {
        return $this->paymentType;
    }

    public function setPaymentType(?int $paymentType): self
    {
        $this->paymentType = $paymentType;

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
}
