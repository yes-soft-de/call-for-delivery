<?php

namespace App\Entity;

use App\Repository\OrderEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: OrderEntityRepository::class)]
class OrderEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 150)]
    private $state;

    #[ORM\Column(type: 'string', length: 100, nullable: true)]
    private $payment;

    #[ORM\Column(type: 'float', nullable: true)]
    private $orderCost;

    #[ORM\Column(type: 'integer')]
    private $orderType;

    #[ORM\Column(type: 'text', nullable: true)]
    private $note;

    #[ORM\Column(type: 'text', nullable: true)]
    private $noteCaptainOrderCost;

    #[ORM\Column(type: 'datetime')]
    private $deliveryDate;

    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $updatedAt;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $kilometer;

    #[ORM\Column(type: 'float', nullable: true)]
    private $captainOrderCost;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'orderEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $storeOwner;

    #[ORM\OneToMany(mappedBy: 'orderId', targetEntity: OrderChatRoomEntity::class)]
    private $orderChatRoomEntities;

    #[ORM\ManyToOne(targetEntity: CaptainEntity::class, inversedBy: 'orderEntity')]
    private $captainId;

    #[ORM\Column(type: 'boolean', nullable: true)]
    private $isCaptainArrived;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $dateCaptainArrived;
    
    #[ORM\OneToMany(mappedBy: 'orderId', targetEntity: RateEntity::class)]
    private $rateEntity;

    #[ORM\OneToMany(mappedBy: 'orderId', targetEntity: OrderLogsEntity::class)]
    private $OrderLogsEntity;

    public function __construct()
    {
        $this->orderChatRoomEntities = new ArrayCollection();
        $this->rateEntity = new ArrayCollection();
        $this->OrderLogsEntity = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getState(): ?string
    {
        return $this->state;
    }

    public function setState(string $state): self
    {
        $this->state = $state;

        return $this;
    }

    public function getPayment(): ?string
    {
        return $this->payment;
    }

    public function setPayment(string $payment): self
    {
        $this->payment = $payment;

        return $this;
    }

    public function getOrderCost(): ?float
    {
        return $this->orderCost;
    }

    public function setOrderCost(?float $orderCost): self
    {
        $this->orderCost = $orderCost;

        return $this;
    }

    public function getCaptainOrderCost(): ?float
    {
        return $this->captainOrderCost;
    }

    public function setCaptainOrderCost(?float $captainOrderCost): self
    {
        $this->captainOrderCost = $captainOrderCost;

        return $this;
    }

    public function getOrderType(): ?int
    {
        return $this->orderType;
    }

    public function setOrderType(int $orderType): self
    {
        $this->orderType = $orderType;

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

    public function getNoteCaptainOrderCost(): ?string
    {
        return $this->noteCaptainOrderCost;
    }

    public function setNoteCaptainOrderCost(?string $noteCaptainOrderCost): self
    {
        $this->noteCaptainOrderCost = $noteCaptainOrderCost;

        return $this;
    }

    public function getDeliveryDate()
    {
        return $this->deliveryDate;
    }

    public function setDeliveryDate($deliveryDate): self
    {
        $this->deliveryDate =  new \DateTime($deliveryDate);

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

    public function setUpdatedAt(?\DateTimeInterface $updatedAt): self
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    public function getKilometer(): ?int
    {
        return $this->kilometer;
    }

    public function setKilometer(?int $kilometer): self
    {
        $this->kilometer = $kilometer;

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
     * @return Collection|OrderChatRoomEntity[]
     */
    public function getOrderChatRoomEntities(): Collection
    {
        return $this->orderChatRoomEntities;
    }

    public function addOrderChatRoomEntity(OrderChatRoomEntity $orderChatRoomEntity): self
    {
        if (!$this->orderChatRoomEntities->contains($orderChatRoomEntity)) {
            $this->orderChatRoomEntities[] = $orderChatRoomEntity;
            $orderChatRoomEntity->setOrderId($this);
        }

        return $this;
    }

    public function removeOrderChatRoomEntity(OrderChatRoomEntity $orderChatRoomEntity): self
    {
        if ($this->orderChatRoomEntities->removeElement($orderChatRoomEntity)) {
            // set the owning side to null (unless already changed)
            if ($orderChatRoomEntity->getOrderId() === $this) {
                $orderChatRoomEntity->setOrderId(null);
            }
        }

        return $this;
    }

    public function getCaptainId(): ?CaptainEntity
    {
        return $this->captainId;
    }

    public function setCaptainId(?CaptainEntity $captainId): self
    {
        $this->captainId = $captainId;

        return $this;
    }

    public function getIsCaptainArrived(): ?bool
    {
        return $this->isCaptainArrived;
    }

    public function setIsCaptainArrived(?bool $isCaptainArrived): self
    {
        $this->isCaptainArrived = $isCaptainArrived;
        return $this;
    }
    
    /**
     * @return Collection|RateEntity[]
     */
    public function getRateEntity(): Collection
    {
        return $this->rateEntity;
    }

    public function addRateEntity(RateEntity $rateEntity): self
    {
        if (!$this->rateEntity->contains($rateEntity)) {
            $this->rateEntity[] = $rateEntity;
            $rateEntity->setOrderId($this);
        }

        return $this;
    }

    public function getDateCaptainArrived(): ?\DateTimeInterface
    {
        return $this->dateCaptainArrived;
    }

    public function setDateCaptainArrived(?\DateTimeInterface $dateCaptainArrived): self
    {
        $this->dateCaptainArrived = $dateCaptainArrived;
       
        return $this;
    }
    public function removeRateEntity(RateEntity $rateEntity): self
    {
        if ($this->rateEntity->removeElement($rateEntity)) {
            // set the owning side to null (unless already changed)
            if ($rateEntity->getOrderId() === $this) {
                $rateEntity->setOrderId(null);
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
            $orderLogsEntity->setOrderId($this);
        }

        return $this;
    }

    public function removeOrderLogsEntity(OrderLogsEntity $orderLogsEntity): self
    {
        if ($this->OrderLogsEntity->removeElement($orderLogsEntity)) {
            // set the owning side to null (unless already changed)
            if ($orderLogsEntity->getOrderId() === $this) {
                $orderLogsEntity->setOrderId(null);
            }
        }

        return $this;
    }
}
