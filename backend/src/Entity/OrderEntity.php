<?php

namespace App\Entity;

use App\Repository\OrderEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

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

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime', nullable: true)]
    private $updatedAt;

    #[ORM\Column(type: 'float', nullable: true)]
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

    #[ORM\OneToMany(mappedBy: 'orderId', targetEntity: OrderTimeLineEntity::class)]
    private $OrderLogsEntity;

    #[ORM\OneToOne(mappedBy: 'orderId', targetEntity: BidDetailsEntity::class, cascade: ['persist', 'remove'])]
    private $bidDetailsEntity;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $paidToProvider;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $isHide;

    #[ORM\ManyToOne(targetEntity: self::class, inversedBy: 'orderEntities')]
    private $primaryOrder;

    #[ORM\OneToMany(mappedBy: 'primaryOrder', targetEntity: self::class)]
    private $orderEntities;

    #[ORM\Column(type: 'boolean', nullable: true)]
    private $orderIsMain;

    #[ORM\OneToMany(mappedBy: 'orderId', targetEntity: OrderLogEntity::class)]
    private $orderLogEntities;

    #[ORM\Column(type: 'float', nullable: true)]
    private $storeBranchToClientDistance;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $isCashPaymentConfirmedByStore;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $isCashPaymentConfirmedByStoreUpdateDate;

    // refers if the order has conflict answers (from store and captain) about cash payments
    // 1: conflict. 2: there isn't a conflict. 3: conflict resolved by command. 4: conflict resolved by API
    #[ORM\Column(type: 'integer', nullable: true)]
    private $hasPayConflictAnswers;

    // Auto-calculated value depending on the distance which is being calculated by Google MAP API
    #[ORM\Column(type: 'float', nullable: true)]
    private $deliveryCost;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $conflictedAnswersResolvedBy;

    // store isHide value before hide order for updating it
    #[ORM\Column(type: 'integer', options: ["default" => 2])]
    private $previousVisibility;

    #[ORM\Column(type: 'text', nullable: true)]
    private $storeBranchToClientDistanceAdditionExplanation;

    #[ORM\OneToMany(mappedBy: 'orderId', targetEntity: DashboardLocalNotificationEntity::class)]
    private $dashboardLocalNotificationEntities;

    #[ORM\Column(type: 'smallint', nullable: true)]
    private $costType;

    // Refers to the user type who cancelled the order, and at what state
    #[ORM\Column(type: 'integer', nullable: true)]
    private $orderCancelledByUserAndAtState;

    #[ORM\OneToOne(mappedBy: 'orderId', targetEntity: OrderDistanceConflictEntity::class, cascade: ['persist', 'remove'])]
    private $orderDistanceConflictEntity;

    public function __construct()
    {
        $this->orderChatRoomEntities = new ArrayCollection();
        $this->rateEntity = new ArrayCollection();
        $this->OrderLogsEntity = new ArrayCollection();
        $this->orderEntities = new ArrayCollection();
        $this->orderLogEntities = new ArrayCollection();
        $this->dashboardLocalNotificationEntities = new ArrayCollection();
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

    public function getKilometer(): ?float
    {
        return $this->kilometer;
    }

    public function setKilometer(?float $kilometer): self
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
     * @return Collection|OrderTimeLineEntity[]
     */
    public function getOrderLogsEntity(): Collection
    {
        return $this->OrderLogsEntity;
    }

    public function addOrderLogsEntity(OrderTimeLineEntity $orderLogsEntity): self
    {
        if (!$this->OrderLogsEntity->contains($orderLogsEntity)) {
            $this->OrderLogsEntity[] = $orderLogsEntity;
            $orderLogsEntity->setOrderId($this);
        }

        return $this;
    }

    public function removeOrderLogsEntity(OrderTimeLineEntity $orderLogsEntity): self
    {
        if ($this->OrderLogsEntity->removeElement($orderLogsEntity)) {
            // set the owning side to null (unless already changed)
            if ($orderLogsEntity->getOrderId() === $this) {
                $orderLogsEntity->setOrderId(null);
            }
        }

        return $this;
    }

    public function getBidDetailsEntity(): ?BidDetailsEntity
    {
        return $this->bidDetailsEntity;
    }

    public function setBidDetailsEntity(BidDetailsEntity $bidDetailsEntity): self
    {
        // set the owning side of the relation if necessary
        if ($bidDetailsEntity->getOrderId() !== $this) {
            $bidDetailsEntity->setOrderId($this);
        }

        $this->bidDetailsEntity = $bidDetailsEntity;

        return $this;
    }

    public function getPaidToProvider(): ?int
    {
        return $this->paidToProvider;
    }

    public function setPaidToProvider(?int $paidToProvider): self
    {
        $this->paidToProvider = $paidToProvider;

        return $this;
    }

    public function getIsHide(): ?int
    {
        return $this->isHide;
    }

    public function setIsHide(?int $isHide): self
    {
        $this->isHide = $isHide;

        return $this;
    }

    public function getPrimaryOrder(): ?self
    {
        return $this->primaryOrder;
    }

    public function setPrimaryOrder(?self $primaryOrder): self
    {
        $this->primaryOrder = $primaryOrder;

        return $this;
    }

    /**
     * @return Collection<int, self>
     */
    public function getOrderEntities(): Collection
    {
        return $this->orderEntities;
    }

    public function addOrderEntity(self $orderEntity): self
    {
        if (!$this->orderEntities->contains($orderEntity)) {
            $this->orderEntities[] = $orderEntity;
            $orderEntity->setPrimaryOrder($this);
        }

        return $this;
    }

    public function removeOrderEntity(self $orderEntity): self
    {
        if ($this->orderEntities->removeElement($orderEntity)) {
            // set the owning side to null (unless already changed)
            if ($orderEntity->getPrimaryOrder() === $this) {
                $orderEntity->setPrimaryOrder(null);
            }
        }

        return $this;
    }

    public function getOrderIsMain(): ?bool
    {
        return $this->orderIsMain;
    }

    public function setOrderIsMain(?bool $orderIsMain): self
    {
        $this->orderIsMain = $orderIsMain;

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
            $orderLogEntity->setOrderId($this);
        }

        return $this;
    }

    public function removeOrderLogEntity(OrderLogEntity $orderLogEntity): self
    {
        if ($this->orderLogEntities->removeElement($orderLogEntity)) {
            // set the owning side to null (unless already changed)
            if ($orderLogEntity->getOrderId() === $this) {
                $orderLogEntity->setOrderId(null);
            }
        }

        return $this;
    }

    public function getStoreBranchToClientDistance(): ?float
    {
        return $this->storeBranchToClientDistance;
    }

    public function setStoreBranchToClientDistance(?float $storeBranchToClientDistance): self
    {
        $this->storeBranchToClientDistance = $storeBranchToClientDistance;

        return $this;
    }

    public function getIsCashPaymentConfirmedByStore(): ?int
    {
        return $this->isCashPaymentConfirmedByStore;
    }

    public function setIsCashPaymentConfirmedByStore(?int $isCashPaymentConfirmedByStore): self
    {
        $this->isCashPaymentConfirmedByStore = $isCashPaymentConfirmedByStore;

        return $this;
    }

    public function getIsCashPaymentConfirmedByStoreUpdateDate(): ?\DateTimeInterface
    {
        return $this->isCashPaymentConfirmedByStoreUpdateDate;
    }

    public function setIsCashPaymentConfirmedByStoreUpdateDate(?\DateTimeInterface $isCashPaymentConfirmedByStoreUpdateDate): self
    {
        $this->isCashPaymentConfirmedByStoreUpdateDate = $isCashPaymentConfirmedByStoreUpdateDate;

        return $this;
    }

    public function getHasPayConflictAnswers(): ?int
    {
        return $this->hasPayConflictAnswers;
    }

    public function setHasPayConflictAnswers(?int $hasPayConflictAnswers): self
    {
        $this->hasPayConflictAnswers = $hasPayConflictAnswers;

        return $this;
    }

    public function getDeliveryCost(): ?float
    {
        return $this->deliveryCost;
    }

    public function setDeliveryCost(?float $deliveryCost): self
    {
        $this->deliveryCost = $deliveryCost;

        return $this;
    }

    public function getConflictedAnswersResolvedBy(): ?int
    {
        return $this->conflictedAnswersResolvedBy;
    }

    public function setConflictedAnswersResolvedBy(?int $conflictedAnswersResolvedBy): self
    {
        $this->conflictedAnswersResolvedBy = $conflictedAnswersResolvedBy;

        return $this;
    }

    public function getPreviousVisibility(): int
    {
        return $this->previousVisibility;
    }

    public function setPreviousVisibility(int $previousVisibility): self
    {
        $this->previousVisibility = $previousVisibility;

        return $this;
    }

    public function getStoreBranchToClientDistanceAdditionExplanation(): ?string
    {
        return $this->storeBranchToClientDistanceAdditionExplanation;
    }

    public function setStoreBranchToClientDistanceAdditionExplanation(?string $storeBranchToClientDistanceAdditionExplanation): self
    {
        $this->storeBranchToClientDistanceAdditionExplanation = $storeBranchToClientDistanceAdditionExplanation;

        return $this;
    }

    /**
     * @return Collection<int, DashboardLocalNotificationEntity>
     */
    public function getDashboardLocalNotificationEntities(): Collection
    {
        return $this->dashboardLocalNotificationEntities;
    }

    public function addDashboardLocalNotificationEntity(DashboardLocalNotificationEntity $dashboardLocalNotificationEntity): self
    {
        if (!$this->dashboardLocalNotificationEntities->contains($dashboardLocalNotificationEntity)) {
            $this->dashboardLocalNotificationEntities[] = $dashboardLocalNotificationEntity;
            $dashboardLocalNotificationEntity->setOrderId($this);
        }

        return $this;
    }

    public function removeDashboardLocalNotificationEntity(DashboardLocalNotificationEntity $dashboardLocalNotificationEntity): self
    {
        if ($this->dashboardLocalNotificationEntities->removeElement($dashboardLocalNotificationEntity)) {
            // set the owning side to null (unless already changed)
            if ($dashboardLocalNotificationEntity->getOrderId() === $this) {
                $dashboardLocalNotificationEntity->setOrderId(null);
            }
        }

        return $this;
    }

    public function getCostType(): ?int
    {
        return $this->costType;
    }

    public function setCostType(?int $costType): self
    {
        $this->costType = $costType;

        return $this;
    }

    public function getOrderCancelledByUserAndAtState(): ?int
    {
        return $this->orderCancelledByUserAndAtState;
    }

    public function setOrderCancelledByUserAndAtState(?int $orderCancelledByUserAndAtState): self
    {
        $this->orderCancelledByUserAndAtState = $orderCancelledByUserAndAtState;

        return $this;
    }

    public function getOrderDistanceConflictEntity(): ?OrderDistanceConflictEntity
    {
        return $this->orderDistanceConflictEntity;
    }

    public function setOrderDistanceConflictEntity(OrderDistanceConflictEntity $orderDistanceConflictEntity): self
    {
        // set the owning side of the relation if necessary
        if ($orderDistanceConflictEntity->getOrderId() !== $this) {
            $orderDistanceConflictEntity->setOrderId($this);
        }

        $this->orderDistanceConflictEntity = $orderDistanceConflictEntity;

        return $this;
    }
}
