<?php

namespace App\Entity;

use App\Repository\EPaymentFromStoreEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: EPaymentFromStoreEntityRepository::class)]
class EPaymentFromStoreEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'ePaymentFromStoreEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $storeOwnerProfile;

    #[ORM\Column(type: 'text')]
    private $paymentId;

    #[ORM\Column(type: 'smallint')]
    private $paymentGetaway;

    #[ORM\Column(type: 'float')]
    private $amount;

    #[ORM\Column(type: 'smallint')]
    private $paymentFor;

    #[ORM\ManyToOne(targetEntity: SubscriptionEntity::class, inversedBy: 'ePaymentFromStoreEntities')]
    private $subscription;

    #[ORM\Column(type: 'text', nullable: true)]
    private $details;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    // indicates who did the payment, and it is real or mock payment
    #[ORM\Column(type: 'smallint', nullable: true)]
    private $paymentType;

    #[ORM\Column(type: 'integer', options: ["default" => 0])]
    private $createdBy;

    public function getId(): ?int
    {
        return $this->id;
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

    public function getAmount(): ?float
    {
        return $this->amount;
    }

    public function setAmount(float $amount): self
    {
        $this->amount = $amount;

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

    public function getSubscription(): ?SubscriptionEntity
    {
        return $this->subscription;
    }

    public function setSubscription(?SubscriptionEntity $subscription): self
    {
        $this->subscription = $subscription;

        return $this;
    }

    public function getDetails(): ?string
    {
        return $this->details;
    }

    public function setDetails(?string $details): self
    {
        $this->details = $details;

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

    public function getUpdatedAt(): ?\DateTimeInterface
    {
        return $this->updatedAt;
    }

    public function setUpdatedAt(\DateTimeInterface $updatedAt): self
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    public function getPaymentType(): ?int
    {
        return $this->paymentType;
    }

    public function setPaymentType(int $paymentType): self
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
