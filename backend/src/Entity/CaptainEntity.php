<?php

namespace App\Entity;

use App\Repository\CaptainEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: CaptainEntityRepository::class)]
class CaptainEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'integer')]
    private $captainId;

    #[ORM\Column(type: 'string', length: 255)]
    private $captainName;

    #[ORM\Column(type: 'json', nullable: true)]
    private $location = [];

    #[ORM\Column(type: 'integer', nullable: true)]
    private $age;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $car;

    #[ORM\Column(type: 'float', nullable: true)]
    private $salary;

    #[ORM\Column(type: 'string', length: 255)]
    private $status;

    #[ORM\Column(type: 'float', nullable: true)]
    private $bounce;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $phone;

    #[ORM\Column(type: 'boolean')]
    private $isOnline;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $bankName;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $bankAccountNumber;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $stcPay;

    #[ORM\Column(type: 'string', length: 20, nullable: true)]
    private $completeAccountStatus;

    #[ORM\OneToMany(mappedBy: 'captainId', targetEntity: OrderEntity::class)]
    private $orderEntity;

    #[ORM\OneToMany(mappedBy: 'captain', targetEntity: OrderChatRoomEntity::class)]
    private $orderChatRoomEntity;

    #[ORM\OneToMany(mappedBy: 'captainProfile', targetEntity: OrderTimeLineEntity::class)]
    private $OrderLogsEntity;

    #[ORM\OneToMany(mappedBy: 'captain', targetEntity: CaptainPaymentEntity::class)]
    private $captainPaymentEntity;
    
    #[ORM\OneToMany(mappedBy: 'captain', targetEntity: CaptainFinancialSystemDetailEntity::class)]
    private $captainFinancialSystemDetailEntity;

    #[ORM\OneToMany(mappedBy: 'captain', targetEntity: CaptainPaymentToCompanyEntity::class)]
    private $captainPaymentToCompanyEntity;

    #[ORM\OneToMany(mappedBy: 'captain', targetEntity: CaptainFinancialDuesEntity::class)]
    private $captainFinancialDuesEntity;

    #[ORM\OneToMany(mappedBy: 'captain', targetEntity: CaptainAmountFromOrderCashEntity::class)]
    private $captainAmountFromOrderCash;

    #[ORM\OneToMany(mappedBy: 'captainProfile', targetEntity: OrderLogEntity::class)]
    private $orderLogEntities;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime', nullable: true)]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    public function __construct()
    {
        $this->orderEntity = new ArrayCollection();
        $this->orderChatRoomEntity = new ArrayCollection();
        $this->OrderLogsEntity = new ArrayCollection();
        $this->captainPaymentEntity = new ArrayCollection();
        $this->captainFinancialSystemDetailEntity = new ArrayCollection();
        $this->captainPaymentToCompanyEntity = new ArrayCollection();
        $this->captainFinancialDuesEntity = new ArrayCollection();
        $this->captainAmountFromOrderCash = new ArrayCollection();
        $this->orderLogEntities = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCaptainId(): ?int
    {
        return $this->captainId;
    }

    public function setCaptainId(int $captainId): self
    {
        $this->captainId = $captainId;

        return $this;
    }

    public function getCaptainName(): ?string
    {
        return $this->captainName;
    }

    public function setCaptainName(string $captainName): self
    {
        $this->captainName = $captainName;

        return $this;
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

    public function getAge(): ?int
    {
        return $this->age;
    }

    public function setAge(?int $age): self
    {
        $this->age = $age;

        return $this;
    }

    public function getCar(): ?string
    {
        return $this->car;
    }

    public function setCar(?string $car): self
    {
        $this->car = $car;

        return $this;
    }

    public function getSalary(): ?float
    {
        return $this->salary;
    }

    public function setSalary(?float $salary): self
    {
        $this->salary = $salary;

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

    public function getBounce(): ?float
    {
        return $this->bounce;
    }

    public function setBounce(?float $bounce): self
    {
        $this->bounce = $bounce;

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

    public function getIsOnline(): ?bool
    {
        return $this->isOnline;
    }

    public function setIsOnline(bool $isOnline): self
    {
        $this->isOnline = $isOnline;

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
    public function getOrderEntity(): Collection
    {
        return $this->orderEntity;
    }

    public function addOrderEntity(OrderEntity $orderEntity): self
    {
        if (!$this->orderEntity->contains($orderEntity)) {
            $this->orderEntity[] = $orderEntity;
            $orderEntity->setCaptainId($this);
        }

        return $this;
    }

    public function removeOrderEntity(OrderEntity $orderEntity): self
    {
        if ($this->orderEntity->removeElement($orderEntity)) {
            // set the owning side to null (unless already changed)
            if ($orderEntity->getCaptainId() === $this) {
                $orderEntity->setCaptainId(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection|OrderChatRoomEntity[]
     */
    public function getOrderChatRoomEntity(): Collection
    {
        return $this->orderChatRoomEntity;
    }

    public function addOrderChatRoomEntity(OrderChatRoomEntity $orderChatRoomEntity): self
    {
        if (!$this->orderChatRoomEntity->contains($orderChatRoomEntity)) {
            $this->orderChatRoomEntity[] = $orderChatRoomEntity;
            $orderChatRoomEntity->setCaptain($this);
        }

        return $this;
    }

    public function removeOrderChatRoomEntity(OrderChatRoomEntity $orderChatRoomEntity): self
    {
        if ($this->orderChatRoomEntity->removeElement($orderChatRoomEntity)) {
            // set the owning side to null (unless already changed)
            if ($orderChatRoomEntity->getCaptain() === $this) {
                $orderChatRoomEntity->setCaptain(null);
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
            $orderLogsEntity->setCaptainProfile($this);
        }

        return $this;
    }

    public function removeOrderLogsEntity(OrderTimeLineEntity $orderLogsEntity): self
    {
        if ($this->OrderLogsEntity->removeElement($orderLogsEntity)) {
            // set the owning side to null (unless already changed)
            if ($orderLogsEntity->getCaptainProfile() === $this) {
                $orderLogsEntity->setCaptainProfile(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, CaptainPaymentEntity>
     */
    public function getCaptainPaymentEntity(): Collection
    {
        return $this->captainPaymentEntity;
    }

    public function addCaptainPaymentEntity(CaptainPaymentEntity $captainPaymentEntity): self
    {
        if (!$this->captainPaymentEntity->contains($captainPaymentEntity)) {
            $this->captainPaymentEntity[] = $captainPaymentEntity;
            $captainPaymentEntity->setCaptain($this);
        }

        return $this;
    }

    public function removeCaptainPaymentEntity(CaptainPaymentEntity $captainPaymentEntity): self
    {
        if ($this->captainPaymentEntity->removeElement($captainPaymentEntity)) {
            // set the owning side to null (unless already changed)
            if ($captainPaymentEntity->getCaptain() === $this) {
                $captainPaymentEntity->setCaptain(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, CaptainFinancialSystemDetailEntity>
     */
    public function getCaptainFinancialSystemDetailEntity(): Collection
    {
        return $this->captainFinancialSystemDetailEntity;
    }

    public function addCaptainFinancialSystemDetailEntity(CaptainFinancialSystemDetailEntity $captainFinancialSystemDetailEntity): self
    {
        if (!$this->captainFinancialSystemDetailEntity->contains($captainFinancialSystemDetailEntity)) {
            $this->captainFinancialSystemDetailEntity[] = $captainFinancialSystemDetailEntity;
            $captainFinancialSystemDetailEntity->setCaptain($this);
        }

        return $this;
    }

    public function removeCaptainFinancialSystemDetailEntity(CaptainFinancialSystemDetailEntity $captainFinancialSystemDetailEntity): self
    {
        if ($this->captainFinancialSystemDetailEntity->removeElement($captainFinancialSystemDetailEntity)) {
            // set the owning side to null (unless already changed)
            if ($captainFinancialSystemDetailEntity->getCaptain() === $this) {
                $captainFinancialSystemDetailEntity->setCaptain(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, CaptainPaymentToCompanyEntity>
     */
    public function getCaptainPaymentToCompanyEntity(): Collection
    {
        return $this->captainPaymentToCompanyEntity;
    }

    public function addCaptainPaymentToCompanyEntity(CaptainPaymentToCompanyEntity $captainPaymentToCompanyEntity): self
    {
        if (!$this->captainPaymentToCompanyEntity->contains($captainPaymentToCompanyEntity)) {
            $this->captainPaymentToCompanyEntity[] = $captainPaymentToCompanyEntity;
            $captainPaymentToCompanyEntity->setCaptain($this);
        }

        return $this;
    }

    public function removeCaptainPaymentToCompanyEntity(CaptainPaymentToCompanyEntity $captainPaymentToCompanyEntity): self
    {
        if ($this->captainPaymentToCompanyEntity->removeElement($captainPaymentToCompanyEntity)) {
            // set the owning side to null (unless already changed)
            if ($captainPaymentToCompanyEntity->getCaptain() === $this) {
                $captainPaymentToCompanyEntity->setCaptain(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, CaptainFinancialDuesEntity>
     */
    public function getCaptainFinancialDuesEntity(): Collection
    {
        return $this->captainFinancialDuesEntity;
    }

    public function addCaptainFinancialDuesEntity(CaptainFinancialDuesEntity $captainFinancialDuesEntity): self
    {
        if (!$this->captainFinancialDuesEntity->contains($captainFinancialDuesEntity)) {
            $this->captainFinancialDuesEntity[] = $captainFinancialDuesEntity;
            $captainFinancialDuesEntity->setCaptain($this);
        }

        return $this;
    }

    public function removeCaptainFinancialDuesEntity(CaptainFinancialDuesEntity $captainFinancialDuesEntity): self
    {
        if ($this->captainFinancialDuesEntity->removeElement($captainFinancialDuesEntity)) {
            // set the owning side to null (unless already changed)
            if ($captainFinancialDuesEntity->getCaptain() === $this) {
                $captainFinancialDuesEntity->setCaptain(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, CaptainAmountFromOrderCashEntity>
     */
    public function getCaptainAmountFromOrderCash(): Collection
    {
        return $this->captainAmountFromOrderCash;
    }

    public function addCaptainAmountFromOrderCash(CaptainAmountFromOrderCashEntity $captainAmountFromOrderCash): self
    {
        if (!$this->captainAmountFromOrderCash->contains($captainAmountFromOrderCash)) {
            $this->captainAmountFromOrderCash[] = $captainAmountFromOrderCash;
            $captainAmountFromOrderCash->setCaptain($this);
        }

        return $this;
    }

    public function removeCaptainAmountFromOrderCash(CaptainAmountFromOrderCashEntity $captainAmountFromOrderCash): self
    {
        if ($this->captainAmountFromOrderCash->removeElement($captainAmountFromOrderCash)) {
            // set the owning side to null (unless already changed)
            if ($captainAmountFromOrderCash->getCaptain() === $this) {
                $captainAmountFromOrderCash->setCaptain(null);
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
            $orderLogEntity->setCaptainProfile($this);
        }

        return $this;
    }

    public function removeOrderLogEntity(OrderLogEntity $orderLogEntity): self
    {
        if ($this->orderLogEntities->removeElement($orderLogEntity)) {
            // set the owning side to null (unless already changed)
            if ($orderLogEntity->getCaptainProfile() === $this) {
                $orderLogEntity->setCaptainProfile(null);
            }
        }

        return $this;
    }

    public function getCreatedAt(): ?\DateTimeInterface
    {
        return $this->createdAt;
    }

    public function setCreatedAt(?\DateTimeInterface $createdAt): self
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    public function getUpdatedAt(): ?\DateTimeInterface
    {
        return $this->updatedAt;
    }

    public function setUpdatedAt(\DateTimeInterface $updatedAt): self
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }
}
