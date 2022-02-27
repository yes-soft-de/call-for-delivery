<?php

namespace App\Entity;

use App\Repository\PackageCategoryEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

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
}
