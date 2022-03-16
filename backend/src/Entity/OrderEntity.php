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

    #[ORM\Column(type: 'datetime')]
    private $deliveryDate;

    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $updatedAt;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $kilometer;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'orderEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $storeOwner;

    #[ORM\OneToMany(mappedBy: 'orderId', targetEntity: OrderChatRoomEntity::class)]
    private $orderChatRoomEntities;

    #[ORM\ManyToOne(targetEntity: CaptainEntity::class, inversedBy: 'orderEntity')]
    private $captainId;

    public function __construct()
    {
        $this->orderChatRoomEntities = new ArrayCollection();
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
}
