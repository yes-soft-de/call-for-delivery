<?php

namespace App\Entity;

use App\Repository\SubscriptionEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: SubscriptionEntityRepository::class)]
class SubscriptionEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $startDate;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $endDate;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $status;

    #[ORM\Column(type: 'text', nullable: true)]
    private $note;

    #[ORM\Column(type: 'boolean', nullable: true)]
    private $isFuture;

    #[ORM\ManyToOne(targetEntity: PackageEntity::class, inversedBy: 'subscriptionEntities')]
    private $package;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'subscriptionEntities')]
    private $storeOwner;

    #[ORM\OneToOne(inversedBy: 'subscriptionEntity', targetEntity: SubscriptionCaptainOfferEntity::class, cascade: ['persist', 'remove'])]
    private $subscriptionCaptainOffer;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getStartDate(): ?\DateTimeInterface
    {
        return $this->startDate;
    }

    public function setStartDate(?\DateTimeInterface $startDate): self
    {
        $this->startDate = $startDate;

        return $this;
    }

    public function getEndDate(): ?\DateTimeInterface
    {
        return $this->endDate;
    }

    public function setEndDate(?\DateTimeInterface $endDate): self
    {
        $this->endDate = $endDate;

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

    public function getNote(): ?string
    {
        return $this->note;
    }

    public function setNote(?string $note): self
    {
        $this->note = $note;

        return $this;
    }

    public function getIsFuture(): ?bool
    {
        return $this->isFuture;
    }

    public function setIsFuture(?bool $isFuture): self
    {
        $this->isFuture = $isFuture;

        return $this;
    }

    public function getPackage(): ?PackageEntity
    {
        return $this->package;
    }

    public function setPackage(?PackageEntity $package): self
    {
        $this->package = $package;

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

    public function getSubscriptionCaptainOffer(): ?SubscriptionCaptainOfferEntity
    {
        return $this->subscriptionCaptainOffer;
    }

    public function setSubscriptionCaptainOffer(?SubscriptionCaptainOfferEntity $subscriptionCaptainOffer): self
    {
        $this->subscriptionCaptainOffer = $subscriptionCaptainOffer;

        return $this;
    }
}
