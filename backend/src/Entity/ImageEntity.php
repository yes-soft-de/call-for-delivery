<?php

namespace App\Entity;

use App\Repository\ImageEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: ImageEntityRepository::class)]
class ImageEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 255)]
    private $imagePath;

    #[ORM\Column(type: 'integer')]
    private $entityType;

    #[ORM\Column(type: 'integer')]
    private $itemId;

    #[ORM\Column(type: 'integer')]
    private $usedAs;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    #[ORM\ManyToOne(targetEntity: AdminProfileEntity::class, inversedBy: 'images')]
    #[ORM\JoinColumn(nullable: true)]
    private $user;

    #[ORM\ManyToOne(targetEntity: SupplierProfileEntity::class, inversedBy: 'imageEntities')]
    private $supplierProfile;

    #[ORM\ManyToOne(targetEntity: AnnouncementEntity::class, inversedBy: 'images')]
    private $announcement;

    #[ORM\ManyToOne(targetEntity: BidDetailsEntity::class, inversedBy: 'images')]
    private $bidDetails;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getImagePath(): ?string
    {
        return $this->imagePath;
    }

    public function setImagePath(string $imagePath): self
    {
        $this->imagePath = $imagePath;

        return $this;
    }

    public function getEntityType(): ?int
    {
        return $this->entityType;
    }

    public function setEntityType(int $entityType): self
    {
        $this->entityType = $entityType;

        return $this;
    }

    public function getItemId(): ?int
    {
        return $this->itemId;
    }

    public function setItemId(int $itemId): self
    {
        $this->itemId = $itemId;

        return $this;
    }

    public function getUsedAs(): ?int
    {
        return $this->usedAs;
    }

    public function setUsedAs(int $usedAs): self
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

    public function getUpdatedAt(): ?\DateTimeInterface
    {
        return $this->updatedAt;
    }

    public function setUpdatedAt(\DateTimeInterface $updatedAt): self
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    public function getUser(): ?AdminProfileEntity
    {
        return $this->user;
    }

    public function setUser(?AdminProfileEntity $user): self
    {
        $this->user = $user;

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

    public function getAnnouncement(): ?AnnouncementEntity
    {
        return $this->announcement;
    }

    public function setAnnouncement(?AnnouncementEntity $announcement): self
    {
        $this->announcement = $announcement;

        return $this;
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
}
