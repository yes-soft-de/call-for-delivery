<?php

namespace App\Entity;

use App\Constant\CaptainFinancialSystem\CaptainFinancialDefaultSystem\CaptainFinancialDefaultSystemConstant;
use App\Repository\CaptainFinancialDefaultSystemEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: CaptainFinancialDefaultSystemEntityRepository::class)]
class CaptainFinancialDefaultSystemEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'float')]
    private $openingOrderCost;

    #[ORM\Column(type: 'float', nullable: true)]
    private $distanceLimit;

    #[ORM\Column(type: 'float')]
    private $firstOneKilometerCost;

    #[ORM\Column(type: 'float', nullable: true)]
    private $secondOneKilometerCost;

    #[ORM\Column(type: 'boolean', options: ["default" => CaptainFinancialDefaultSystemConstant::CAPTAIN_FINANCIAL_DEFAULT_SYSTEM_STATUS_FALSE_CONST])]
    private $status;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    #[ORM\ManyToOne(targetEntity: AdminProfileEntity::class, inversedBy: 'captainFinancialDefaultSystemEntities')]
    private $updatedBy;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getOpeningOrderCost(): ?float
    {
        return $this->openingOrderCost;
    }

    public function setOpeningOrderCost(float $openingOrderCost): self
    {
        $this->openingOrderCost = $openingOrderCost;

        return $this;
    }

    public function getDistanceLimit(): ?float
    {
        return $this->distanceLimit;
    }

    public function setDistanceLimit(?float $distanceLimit): self
    {
        $this->distanceLimit = $distanceLimit;

        return $this;
    }

    public function getFirstOneKilometerCost(): ?float
    {
        return $this->firstOneKilometerCost;
    }

    public function setFirstOneKilometerCost(float $firstOneKilometerCost): self
    {
        $this->firstOneKilometerCost = $firstOneKilometerCost;

        return $this;
    }

    public function getSecondOneKilometerCost(): ?float
    {
        return $this->secondOneKilometerCost;
    }

    public function setSecondOneKilometerCost(?float $secondOneKilometerCost): self
    {
        $this->secondOneKilometerCost = $secondOneKilometerCost;

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

    public function getUpdatedBy(): ?AdminProfileEntity
    {
        return $this->updatedBy;
    }

    public function setUpdatedBy(?AdminProfileEntity $updatedBy): self
    {
        $this->updatedBy = $updatedBy;

        return $this;
    }
}
