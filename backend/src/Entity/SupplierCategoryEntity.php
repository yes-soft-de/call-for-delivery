<?php

namespace App\Entity;

use App\Repository\SupplierCategoryEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: SupplierCategoryEntityRepository::class)]
class SupplierCategoryEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 255)]
    private $name;

    #[ORM\Column(type: 'text', nullable: true)]
    private $description;

    #[ORM\Column(type: 'boolean')]
    private $status = false;

    #[ORM\OneToMany(mappedBy: 'supplierCategory', targetEntity: SupplierProfileEntity::class)]
    private $supplierProfileEntities;

    public function __construct()
    {
        $this->supplierProfileEntities = new ArrayCollection();
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
     * @return Collection|SupplierProfileEntity[]
     */
    public function getSupplierProfileEntities(): Collection
    {
        return $this->supplierProfileEntities;
    }

    public function addSupplierProfileEntity(SupplierProfileEntity $supplierProfileEntity): self
    {
        if (!$this->supplierProfileEntities->contains($supplierProfileEntity)) {
            $this->supplierProfileEntities[] = $supplierProfileEntity;
            $supplierProfileEntity->setSupplierCategory($this);
        }

        return $this;
    }

    public function removeSupplierProfileEntity(SupplierProfileEntity $supplierProfileEntity): self
    {
        if ($this->supplierProfileEntities->removeElement($supplierProfileEntity)) {
            // set the owning side to null (unless already changed)
            if ($supplierProfileEntity->getSupplierCategory() === $this) {
                $supplierProfileEntity->setSupplierCategory(null);
            }
        }

        return $this;
    }
}
