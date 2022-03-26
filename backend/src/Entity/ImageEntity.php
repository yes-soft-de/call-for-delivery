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

    #[ORM\OneToOne(mappedBy: 'image', targetEntity: AdminProfileEntity::class, cascade: ['persist', 'remove'])]
    private $adminProfileEntity;

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

    public function getAdminProfileEntity(): ?AdminProfileEntity
    {
        return $this->adminProfileEntity;
    }

    public function setAdminProfileEntity(?AdminProfileEntity $adminProfileEntity): self
    {
        // unset the owning side of the relation if necessary
        if ($adminProfileEntity === null && $this->adminProfileEntity !== null) {
            $this->adminProfileEntity->setImage(null);
        }

        // set the owning side of the relation if necessary
        if ($adminProfileEntity !== null && $adminProfileEntity->getImage() !== $this) {
            $adminProfileEntity->setImage($this);
        }

        $this->adminProfileEntity = $adminProfileEntity;

        return $this;
    }
}
