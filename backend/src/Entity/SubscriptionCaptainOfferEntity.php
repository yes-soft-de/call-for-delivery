<?php

namespace App\Entity;

use App\Repository\SubscriptionCaptainOfferEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: SubscriptionCaptainOfferEntityRepository::class)]
class SubscriptionCaptainOfferEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'integer')]
    private $carCount;

    #[ORM\Column(type: 'string', length: 100)]
    private $status;

    #[ORM\Column(type: 'integer')]
    private $expired;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $startDate;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $updatedAt;

    #[ORM\OneToOne(mappedBy: 'subscriptionCaptainOffer', targetEntity: SubscriptionEntity::class, cascade: ['persist', 'remove'])]
    private $subscriptionEntity;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCarCount(): ?int
    {
        return $this->carCount;
    }

    public function setCarCount(int $carCount): self
    {
        $this->carCount = $carCount;

        return $this;
    }

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(string $status): self
    {
        $this->status = $status;

        return $this;
    }

    public function getExpired(): ?int
    {
        return $this->expired;
    }

    public function setExpired(int $expired): self
    {
        $this->expired = $expired;

        return $this;
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

    public function getUpdatedAt(): ?\DateTimeInterface
    {
        return $this->updatedAt;
    }

    public function setUpdatedAt(?\DateTimeInterface $updatedAt): self
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    public function getSubscriptionEntity(): ?SubscriptionEntity
    {
        return $this->subscriptionEntity;
    }

    public function setSubscriptionEntity(?SubscriptionEntity $subscriptionEntity): self
    {
        // unset the owning side of the relation if necessary
        if ($subscriptionEntity === null && $this->subscriptionEntity !== null) {
            $this->subscriptionEntity->setSubscriptionCaptainOffer(null);
        }

        // set the owning side of the relation if necessary
        if ($subscriptionEntity !== null && $subscriptionEntity->getSubscriptionCaptainOffer() !== $this) {
            $subscriptionEntity->setSubscriptionCaptainOffer($this);
        }

        $this->subscriptionEntity = $subscriptionEntity;

        return $this;
    }
}
