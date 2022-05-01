<?php

namespace App\Entity;

use App\Repository\PriceOfferEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: PriceOfferEntityRepository::class)]
class PriceOfferEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\ManyToOne(targetEntity: BidDetailsEntity::class, inversedBy: 'priceOfferEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $bidDetails;

    #[ORM\ManyToOne(targetEntity: SupplierProfileEntity::class)]
    #[ORM\JoinColumn(nullable: false)]
    private $supplierProfile;

    #[ORM\Column(type: 'float')]
    private $priceOfferValue;

    #[ORM\Column(type: 'string', length: 50)]
    private $priceOfferStatus;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $offerDeadline;

    #[ORM\ManyToOne(targetEntity: DeliveryCarEntity::class, inversedBy: 'priceOfferEntities')]
    private $deliveryCar;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $transportationCount;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getBidDetails(): ?BidDetailsEntity
    {
        return $this->bidDetails;
    }

    public function setBidDetails(?BidDetailsEntity $bidDetails): self
    {
        $this->bidDetails = $bidDetails;

        return $this;
    }

    public function getSupplierProfile(): ?SupplierProfileEntity
    {
        return $this->supplierProfile;
    }

    public function setSupplierProfile(?SupplierProfileEntity $supplierProfile): self
    {
        $this->supplierProfile = $supplierProfile;

        return $this;
    }

    public function getPriceOfferValue(): ?float
    {
        return $this->priceOfferValue;
    }

    public function setPriceOfferValue(float $priceOfferValue): self
    {
        $this->priceOfferValue = $priceOfferValue;

        return $this;
    }

    public function getPriceOfferStatus(): ?string
    {
        return $this->priceOfferStatus;
    }

    public function setPriceOfferStatus(string $priceOfferStatus): self
    {
        $this->priceOfferStatus = $priceOfferStatus;

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

    public function getOfferDeadline(): ?\DateTimeInterface
    {
        return $this->offerDeadline;
    }

    public function setOfferDeadline(?\DateTimeInterface $offerDeadline): self
    {
        $this->offerDeadline = $offerDeadline;

        return $this;
    }

    public function getDeliveryCar(): ?DeliveryCarEntity
    {
        return $this->deliveryCar;
    }

    public function setDeliveryCar(?DeliveryCarEntity $deliveryCar): self
    {
        $this->deliveryCar = $deliveryCar;

        return $this;
    }

    public function getTransportationCount(): ?int
    {
        return $this->transportationCount;
    }

    public function setTransportationCount(?int $transportationCount): self
    {
        $this->transportationCount = $transportationCount;

        return $this;
    }
}
