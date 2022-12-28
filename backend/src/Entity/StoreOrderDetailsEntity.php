<?php

namespace App\Entity;

use App\Constant\Order\OrderDestinationConstant;
use App\Repository\StoreOrderDetailsEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: StoreOrderDetailsEntityRepository::class)]
class StoreOrderDetailsEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'json', nullable: true)]
    private $destination = [];

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $recipientName;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $recipientPhone;

    #[ORM\Column(type: 'text', nullable: true)]
    private $detail;

    #[ORM\ManyToOne(targetEntity: StoreOwnerBranchEntity::class, inversedBy: 'storeOrderDetailsEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $branch;

    #[ORM\OneToOne(targetEntity: orderEntity::class, cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private $orderId;

    #[ORM\OneToOne(targetEntity: ImageEntity::class, cascade: ['persist', 'remove'])]
    private $images;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $filePdf;

    #[ORM\Column(type: 'integer', options: ["default" => 1])]
    private $differentReceiverDestination = OrderDestinationConstant::ORDER_DESTINATION_IS_NOT_DIFFERENT_CONST;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDestination(): ?array
    {
        return $this->destination;
    }

    public function setDestination(array $destination): self
    {
        $this->destination = $destination;

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

    public function getDetail(): ?string
    {
        return $this->detail;
    }

    public function setDetail(string $detail): self
    {
        $this->detail = $detail;

        return $this;
    }

    public function getBranch(): ?StoreOwnerBranchEntity
    {
        return $this->branch;
    }

    public function setBranch(?StoreOwnerBranchEntity $branch): self
    {
        $this->branch = $branch;

        return $this;
    }

    public function getOrderId(): ?orderEntity
    {
        return $this->orderId;
    }

    public function setOrderId(orderEntity $orderId): self
    {
        $this->orderId = $orderId;

        return $this;
    }

    public function getImages(): ?ImageEntity
    {
        return $this->images;
    }

    public function setImages(?ImageEntity $images): self
    {
        $this->images = $images;

        return $this;
    }

    public function getFilePdf(): ?string
    {
        return $this->filePdf;
    }

    public function setFilePdf(?string $filePdf): self
    {
        $this->filePdf = $filePdf;

        return $this;
    }

    public function getDifferentReceiverDestination(): ?int
    {
        return $this->differentReceiverDestination;
    }

    public function setDifferentReceiverDestination(int $differentReceiverDestination): self
    {
        $this->differentReceiverDestination = $differentReceiverDestination;

        return $this;
    }
}
