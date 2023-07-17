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

    #[ORM\Column(type: 'float', nullable: true)]
    private $firstSliceLimit;

    #[ORM\Column(type: 'float', nullable: true)]
    private $firstSliceCost;

    #[ORM\Column(type: 'float', nullable: true)]
    private $secondSliceFromLimit;

    #[ORM\Column(type: 'float', nullable: true)]
    private $secondSliceToLimit;

    #[ORM\Column(type: 'float', nullable: true)]
    private $secondSliceOneKilometerCost;

    #[ORM\Column(type: 'float', nullable: true)]
    private $thirdSliceFromLimit;

    #[ORM\Column(type: 'float', nullable: true)]
    private $thirdSliceToLimit;

    #[ORM\Column(type: 'float', nullable: true)]
    private $thirdSliceOneKilometerCost;

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

    public function getFirstSliceLimit(): ?float
    {
        return $this->firstSliceLimit;
    }

    public function setFirstSliceLimit(?float $firstSliceLimit): self
    {
        $this->firstSliceLimit = $firstSliceLimit;

        return $this;
    }

    public function getFirstSliceCost(): ?float
    {
        return $this->firstSliceCost;
    }

    public function setFirstSliceCost(?float $firstSliceCost): self
    {
        $this->firstSliceCost = $firstSliceCost;

        return $this;
    }

    public function getSecondSliceFromLimit(): ?float
    {
        return $this->secondSliceFromLimit;
    }

    public function setSecondSliceFromLimit(?float $secondSliceFromLimit): self
    {
        $this->secondSliceFromLimit = $secondSliceFromLimit;

        return $this;
    }

    public function getSecondSliceToLimit(): ?float
    {
        return $this->secondSliceToLimit;
    }

    public function setSecondSliceToLimit(?float $secondSliceToLimit): self
    {
        $this->secondSliceToLimit = $secondSliceToLimit;

        return $this;
    }

    public function getSecondSliceOneKilometerCost(): ?float
    {
        return $this->secondSliceOneKilometerCost;
    }

    public function setSecondSliceOneKilometerCost(?float $secondSliceOneKilometerCost): self
    {
        $this->secondSliceOneKilometerCost = $secondSliceOneKilometerCost;

        return $this;
    }

    public function getThirdSliceFromLimit(): ?float
    {
        return $this->thirdSliceFromLimit;
    }

    public function setThirdSliceFromLimit(?float $thirdSliceFromLimit): self
    {
        $this->thirdSliceFromLimit = $thirdSliceFromLimit;

        return $this;
    }

    public function getThirdSliceToLimit(): ?float
    {
        return $this->thirdSliceToLimit;
    }

    public function setThirdSliceToLimit(?float $thirdSliceToLimit): self
    {
        $this->thirdSliceToLimit = $thirdSliceToLimit;

        return $this;
    }

    public function getThirdSliceOneKilometerCost(): ?float
    {
        return $this->thirdSliceOneKilometerCost;
    }

    public function setThirdSliceOneKilometerCost(?float $thirdSliceOneKilometerCost): self
    {
        $this->thirdSliceOneKilometerCost = $thirdSliceOneKilometerCost;

        return $this;
    }
}
