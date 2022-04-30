<?php

namespace App\Entity;

use App\Repository\BidDetailsEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: BidDetailsEntityRepository::class)]
class BidDetailsEntity
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

    #[ORM\OneToMany(mappedBy: 'bidDetails', targetEntity: ImageEntity::class)]
    private $images;

    #[ORM\OneToMany(mappedBy: 'bidDetails', targetEntity: PriceOfferEntity::class)]
    private $priceOfferEntities;

    #[ORM\Column(type: 'boolean')]
    private $openToPriceOffer = true;

    #[ORM\OneToOne(targetEntity: OrderEntity::class, cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private $orderId;

    #[ORM\Column(type: 'json', nullable: true)]
    private $sourceDestination = [];

    #[ORM\ManyToOne(targetEntity: StoreOwnerBranchEntity::class, inversedBy: 'bidDetailsEntities')]
    private $branch;

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
            $image->setBidDetails($this);
        }

        return $this;
    }

    public function removeImage(ImageEntity $image): self
    {
        if ($this->images->removeElement($image)) {
            // set the owning side to null (unless already changed)
            if ($image->getBidDetails() === $this) {
                $image->setBidDetails(null);
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
            $priceOfferEntity->setBidDetails($this);
        }

        return $this;
    }

    public function removePriceOfferEntity(PriceOfferEntity $priceOfferEntity): self
    {
        if ($this->priceOfferEntities->removeElement($priceOfferEntity)) {
            // set the owning side to null (unless already changed)
            if ($priceOfferEntity->getBidDetails() === $this) {
                $priceOfferEntity->setBidDetails(null);
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

    public function getSourceDestination(): ?array
    {
        return $this->sourceDestination;
    }

    public function setSourceDestination(?array $sourceDestination): self
    {
        $this->sourceDestination = $sourceDestination;

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
}
