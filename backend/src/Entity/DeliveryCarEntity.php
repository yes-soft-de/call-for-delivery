<?php

namespace App\Entity;

use App\Repository\DeliveryCarEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: DeliveryCarEntityRepository::class)]
class DeliveryCarEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'text', nullable: true)]
    private $details;

    #[ORM\Column(type: 'float')]
    private $deliveryCost;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    #[ORM\Column(type: 'string', length: 255)]
    private $carModel;

    #[ORM\OneToMany(mappedBy: 'deliveryCar', targetEntity: PriceOfferEntity::class)]
    private $priceOfferEntities;

    public function __construct()
    {
        $this->priceOfferEntities = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDetails(): ?string
    {
        return $this->details;
    }

    public function setDetails(?string $details): self
    {
        $this->details = $details;

        return $this;
    }

    public function getDeliveryCost(): ?float
    {
        return $this->deliveryCost;
    }

    public function setDeliveryCost(float $deliveryCost): self
    {
        $this->deliveryCost = $deliveryCost;

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

    public function getCarModel(): ?string
    {
        return $this->carModel;
    }

    public function setCarModel(string $carModel): self
    {
        $this->carModel = $carModel;

        return $this;
    }

    /**
     * @return Collection|PriceOfferEntity[]
     */
    public function getPriceOfferEntities(): Collection
    {
        return $this->priceOfferEntities;
    }

    public function addPriceOfferEntity(PriceOfferEntity $priceOfferEntity): self
    {
        if (!$this->priceOfferEntities->contains($priceOfferEntity)) {
            $this->priceOfferEntities[] = $priceOfferEntity;
            $priceOfferEntity->setDeliveryCar($this);
        }

        return $this;
    }

    public function removePriceOfferEntity(PriceOfferEntity $priceOfferEntity): self
    {
        if ($this->priceOfferEntities->removeElement($priceOfferEntity)) {
            // set the owning side to null (unless already changed)
            if ($priceOfferEntity->getDeliveryCar() === $this) {
                $priceOfferEntity->setDeliveryCar(null);
            }
        }

        return $this;
    }
}
