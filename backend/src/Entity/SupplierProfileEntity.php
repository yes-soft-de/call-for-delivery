<?php

namespace App\Entity;

use App\Constant\Supplier\SupplierProfileConstant;
use App\Repository\SupplierProfileEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: SupplierProfileEntityRepository::class)]
class SupplierProfileEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\OneToOne(targetEntity: UserEntity::class, cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private $user;

    #[ORM\Column(type: 'string', length: 255)]
    private $supplierName;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $phone;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\OneToMany(mappedBy: 'supplierProfile', targetEntity: ImageEntity::class)]
    private $images;

    #[ORM\Column(type: 'boolean')]
    private $status = false;

    #[ORM\OneToMany(mappedBy: 'supplier', targetEntity: AnnouncementEntity::class)]
    private $announcementEntities;

    #[ORM\Column(type: 'string', length: 20)]
    private $completeAccountStatus = SupplierProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED;

    #[ORM\Column(type: 'json', nullable: true)]
    private $location = [];

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $bankName;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $bankAccountNumber;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $stcPay;

    #[ORM\Column(type: 'json', nullable: true)]
    private $supplierCategories = [];

    #[ORM\Column(type: 'float', nullable: true)]
    private $profitMargin;

    #[ORM\OneToMany(mappedBy: 'supplierProfile', targetEntity: BidDetailsEntity::class)]
    private $bidDetailsEntities;

    #[ORM\OneToMany(mappedBy: 'supplierProfile', targetEntity: OrderLogEntity::class)]
    private $orderLogEntities;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime', nullable: true)]
    private $updatedAt;

    public function __construct()
    {
        $this->images = new ArrayCollection();
        $this->announcementEntities = new ArrayCollection();
        $this->bidDetailsEntities = new ArrayCollection();
        $this->orderLogEntities = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUser(): ?UserEntity
    {
        return $this->user;
    }

    public function setUser(UserEntity $user): self
    {
        $this->user = $user;

        return $this;
    }

    public function getSupplierName(): ?string
    {
        return $this->supplierName;
    }

    public function setSupplierName(string $supplierName): self
    {
        $this->supplierName = $supplierName;

        return $this;
    }

    public function getPhone(): ?string
    {
        return $this->phone;
    }

    public function setPhone(?string $phone): self
    {
        $this->phone = $phone;

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

    /**
     * @return Collection|ImageEntity[]
     */
    public function getImages(): Collection
    {
        return $this->images;
    }

    public function addImageEntity(ImageEntity $imageEntity): self
    {
        if (!$this->images->contains($imageEntity)) {
            $this->images[] = $imageEntity;
            $imageEntity->setSupplierProfile($this);
        }

        return $this;
    }

    public function removeImageEntity(ImageEntity $imageEntity): self
    {
        if ($this->images->removeElement($imageEntity)) {
            // set the owning side to null (unless already changed)
            if ($imageEntity->getSupplierProfile() === $this) {
                $imageEntity->setSupplierProfile(null);
            }
        }

        return $this;
    }

    public function getStatus(): ?bool
    {
        return $this->status;
    }

    public function setStatus(bool $status): self
    {
        $this->status = $status;

        return $this;
    }

    /**
     * @return Collection|AnnouncementEntity[]
     */
    public function getAnnouncementEntities(): Collection
    {
        return $this->announcementEntities;
    }

    public function addAnnouncementEntity(AnnouncementEntity $announcementEntity): self
    {
        if (!$this->announcementEntities->contains($announcementEntity)) {
            $this->announcementEntities[] = $announcementEntity;
            $announcementEntity->setSupplier($this);
        }

        return $this;
    }

    public function removeAnnouncementEntity(AnnouncementEntity $announcementEntity): self
    {
        if ($this->announcementEntities->removeElement($announcementEntity)) {
            // set the owning side to null (unless already changed)
            if ($announcementEntity->getSupplier() === $this) {
                $announcementEntity->setSupplier(null);
            }
        }

        return $this;
    }

    public function getCompleteAccountStatus(): ?string
    {
        return $this->completeAccountStatus;
    }

    public function setCompleteAccountStatus(string $completeAccountStatus): self
    {
        $this->completeAccountStatus = $completeAccountStatus;

        return $this;
    }

    public function getLocation(): ?array
    {
        return $this->location;
    }

    public function setLocation(?array $location): self
    {
        $this->location = $location;

        return $this;
    }

    public function getBankName(): ?string
    {
        return $this->bankName;
    }

    public function setBankName(?string $bankName): self
    {
        $this->bankName = $bankName;

        return $this;
    }

    public function getBankAccountNumber(): ?string
    {
        return $this->bankAccountNumber;
    }

    public function setBankAccountNumber(?string $bankAccountNumber): self
    {
        $this->bankAccountNumber = $bankAccountNumber;

        return $this;
    }

    public function getStcPay(): ?string
    {
        return $this->stcPay;
    }

    public function setStcPay(?string $stcPay): self
    {
        $this->stcPay = $stcPay;

        return $this;
    }

    public function getSupplierCategories(): ?array
    {
        return $this->supplierCategories;
    }

    public function setSupplierCategories(?array $supplierCategories): self
    {
        $this->supplierCategories = $supplierCategories;

        return $this;
    }

    public function getProfitMargin(): ?float
    {
        return $this->profitMargin;
    }

    public function setProfitMargin(?float $profitMargin): self
    {
        $this->profitMargin = $profitMargin;

        return $this;
    }

    /**
     * @return Collection|BidDetailsEntity[]
     */
    public function getBidDetailsEntities(): Collection
    {
        return $this->bidDetailsEntities;
    }

    public function addBidDetailsEntity(BidDetailsEntity $bidDetailsEntity): self
    {
        if (!$this->bidDetailsEntities->contains($bidDetailsEntity)) {
            $this->bidDetailsEntities[] = $bidDetailsEntity;
            $bidDetailsEntity->setSupplierProfile($this);
        }

        return $this;
    }

    public function removeBidDetailsEntity(BidDetailsEntity $bidDetailsEntity): self
    {
        if ($this->bidDetailsEntities->removeElement($bidDetailsEntity)) {
            // set the owning side to null (unless already changed)
            if ($bidDetailsEntity->getSupplierProfile() === $this) {
                $bidDetailsEntity->setSupplierProfile(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, OrderLogEntity>
     */
    public function getOrderLogEntities(): Collection
    {
        return $this->orderLogEntities;
    }

    public function addOrderLogEntity(OrderLogEntity $orderLogEntity): self
    {
        if (!$this->orderLogEntities->contains($orderLogEntity)) {
            $this->orderLogEntities[] = $orderLogEntity;
            $orderLogEntity->setSupplierProfile($this);
        }

        return $this;
    }

    public function removeOrderLogEntity(OrderLogEntity $orderLogEntity): self
    {
        if ($this->orderLogEntities->removeElement($orderLogEntity)) {
            // set the owning side to null (unless already changed)
            if ($orderLogEntity->getSupplierProfile() === $this) {
                $orderLogEntity->setSupplierProfile(null);
            }
        }

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
}
