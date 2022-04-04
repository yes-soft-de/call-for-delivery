<?php

namespace App\Entity;
use App\Repository\StoreOwnerProfileEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: StoreOwnerProfileEntityRepository::class)]
class StoreOwnerProfileEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $storeOwnerId;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $storeOwnerName;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $images;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $status;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $roomID;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $city;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $storeCategoryId;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $phone;

    #[ORM\Column(type: 'time', nullable: true)]
    private $openingTime;

    #[ORM\Column(type: 'time', nullable: true)]
    private $closingTime;

    #[ORM\Column(type: 'float', nullable: true)]
    private $commission;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $bankName;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $bankAccountNumber;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $stcPay;

    #[ORM\Column(type: 'string', nullable: true)]
    private $employeeCount;

    #[ORM\OneToMany(mappedBy: 'storeOwner', targetEntity: SubscriptionEntity::class)]
    private $subscriptionEntities;

    #[ORM\OneToMany(mappedBy: 'storeOwner', targetEntity: StoreOwnerBranchEntity::class)]
    private $storeOwnerBranchEntities;

    #[ORM\Column(type: 'string', length: 20, nullable: true)]
    private $completeAccountStatus;

    #[ORM\OneToMany(mappedBy: 'storeOwner', targetEntity: OrderEntity::class)]
    private $orderEntities;

    #[ORM\OneToMany(mappedBy: 'storeOwner', targetEntity: SubscriptionCaptainOfferEntity::class)]
    private $subscriptionCaptainOffer;

    #[ORM\OneToMany(mappedBy: 'storeOwnerProfile', targetEntity: OrderLogsEntity::class)]
    private $OrderLogsEntity;

    #[ORM\OneToMany(mappedBy: 'store', targetEntity: StoreOwnerPaymentEntity::class)]
    private $storeOwnerPaymentEntity;

    public function __construct()
    {
        $this->subscriptionEntities = new ArrayCollection();
        $this->storeOwnerBranchEntities = new ArrayCollection();
        $this->orderEntities = new ArrayCollection();
        $this->subscriptionCaptainOffer = new ArrayCollection();
        $this->OrderLogsEntity = new ArrayCollection();
        $this->storeOwnerPaymentEntity = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getStoreOwnerId(): ?string
    {
        return $this->storeOwnerId;
    }

    public function setStoreOwnerId(?string $storeOwnerId): self
    {
        $this->storeOwnerId = $storeOwnerId;

        return $this;
    }

    public function getStoreOwnerName(): ?string
    {
        return $this->storeOwnerName;
    }

    public function setStoreOwnerName(?string $storeOwnerName): self
    {
        $this->storeOwnerName = $storeOwnerName;

        return $this;
    }

    public function getImages(): ?string
    {
        return $this->images;
    }

    public function setImages(?string $images): self
    {
        $this->images = $images;

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

    public function getRoomID(): ?string
    {
        return $this->roomID;
    }

    public function setRoomID(?string $roomID): self
    {
        $this->roomID = $roomID;

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

    public function getStoreCategoryId(): ?int
    {
        return $this->storeCategoryId;
    }

    public function setStoreCategoryId(?int $storeCategoryId): self
    {
        $this->storeCategoryId = $storeCategoryId;

        return $this;
    }

    public function getPhone(): ?string
    {
        return $this->phone;
    }

    public function setPhone(?string $phone): self
    {
        $this->phone = $phone;

        return $this;
    }

    public function getOpeningTime()
    {
        return $this->openingTime;
    }

    public function setOpeningTime($openingTime): self
    {
        $this->openingTime = new \DateTime ($openingTime);

        return $this;
    }

    public function getClosingTime()
    {
        return $this->closingTime;
    }

    public function setClosingTime($closingTime): self
    {
        $this->closingTime = new \DateTime ($closingTime);

        return $this;
    }

    public function getCommission(): ?float
    {
        return $this->commission;
    }

    public function setCommission(?float $commission): self
    {
        $this->commission = $commission;

        return $this;
    }

    public function getBankName(): ?string
    {
        return $this->bankName;
    }

    public function setBankName(?string $bankName): self
    {
        $this->bankName = $bankName;

        return $this;
    }

    public function getBankAccountNumber(): ?string
    {
        return $this->bankAccountNumber;
    }

    public function setBankAccountNumber(?string $bankAccountNumber): self
    {
        $this->bankAccountNumber = $bankAccountNumber;

        return $this;
    }

    public function getStcPay(): ?string
    {
        return $this->stcPay;
    }

    public function setStcPay(?string $stcPay): self
    {
        $this->stcPay = $stcPay;

        return $this;
    }

    public function getEmployeeCount(): ?string
    {
        return $this->employeeCount;
    }

    public function setEmployeeCount(?string $employeeCount): self
    {
        $this->employeeCount = $employeeCount;

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
            $subscriptionEntity->setStoreOwner($this);
        }

        return $this;
    }

    public function removeSubscriptionEntity(SubscriptionEntity $subscriptionEntity): self
    {
        if ($this->subscriptionEntities->removeElement($subscriptionEntity)) {
            // set the owning side to null (unless already changed)
            if ($subscriptionEntity->getStoreOwner() === $this) {
                $subscriptionEntity->setStoreOwner(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection|StoreOwnerBranchEntity[]
     */
    public function getStoreOwnerBranchEntities(): Collection
    {
        return $this->storeOwnerBranchEntities;
    }

    public function addStoreOwnerBranchEntity(StoreOwnerBranchEntity $storeOwnerBranchEntity): self
    {
        if (!$this->storeOwnerBranchEntities->contains($storeOwnerBranchEntity)) {
            $this->storeOwnerBranchEntities[] = $storeOwnerBranchEntity;
            $storeOwnerBranchEntity->setStoreOwner($this);
        }

        return $this;
    }

    public function removeStoreOwnerBranchEntity(StoreOwnerBranchEntity $storeOwnerBranchEntity): self
    {
        if ($this->storeOwnerBranchEntities->removeElement($storeOwnerBranchEntity)) {
            // set the owning side to null (unless already changed)
            if ($storeOwnerBranchEntity->getStoreOwner() === $this) {
                $storeOwnerBranchEntity->setStoreOwner(null);
            }
        }

        return $this;
    }

    public function getCompleteAccountStatus(): ?string
    {
        return $this->completeAccountStatus;
    }

    public function setCompleteAccountStatus(?string $completeAccountStatus): self
    {
        $this->completeAccountStatus = $completeAccountStatus;

        return $this;
    }

    /**
     * @return Collection|OrderEntity[]
     */
    public function getOrderEntities(): Collection
    {
        return $this->orderEntities;
    }

    public function addOrderEntity(OrderEntity $orderEntity): self
    {
        if (!$this->orderEntities->contains($orderEntity)) {
            $this->orderEntities[] = $orderEntity;
            $orderEntity->setStoreOwner($this);
        }

        return $this;
    }

    public function removeOrderEntity(OrderEntity $orderEntity): self
    {
        if ($this->orderEntities->removeElement($orderEntity)) {
            // set the owning side to null (unless already changed)
            if ($orderEntity->getStoreOwner() === $this) {
                $orderEntity->setStoreOwner(null);
            }
        }

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
            $subscriptionCaptainOffer->setStoreOwner($this);
        }

        return $this;
    }

    public function removeSubscriptionCaptainOffer(SubscriptionCaptainOfferEntity $subscriptionCaptainOffer): self
    {
        if ($this->subscriptionCaptainOffer->removeElement($subscriptionCaptainOffer)) {
            // set the owning side to null (unless already changed)
            if ($subscriptionCaptainOffer->getStoreOwner() === $this) {
                $subscriptionCaptainOffer->setStoreOwner(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection|OrderLogsEntity[]
     */
    public function getOrderLogsEntity(): Collection
    {
        return $this->OrderLogsEntity;
    }

    public function addOrderLogsEntity(OrderLogsEntity $orderLogsEntity): self
    {
        if (!$this->OrderLogsEntity->contains($orderLogsEntity)) {
            $this->OrderLogsEntity[] = $orderLogsEntity;
            $orderLogsEntity->setStoreOwnerProfile($this);
        }

        return $this;
    }

    public function removeOrderLogsEntity(OrderLogsEntity $orderLogsEntity): self
    {
        if ($this->OrderLogsEntity->removeElement($orderLogsEntity)) {
            // set the owning side to null (unless already changed)
            if ($orderLogsEntity->getStoreOwnerProfile() === $this) {
                $orderLogsEntity->setStoreOwnerProfile(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, StoreOwnerPaymentEntity>
     */
    public function getStoreOwnerPaymentEntity(): Collection
    {
        return $this->storeOwnerPaymentEntity;
    }

    public function addStoreOwnerPaymentEntity(StoreOwnerPaymentEntity $storeOwnerPaymentEntity): self
    {
        if (!$this->storeOwnerPaymentEntity->contains($storeOwnerPaymentEntity)) {
            $this->storeOwnerPaymentEntity[] = $storeOwnerPaymentEntity;
            $storeOwnerPaymentEntity->setStore($this);
        }

        return $this;
    }

    public function removeStoreOwnerPaymentEntity(StoreOwnerPaymentEntity $storeOwnerPaymentEntity): self
    {
        if ($this->storeOwnerPaymentEntity->removeElement($storeOwnerPaymentEntity)) {
            // set the owning side to null (unless already changed)
            if ($storeOwnerPaymentEntity->getStore() === $this) {
                $storeOwnerPaymentEntity->setStore(null);
            }
        }

        return $this;
    }
}
