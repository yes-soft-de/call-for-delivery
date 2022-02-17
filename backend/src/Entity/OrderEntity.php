<?php

namespace App\Entity;

use App\Repository\OrderEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: OrderEntityRepository::class)]
class OrderEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'orderEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $storeOwner;

    #[ORM\Column(type: 'json', nullable: true)]
    private $source = [];

    #[ORM\Column(type: 'json', nullable: true)]
    private $destination = [];

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $createdAt;

    #[ORM\Column(type: 'text', nullable: true)]
    private $note;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $deliveryDate;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $payment;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $recipientName;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $recipientPhone;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $updatedAt;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $state;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $roomId;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $kilometer;

    #[ORM\Column(type: 'text', nullable: true)]
    private $detail;

    public function getId(): ?int
    {
        return $this->id;
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

    public function getSource(): ?array
    {
        return $this->source;
    }

    public function setSource(?array $source): self
    {
        $this->source = $source;

        return $this;
    }

    public function getDestination(): ?array
    {
        return $this->destination;
    }

    public function setDestination(?array $destination): self
    {
        $this->destination = $destination;

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

    public function getNote(): ?string
    {
        return $this->note;
    }

    public function setNote(?string $note): self
    {
        $this->note = $note;

        return $this;
    }

    public function getDeliveryDate(): ?\DateTimeInterface
    {
        return $this->deliveryDate;
    }

    public function setDeliveryDate(?\DateTimeInterface $deliveryDate): self
    {
        $this->deliveryDate = $deliveryDate;

        return $this;
    }

    public function getPayment(): ?string
    {
        return $this->payment;
    }

    public function setPayment(?string $payment): self
    {
        $this->payment = $payment;

        return $this;
    }

    public function getRecipientName(): ?string
    {
        return $this->recipientName;
    }

    public function setRecipientName(?string $recipientName): self
    {
        $this->recipientName = $recipientName;

        return $this;
    }

    public function getRecipientPhone(): ?string
    {
        return $this->recipientPhone;
    }

    public function setRecipientPhone(?string $recipientPhone): self
    {
        $this->recipientPhone = $recipientPhone;

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

    public function getState(): ?string
    {
        return $this->state;
    }

    public function setState(?string $state): self
    {
        $this->state = $state;

        return $this;
    }

    public function getRoomId(): ?string
    {
        return $this->roomId;
    }

    public function setRoomId(?string $roomId): self
    {
        $this->roomId = $roomId;

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

    public function getDetail(): ?string
    {
        return $this->detail;
    }

    public function setDetail(?string $detail): self
    {
        $this->detail = $detail;

        return $this;
    }
}
