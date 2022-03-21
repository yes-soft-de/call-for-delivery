<?php

namespace App\Entity;

use App\Repository\OrderChatRoomEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Uid\Uuid;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: OrderChatRoomEntityRepository::class)]
//this class use chatRoom between captain and store
class OrderChatRoomEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $usedAs;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\ManyToOne(targetEntity: OrderEntity::class, inversedBy: 'orderChatRoomEntities')]
    private $orderId;

    #[ORM\Column(type: 'uuid', unique: true)]
    private $roomId;

    #[ORM\ManyToOne(targetEntity: CaptainEntity::class, inversedBy: 'orderChatRoomEntity')]
    #[ORM\JoinColumn(nullable: false)]
    private $captain;

    public function getId(): ?int
    {
        return $this->id;
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

    public function getCaptain(): ?CaptainEntity
    {
        return $this->captain;
    }

    public function setCaptain(?CaptainEntity $captain): self
    {
        $this->captain = $captain;

        return $this;
    }
}
