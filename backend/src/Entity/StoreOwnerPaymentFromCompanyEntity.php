<?php

namespace App\Entity;

use App\Repository\StoreOwnerPaymentFromCompanyEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: StoreOwnerPaymentFromCompanyEntityRepository::class)]
class StoreOwnerPaymentFromCompanyEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'float')]
    private $amount;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'storeOwnerPaymentFromCompanyEntity')]
    #[ORM\JoinColumn(nullable: false)]
    private $store;

    #[ORM\Column(type: 'text', nullable: true)]
    private $note;

    #[ORM\OneToMany(mappedBy: 'storeOwnerPaymentFromCompany', targetEntity: StoreOwnerDuesFromCashOrdersEntity::class)]
    private $storeOwnerDuesFromCashOrdersEntities;

    public function __construct()
    {
        $this->storeOwnerDuesFromCashOrdersEntities = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getAmount(): ?float
    {
        return $this->amount;
    }

    public function setAmount(float $amount): self
    {
        $this->amount = $amount;

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

    public function getStore(): ?StoreOwnerProfileEntity
    {
        return $this->store;
    }

    public function setStore(?StoreOwnerProfileEntity $store): self
    {
        $this->store = $store;

        return $this;
    }

    public function getNote(): ?string
    {
        return $this->note;
    }

    public function setNote(?string $note): self
    {
        $this->note = $note;

        return $this;
    }

    /**
     * @return Collection<int, StoreOwnerDuesFromCashOrdersEntity>
     */
    public function getStoreOwnerDuesFromCashOrdersEntities(): Collection
    {
        return $this->storeOwnerDuesFromCashOrdersEntities;
    }

    public function addStoreOwnerDuesFromCashOrdersEntity(StoreOwnerDuesFromCashOrdersEntity $storeOwnerDuesFromCashOrdersEntity): self
    {
        if (!$this->storeOwnerDuesFromCashOrdersEntities->contains($storeOwnerDuesFromCashOrdersEntity)) {
            $this->storeOwnerDuesFromCashOrdersEntities[] = $storeOwnerDuesFromCashOrdersEntity;
            $storeOwnerDuesFromCashOrdersEntity->setStoreOwnerPaymentFromCompany($this);
        }

        return $this;
    }

    public function removeStoreOwnerDuesFromCashOrdersEntity(StoreOwnerDuesFromCashOrdersEntity $storeOwnerDuesFromCashOrdersEntity): self
    {
        if ($this->storeOwnerDuesFromCashOrdersEntities->removeElement($storeOwnerDuesFromCashOrdersEntity)) {
            // set the owning side to null (unless already changed)
            if ($storeOwnerDuesFromCashOrdersEntity->getStoreOwnerPaymentFromCompany() === $this) {
                $storeOwnerDuesFromCashOrdersEntity->setStoreOwnerPaymentFromCompany(null);
            }
        }

        return $this;
    }
}
