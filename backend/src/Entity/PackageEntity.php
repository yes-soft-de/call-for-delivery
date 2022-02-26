<?php

namespace App\Entity;

use App\Repository\PackageEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: PackageEntityRepository::class)]
class PackageEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 255)]
    private $name;

    #[ORM\Column(type: 'float')]
    private $cost;

    #[ORM\Column(type: 'integer')]
    private $carCount;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $city;

    #[ORM\Column(type: 'integer')]
    private $orderCount;

    #[ORM\Column(type: 'string', length: 255)]
    private $status;

    #[ORM\Column(type: 'text', nullable: true)]
    private $note;

    #[ORM\Column(type: 'integer', length: 100)]
    private $expired;

    #[ORM\OneToMany(mappedBy: 'package', targetEntity: SubscriptionEntity::class)]
    private $subscriptionEntities;

    public function __construct()
    {
        $this->subscriptionEntities = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getCost(): ?float
    {
        return $this->cost;
    }

    public function setCost(float $cost): self
    {
        $this->cost = $cost;

        return $this;
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

    public function getCity(): ?string
    {
        return $this->city;
    }

    public function setCity(?string $city): self
    {
        $this->city = $city;

        return $this;
    }

    public function getOrderCount(): ?int
    {
        return $this->orderCount;
    }

    public function setOrderCount(int $orderCount): self
    {
        $this->orderCount = $orderCount;

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

    public function getNote(): ?string
    {
        return $this->note;
    }

    public function setNote(?string $note): self
    {
        $this->note = $note;

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

    /**
     * @return Collection|SubscriptionEntity[]
     */
    public function getSubscriptionEntities(): Collection
    {
        return $this->subscriptionEntities;
    }

    public function addSubscriptionEntity(SubscriptionEntity $subscriptionEntity): self
    {
        if (!$this->subscriptionEntities->contains($subscriptionEntity)) {
            $this->subscriptionEntities[] = $subscriptionEntity;
            $subscriptionEntity->setPackage($this);
        }

        return $this;
    }

    public function removeSubscriptionEntity(SubscriptionEntity $subscriptionEntity): self
    {
        if ($this->subscriptionEntities->removeElement($subscriptionEntity)) {
            // set the owning side to null (unless already changed)
            if ($subscriptionEntity->getPackage() === $this) {
                $subscriptionEntity->setPackage(null);
            }
        }

        return $this;
    }
}
