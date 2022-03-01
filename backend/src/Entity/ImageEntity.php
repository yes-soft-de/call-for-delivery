<?php

namespace App\Entity;

use App\Repository\ImageEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ImageEntityRepository::class)]
class ImageEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 255)]
    private $imagePath;

    #[ORM\Column(type: 'string', length: 255)]
    private $entityType;

    #[ORM\Column(type: 'string', length: 255)]
    private $imageAim;

    #[ORM\Column(type: 'integer')]
    private $itemId;

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

    public function getEntityType(): ?string
    {
        return $this->entityType;
    }

    public function setEntityType(string $entityType): self
    {
        $this->entityType = $entityType;

        return $this;
    }

    public function getImageAim(): ?string
    {
        return $this->imageAim;
    }

    public function setImageAim(string $imageAim): self
    {
        $this->imageAim = $imageAim;

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
}
