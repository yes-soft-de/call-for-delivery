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

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $branchPhone;

    #[ORM\OneToMany(mappedBy: 'storeOwnerBranch', targetEntity: OrderTimeLineEntity::class)]
    private $orderLogsEntity;

    #[ORM\OneToMany(mappedBy: 'branch', targetEntity: BidDetailsEntity::class)]
    private $bidDetailsEntities;

    #[ORM\OneToMany(mappedBy: 'storeOwnerBranch', targetEntity: OrderLogEntity::class)]
    private $orderLogEntities;

    public function __construct()
    {
        $this->storeOrderDetailsEntities = new ArrayCollection();
        $this->orderLogsEntity = new ArrayCollection();
        $this->bidDetailsEntities = new ArrayCollection();
        $this->orderLogEntities = new ArrayCollection();
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

    public function getBranchPhone(): ?string
    {
        return $this->branchPhone;
    }

    public function setBranchPhone(?string $branchPhone): self
    {
        $this->branchPhone = $branchPhone;

        return $this;
    }

    /**
     * @return Collection|OrderTimeLineEntity[]
     */
    public function getOrderLogsEntity(): Collection
    {
        return $this->orderLogsEntity;
    }

    public function addOrderLogsEntity(OrderTimeLineEntity $orderLogsEntity): self
    {
        if (!$this->orderLogsEntity->contains($orderLogsEntity)) {
            $this->orderLogsEntity[] = $orderLogsEntity;
            $orderLogsEntity->setStoreOwnerBranch($this);
        }

        return $this;
    }

    public function removeOrderLogsEntity(OrderTimeLineEntity $orderLogsEntity): self
    {
        if ($this->orderLogsEntity->removeElement($orderLogsEntity)) {
            // set the owning side to null (unless already changed)
            if ($orderLogsEntity->getStoreOwnerBranch() === $this) {
                $orderLogsEntity->setStoreOwnerBranch(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection|BidDetailsEntity[]
     */
    public function getBidDetailsEntities(): Collection
    {
        return $this->bidDetailsEntities;
    }

    public function addBidDetailsEntity(BidDetailsEntity $bidDetailsEntity): self
    {
        if (!$this->bidDetailsEntities->contains($bidDetailsEntity)) {
            $this->bidDetailsEntities[] = $bidDetailsEntity;
            $bidDetailsEntity->setBranch($this);
        }

        return $this;
    }

    public function removeBidDetailsEntity(BidDetailsEntity $bidDetailsEntity): self
    {
        if ($this->bidDetailsEntities->removeElement($bidDetailsEntity)) {
            // set the owning side to null (unless already changed)
            if ($bidDetailsEntity->getBranch() === $this) {
                $bidDetailsEntity->setBranch(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, OrderLogEntity>
     */
    public function getOrderLogEntities(): Collection
    {
        return $this->orderLogEntities;
    }

    public function addOrderLogEntity(OrderLogEntity $orderLogEntity): self
    {
        if (!$this->orderLogEntities->contains($orderLogEntity)) {
            $this->orderLogEntities[] = $orderLogEntity;
            $orderLogEntity->setStoreOwnerBranch($this);
        }

        return $this;
    }

    public function removeOrderLogEntity(OrderLogEntity $orderLogEntity): self
    {
        if ($this->orderLogEntities->removeElement($orderLogEntity)) {
            // set the owning side to null (unless already changed)
            if ($orderLogEntity->getStoreOwnerBranch() === $this) {
                $orderLogEntity->setStoreOwnerBranch(null);
            }
        }

        return $this;
    }
}
