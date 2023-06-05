<?php

namespace App\Entity;

use App\Repository\ExternalDeliveryCompanyCriteriaEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: ExternalDeliveryCompanyCriteriaEntityRepository::class)]
class ExternalDeliveryCompanyCriteriaEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'boolean', options: ["default" => false])]
    private $isSpecificDate;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $fromDate;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $toDate;

    // 205: off. 206: storeBranchToClientDistance
    #[ORM\Column(type: 'smallint', options: ["default" => 205])]
    private $isDistance;

    #[ORM\Column(type: 'float', nullable: true)]
    private $fromDistance;

    #[ORM\Column(type: 'float', nullable: true)]
    private $toDistance;

    // 207: off. 208: card. 209: cash. 210: both
    #[ORM\Column(type: 'smallint', options: ["default" => 207])]
    private $payment;

    #[ORM\Column(type: 'boolean', options: ["default" => false])]
    private $isFromAllStores;

    #[ORM\Column(type: 'array', nullable: true)]
    private $fromStoresBranches = [];

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    #[ORM\ManyToOne(targetEntity: AdminProfileEntity::class, inversedBy: 'externalDeliveryCompanyCriteriaEntities')]
    private $updatedBy;

    #[ORM\ManyToOne(targetEntity: ExternalDeliveryCompanyEntity::class, inversedBy: 'externalDeliveryCompanyCriteriaEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $externalDeliveryCompany;

    #[ORM\Column(type: 'string', length: 100)]
    private $criteriaName;

    #[ORM\Column(type: 'boolean', options: ["default" => false])]
    private $status;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getIsSpecificDate(): ?bool
    {
        return $this->isSpecificDate;
    }

    public function setIsSpecificDate(bool $isSpecificDate): self
    {
        $this->isSpecificDate = $isSpecificDate;

        return $this;
    }

    public function getFromDate(): ?\DateTimeInterface
    {
        return $this->fromDate;
    }

    public function setFromDate(?\DateTimeInterface $fromDate): self
    {
        $this->fromDate = $fromDate;

        return $this;
    }

    public function getToDate(): ?\DateTimeInterface
    {
        return $this->toDate;
    }

    public function setToDate(?\DateTimeInterface $toDate): self
    {
        $this->toDate = $toDate;

        return $this;
    }

    public function getIsDistance(): ?int
    {
        return $this->isDistance;
    }

    public function setIsDistance(int $isDistance): self
    {
        $this->isDistance = $isDistance;

        return $this;
    }

    public function getFromDistance(): ?float
    {
        return $this->fromDistance;
    }

    public function setFromDistance(?float $fromDistance): self
    {
        $this->fromDistance = $fromDistance;

        return $this;
    }

    public function getToDistance(): ?float
    {
        return $this->toDistance;
    }

    public function setToDistance(?float $toDistance): self
    {
        $this->toDistance = $toDistance;

        return $this;
    }

    public function getPayment(): ?int
    {
        return $this->payment;
    }

    public function setPayment(int $payment): self
    {
        $this->payment = $payment;

        return $this;
    }

    public function getIsFromAllStores(): ?bool
    {
        return $this->isFromAllStores;
    }

    public function setIsFromAllStores(bool $isFromAllStores): self
    {
        $this->isFromAllStores = $isFromAllStores;

        return $this;
    }

    public function getFromStoresBranches(): ?array
    {
        return $this->fromStoresBranches;
    }

    public function setFromStoresBranches(?array $fromStoresBranches): self
    {
        $this->fromStoresBranches = $fromStoresBranches;

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

    public function getUpdatedBy(): ?AdminProfileEntity
    {
        return $this->updatedBy;
    }

    public function setUpdatedBy(?AdminProfileEntity $updatedBy): self
    {
        $this->updatedBy = $updatedBy;

        return $this;
    }

    public function getExternalDeliveryCompany(): ?ExternalDeliveryCompanyEntity
    {
        return $this->externalDeliveryCompany;
    }

    public function setExternalDeliveryCompany(?ExternalDeliveryCompanyEntity $externalDeliveryCompany): self
    {
        $this->externalDeliveryCompany = $externalDeliveryCompany;

        return $this;
    }

    public function getCriteriaName(): ?string
    {
        return $this->criteriaName;
    }

    public function setCriteriaName(string $criteriaName): self
    {
        $this->criteriaName = $criteriaName;

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
