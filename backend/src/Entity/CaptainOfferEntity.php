<?php

namespace App\Entity;

use App\Repository\CaptainOfferEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: CaptainOfferEntityRepository::class)]
class CaptainOfferEntity
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

    #[ORM\Column(type: 'float')]
    private $price;

    #[ORM\OneToMany(mappedBy: 'captainOffer', targetEntity: SubscriptionCaptainOfferEntity::class)]
    private $subscriptionCaptainOffer;

    public function __construct()
    {
        $this->subscriptionCaptainOffer = new ArrayCollection();
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

    public function getPrice(): ?int
    {
        return $this->price;
    }

    public function setPrice(int $price): self
    {
        $this->price = $price;

        return $this;
    }

    /**
     * @return Collection|SubscriptionCaptainOfferEntity[]
     */
    public function getSubscriptionCaptainOffer(): Collection
    {
        return $this->subscriptionCaptainOffer;
    }

    public function addSubscriptionCaptainOffer(SubscriptionCaptainOfferEntity $subscriptionCaptainOffer): self
    {
        if (!$this->subscriptionCaptainOffer->contains($subscriptionCaptainOffer)) {
            $this->subscriptionCaptainOffer[] = $subscriptionCaptainOffer;
            $subscriptionCaptainOffer->setCaptainOffer($this);
        }

        return $this;
    }

    public function removeSubscriptionCaptainOffer(SubscriptionCaptainOfferEntity $subscriptionCaptainOffer): self
    {
        if ($this->subscriptionCaptainOffer->removeElement($subscriptionCaptainOffer)) {
            // set the owning side to null (unless already changed)
            if ($subscriptionCaptainOffer->getCaptainOffer() === $this) {
                $subscriptionCaptainOffer->setCaptainOffer(null);
            }
        }

        return $this;
    }
}
