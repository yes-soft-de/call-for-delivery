<?php

namespace App\Entity;

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

    #[ORM\OneToOne(targetEntity: SupplierCategoryEntity::class, cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: true)]
    private $supplierCategory;

    #[ORM\OneToMany(mappedBy: 'supplierProfile', targetEntity: ImageEntity::class)]
    private $images;

    #[ORM\Column(type: 'boolean')]
    private $status = false;

    public function __construct()
    {
        $this->images = new ArrayCollection();
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

    public function getSupplierCategory(): ?SupplierCategoryEntity
    {
        return $this->supplierCategory;
    }

    public function setSupplierCategory(?SupplierCategoryEntity $supplierCategory): self
    {
        $this->supplierCategory = $supplierCategory;

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
}
