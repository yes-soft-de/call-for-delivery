<?php

namespace App\Entity;

use App\Repository\CaptainEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

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

    public function __construct()
    {
        $this->orderEntity = new ArrayCollection();
        $this->orderChatRoomEntity = new ArrayCollection();
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
}
