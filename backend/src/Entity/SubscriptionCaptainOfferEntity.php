<?php

namespace App\Entity;

use App\Repository\SubscriptionCaptainOfferEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

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
   
    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime', nullable: true)]
    private $startDate;
   
    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime', nullable: true)]
    private $updatedAt;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'subscriptionCaptainOffer')]
    private $storeOwner;

    #[ORM\ManyToOne(targetEntity: CaptainOfferEntity::class, inversedBy: 'subscriptionCaptainOffer')]
    private $captainOffer;

    #[ORM\OneToMany(mappedBy: 'subscriptionCaptainOffer', targetEntity: SubscriptionEntity::class)]
    private $subscriptionEntitie;

    public function __construct()
    {
        $this->subscriptionEntitie = new ArrayCollection();
    }

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

    public function getStoreOwner(): ?StoreOwnerProfileEntity
    {
        return $this->storeOwner;
    }

    public function setStoreOwner(?StoreOwnerProfileEntity $storeOwner): self
    {
        $this->storeOwner = $storeOwner;

        return $this;
    }

    public function getCaptainOffer(): ?CaptainOfferEntity
    {
        return $this->captainOffer;
    }

    public function setCaptainOffer(?CaptainOfferEntity $captainOffer): self
    {
        $this->captainOffer = $captainOffer;

        return $this;
    }

    /**
     * @return Collection|SubscriptionEntity[]
     */
    public function getSubscriptionEntitie(): Collection
    {
        return $this->subscriptionEntitie;
    }

    public function addSubscriptionEntitie(SubscriptionEntity $subscriptionEntitie): self
    {
        if (!$this->subscriptionEntitie->contains($subscriptionEntitie)) {
            $this->subscriptionEntitie[] = $subscriptionEntitie;
            $subscriptionEntitie->setSubscriptionCaptainOffer($this);
        }

        return $this;
    }

    public function removeSubscriptionEntitie(SubscriptionEntity $subscriptionEntitie): self
    {
        if ($this->subscriptionEntitie->removeElement($subscriptionEntitie)) {
            // set the owning side to null (unless already changed)
            if ($subscriptionEntitie->getSubscriptionCaptainOffer() === $this) {
                $subscriptionEntitie->setSubscriptionCaptainOffer(null);
            }
        }

        return $this;
    }
}
