<?php

namespace App\Entity;

use App\Repository\PackageCategoryEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: PackageCategoryEntityRepository::class)]
class PackageCategoryEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 255)]
    private $name;

    #[ORM\Column(type: 'text', nullable: true)]
    private $description;

    #[ORM\OneToMany(mappedBy: 'packageCategory', targetEntity: PackageEntity::class)]
    private $packageEntities;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $status;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime', nullable: true)]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime', nullable: true)]
    private $updatedAt;

    public function __construct()
    {
        $this->packageEntities = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

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

    /**
     * @return Collection|PackageEntity[]
     */
    public function getPackageEntities(): Collection
    {
        return $this->packageEntities;
    }

    public function addPackageEntity(PackageEntity $packageEntity): self
    {
        if (!$this->packageEntities->contains($packageEntity)) {
            $this->packageEntities[] = $packageEntity;
            $packageEntity->setPackageCategory($this);
        }

        return $this;
    }

    public function removePackageEntity(PackageEntity $packageEntity): self
    {
        if ($this->packageEntities->removeElement($packageEntity)) {
            // set the owning side to null (unless already changed)
            if ($packageEntity->getPackageCategory() === $this) {
                $packageEntity->setPackageCategory(null);
            }
        }

        return $this;
    }

    public function getStatus(): ?int
    {
        return $this->status;
    }

    public function setStatus(?int $status): self
    {
        $this->status = $status;

        return $this;
    }

    public function getCreatedAt(): ?\DateTimeInterface
    {
        return $this->createdAt;
    }

    public function setCreatedAt(?\DateTimeInterface $createdAt): self
    {
        $this->createdAt = $createdAt;

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
