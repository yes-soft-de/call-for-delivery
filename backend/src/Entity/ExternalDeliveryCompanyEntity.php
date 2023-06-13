<?php

namespace App\Entity;

use App\Repository\ExternalDeliveryCompanyEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: ExternalDeliveryCompanyEntityRepository::class)]
class ExternalDeliveryCompanyEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 255)]
    private $companyName;

    #[ORM\Column(type: 'boolean', options: ["default" => false])]
    private $status;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    #[ORM\OneToMany(mappedBy: 'externalDeliveryCompany', targetEntity: ExternalDeliveryCompanyCriteriaEntity::class)]
    private $externalDeliveryCompanyCriteriaEntities;

    #[ORM\OneToMany(mappedBy: 'externalDeliveryCompany', targetEntity: ExternallyDeliveredOrderEntity::class)]
    private $externallyDeliveredOrderEntities;

    public function __construct()
    {
        $this->externalDeliveryCompanyCriteriaEntities = new ArrayCollection();
        $this->externallyDeliveredOrderEntities = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCompanyName(): ?string
    {
        return $this->companyName;
    }

    public function setCompanyName(string $companyName): self
    {
        $this->companyName = $companyName;

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

    /**
     * @return Collection<int, ExternalDeliveryCompanyCriteriaEntity>
     */
    public function getExternalDeliveryCompanyCriteriaEntities(): Collection
    {
        return $this->externalDeliveryCompanyCriteriaEntities;
    }

    public function addExternalDeliveryCompanyCriteriaEntity(ExternalDeliveryCompanyCriteriaEntity $externalDeliveryCompanyCriteriaEntity): self
    {
        if (!$this->externalDeliveryCompanyCriteriaEntities->contains($externalDeliveryCompanyCriteriaEntity)) {
            $this->externalDeliveryCompanyCriteriaEntities[] = $externalDeliveryCompanyCriteriaEntity;
            $externalDeliveryCompanyCriteriaEntity->setExternalDeliveryCompany($this);
        }

        return $this;
    }

    public function removeExternalDeliveryCompanyCriteriaEntity(ExternalDeliveryCompanyCriteriaEntity $externalDeliveryCompanyCriteriaEntity): self
    {
        if ($this->externalDeliveryCompanyCriteriaEntities->removeElement($externalDeliveryCompanyCriteriaEntity)) {
            // set the owning side to null (unless already changed)
            if ($externalDeliveryCompanyCriteriaEntity->getExternalDeliveryCompany() === $this) {
                $externalDeliveryCompanyCriteriaEntity->setExternalDeliveryCompany(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, ExternallyDeliveredOrderEntity>
     */
    public function getExternallyDeliveredOrderEntities(): Collection
    {
        return $this->externallyDeliveredOrderEntities;
    }

    public function addExternallyDeliveredOrderEntity(ExternallyDeliveredOrderEntity $externallyDeliveredOrderEntity): self
    {
        if (!$this->externallyDeliveredOrderEntities->contains($externallyDeliveredOrderEntity)) {
            $this->externallyDeliveredOrderEntities[] = $externallyDeliveredOrderEntity;
            $externallyDeliveredOrderEntity->setExternalDeliveryCompany($this);
        }

        return $this;
    }

    public function removeExternallyDeliveredOrderEntity(ExternallyDeliveredOrderEntity $externallyDeliveredOrderEntity): self
    {
        if ($this->externallyDeliveredOrderEntities->removeElement($externallyDeliveredOrderEntity)) {
            // set the owning side to null (unless already changed)
            if ($externallyDeliveredOrderEntity->getExternalDeliveryCompany() === $this) {
                $externallyDeliveredOrderEntity->setExternalDeliveryCompany(null);
            }
        }

        return $this;
    }
}
