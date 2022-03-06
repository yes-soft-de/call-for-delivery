<?php

namespace App\Entity;

use App\Repository\ChatRoomEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Uid\Uuid;

#[ORM\Entity(repositoryClass: ChatRoomEntityRepository::class)]
class ChatRoomEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'integer')]
    private $userId;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $usedAs;

    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\Column(type: 'uuid', unique: true)]
    private $roomId;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUserId(): ?int
    {
        return $this->userId;
    }

    public function setUserId(int $userId): self
    {
        $this->userId = $userId;

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
