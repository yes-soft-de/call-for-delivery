<?php

namespace App\Entity;

use App\Repository\StoreOwnerBranchEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: StoreOwnerBranchEntityRepository::class)]
class StoreOwnerBranchEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'json', nullable: true)]
    private $location = [];

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $city;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $name;

    #[ORM\Column(type: 'boolean', nullable: true)]
    private $isActive;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'storeOwnerBranchEntities')]
    private $storeOwner;

    #[ORM\OneToMany(mappedBy: 'branch', targetEntity: StoreOrderDetailsEntity::class)]
    private $storeOrderDetailsEntities;

    public function __construct()
    {
        $this->storeOrderDetailsEntities = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getLocation(): ?array
    {
        return $this->location;
    }

    public function setLocation(?array $location): self
    {
        $this->location = $location;

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

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(?string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getIsActive(): ?bool
    {
        return $this->isActive;
    }

    public function setIsActive(?bool $isActive): self
    {
        $this->isActive = $isActive;

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

    /**
     * @return Collection|StoreOrderDetailsEntity[]
     */
    public function getStoreOrderDetailsEntities(): Collection
    {
        return $this->storeOrderDetailsEntities;
    }

    public function addStoreOrderDetailsEntity(StoreOrderDetailsEntity $storeOrderDetailsEntity): self
    {
        if (!$this->storeOrderDetailsEntities->contains($storeOrderDetailsEntity)) {
            $this->storeOrderDetailsEntities[] = $storeOrderDetailsEntity;
            $storeOrderDetailsEntity->setBranch($this);
        }

        return $this;
    }

    public function removeStoreOrderDetailsEntity(StoreOrderDetailsEntity $storeOrderDetailsEntity): self
    {
        if ($this->storeOrderDetailsEntities->removeElement($storeOrderDetailsEntity)) {
            // set the owning side to null (unless already changed)
            if ($storeOrderDetailsEntity->getBranch() === $this) {
                $storeOrderDetailsEntity->setBranch(null);
            }
        }

        return $this;
    }
}
