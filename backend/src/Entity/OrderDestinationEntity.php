<?php

namespace App\Entity;

use App\Repository\OrderDestinationEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

// for saving wrong destination
#[ORM\Entity(repositoryClass: OrderDestinationEntityRepository::class)]
class OrderDestinationEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\ManyToOne(targetEntity: OrderEntity::class, inversedBy: 'orderDestinationEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $orderId;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\Column(type: 'text', nullable: true)]
    private $locationLink;

    public function getId(): ?int
    {
        return $this->id;
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

    public function getCreatedAt(): ?\DateTimeInterface
    {
        return $this->createdAt;
    }

    public function setCreatedAt(\DateTimeInterface $createdAt): self
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    public function getLocationLink(): ?string
    {
        return $this->locationLink;
    }

    public function setLocationLink(?string $locationLink): self
    {
        $this->locationLink = $locationLink;

        return $this;
    }
}
