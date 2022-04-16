<?php

namespace App\Entity;

use App\Repository\AnnouncementOrderDetailsEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: AnnouncementOrderDetailsEntityRepository::class)]
class AnnouncementOrderDetailsEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\OneToOne(targetEntity: OrderEntity::class, cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private $orderId;

    #[ORM\ManyToOne(targetEntity: AnnouncementEntity::class, inversedBy: 'announcementOrderDetailsEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $announcement;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    #[ORM\Column(type: 'float', nullable: true)]
    private $priceOfferValue;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $priceOfferStatus;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getOrderId(): ?OrderEntity
    {
        return $this->orderId;
    }

    public function setOrderId(OrderEntity $orderId): self
    {
        $this->orderId = $orderId;

        return $this;
    }

    public function getAnnouncement(): ?AnnouncementEntity
    {
        return $this->announcement;
    }

    public function setAnnouncement(?AnnouncementEntity $announcement): self
    {
        $this->announcement = $announcement;

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

    public function setUpdatedAt(\DateTimeInterface $updatedAt): self
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    public function getPriceOfferValue(): ?float
    {
        return $this->priceOfferValue;
    }

    public function setPriceOfferValue(?float $priceOfferValue): self
    {
        $this->priceOfferValue = $priceOfferValue;

        return $this;
    }

    public function getPriceOfferStatus(): ?int
    {
        return $this->priceOfferStatus;
    }

    public function setPriceOfferStatus(?int $priceOfferStatus): self
    {
        $this->priceOfferStatus = $priceOfferStatus;

        return $this;
    }
}
