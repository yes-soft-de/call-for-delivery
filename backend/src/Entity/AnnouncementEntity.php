<?php

namespace App\Entity;

use App\Repository\AnnouncementEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: AnnouncementEntityRepository::class)]
class AnnouncementEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'float')]
    private $price;

    #[ORM\Column(type: 'text', nullable: true)]
    private $details;

    #[ORM\Column(type: 'integer')]
    private $quantity;

    #[ORM\Column(type: 'boolean')]
    private $status;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    #[ORM\ManyToOne(targetEntity: SupplierProfileEntity::class, inversedBy: 'announcementEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $supplier;

    #[ORM\OneToMany(mappedBy: 'announcement', targetEntity: ImageEntity::class)]
    private $images;

    #[ORM\Column(type: 'boolean')]
    private $administrationStatus = true;

    public function __construct()
    {
        $this->images = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getPrice(): ?float
    {
        return $this->price;
    }

    public function setPrice(float $price): self
    {
        $this->price = $price;

        return $this;
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

    public function getQuantity(): ?int
    {
        return $this->quantity;
    }

    public function setQuantity(int $quantity): self
    {
        $this->quantity = $quantity;

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

    public function getSupplier(): ?SupplierProfileEntity
    {
        return $this->supplier;
    }

    public function setSupplier(?SupplierProfileEntity $supplier): self
    {
        $this->supplier = $supplier;

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
            $image->setAnnouncement($this);
        }

        return $this;
    }

    public function removeImage(ImageEntity $image): self
    {
        if ($this->images->removeElement($image)) {
            // set the owning side to null (unless already changed)
            if ($image->getAnnouncement() === $this) {
                $image->setAnnouncement(null);
            }
        }

        return $this;
    }

    public function getAdministrationStatus(): ?bool
    {
        return $this->administrationStatus;
    }

    public function setAdministrationStatus(bool $administrationStatus): self
    {
        $this->administrationStatus = $administrationStatus;

        return $this;
    }
}
