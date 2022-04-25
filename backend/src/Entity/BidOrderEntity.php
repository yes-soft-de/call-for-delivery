<?php

namespace App\Entity;

use App\Repository\BidOrderEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: BidOrderEntityRepository::class)]
class BidOrderEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $title;

    #[ORM\Column(type: 'text', nullable: true)]
    private $description;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    #[ORM\ManyToOne(targetEntity: SupplierCategoryEntity::class)]
    #[ORM\JoinColumn(nullable: false)]
    private $supplierCategory;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class)]
    #[ORM\JoinColumn(nullable: true)]
    private $storeOwnerProfile;

    #[ORM\OneToMany(mappedBy: 'bidOrder', targetEntity: ImageEntity::class)]
    private $images;

    #[ORM\OneToMany(mappedBy: 'bidOrder', targetEntity: PriceOfferEntity::class)]
    private $priceOfferEntities;

    #[ORM\Column(type: 'boolean')]
    private $openToPriceOffer = true;

    #[ORM\OneToOne(targetEntity: OrderEntity::class, cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private $orderId;

    public function __construct()
    {
        $this->images = new ArrayCollection();
        $this->priceOfferEntities = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }

    public function setTitle(?string $title): self
    {
        $this->title = $title;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(?string $description): self
    {
        $this->description = $description;

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

    public function getSupplierCategory(): ?SupplierCategoryEntity
    {
        return $this->supplierCategory;
    }

    public function setSupplierCategory(?SupplierCategoryEntity $supplierCategory): self
    {
        $this->supplierCategory = $supplierCategory;

        return $this;
    }

    public function getStoreOwnerProfile(): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfile;
    }

    public function setStoreOwnerProfile(?StoreOwnerProfileEntity $storeOwnerProfile): self
    {
        $this->storeOwnerProfile = $storeOwnerProfile;

        return $this;
    }

    /**
     * @return Collection|ImageEntity[]
     */
    public function getImages(): Collection
    {
        return $this->images;
    }

    public function addImage(ImageEntity $image): self
    {
        if (!$this->images->contains($image)) {
            $this->images[] = $image;
            $image->setBidOrder($this);
        }

        return $this;
    }

    public function removeImage(ImageEntity $image): self
    {
        if ($this->images->removeElement($image)) {
            // set the owning side to null (unless already changed)
            if ($image->getBidOrder() === $this) {
                $image->setBidOrder(null);
            }
        }

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
            $priceOfferEntity->setBidOrder($this);
        }

        return $this;
    }

    public function removePriceOfferEntity(PriceOfferEntity $priceOfferEntity): self
    {
        if ($this->priceOfferEntities->removeElement($priceOfferEntity)) {
            // set the owning side to null (unless already changed)
            if ($priceOfferEntity->getBidOrder() === $this) {
                $priceOfferEntity->setBidOrder(null);
            }
        }

        return $this;
    }

    public function getOpenToPriceOffer(): ?bool
    {
        return $this->openToPriceOffer;
    }

    public function setOpenToPriceOffer(bool $openToPriceOffer): self
    {
        $this->openToPriceOffer = $openToPriceOffer;

        return $this;
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
}
