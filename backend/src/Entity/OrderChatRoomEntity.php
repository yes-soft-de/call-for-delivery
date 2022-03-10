<?php

namespace App\Entity;

use App\Repository\OrderChatRoomEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Uid\Uuid;

#[ORM\Entity(repositoryClass: OrderChatRoomEntityRepository::class)]
//this class use chatRoom between captain and store
class OrderChatRoomEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $captainId;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $usedAs;

    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\ManyToOne(targetEntity: OrderEntity::class, inversedBy: 'orderChatRoomEntities')]
    private $orderId;

    #[ORM\Column(type: 'uuid', unique: true)]
    private $roomId;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCaptainId(): ?int
    {
        return $this->captainId;
    }

    public function setCaptainId(?int $captainId): self
    {
        $this->captainId = $captainId;

        return $this;
    }

    public function getUsedAs(): ?int
    {
        return $this->usedAs;
    }

    public function setUsedAs(?int $usedAs): self
    {
        $this->usedAs = $usedAs;

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

    public function getOrderId(): ?OrderEntity
    {
        return $this->orderId;
    }

    public function setOrderId(?OrderEntity $orderId): self
    {
        $this->orderId = $orderId;

        return $this;
    }
    
    public function getRoomId():? uuid
    {
        return $this->roomId;
    }

    public function setRoomId($roomId): self
    {
        $this->roomId = $roomId;

        return $this;
    }
}
