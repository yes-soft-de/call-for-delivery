<?php

namespace App\Entity;

use App\Repository\CaptainFinancialDemandEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: CaptainFinancialDemandEntityRepository::class)]
class CaptainFinancialDemandEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\ManyToOne(targetEntity: CaptainEntity::class, inversedBy: 'captainFinancialDemands')]
    #[ORM\JoinColumn(nullable: false)]
    private $captain;

    #[ORM\ManyToOne(targetEntity: CaptainFinancialDuesEntity::class, inversedBy: 'captainFinancialDemands')]
    #[ORM\JoinColumn(nullable: false)]
    private $captainFinancialDueId;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCaptain(): ?CaptainEntity
    {
        return $this->captain;
    }

    public function setCaptain(?CaptainEntity $captain): self
    {
        $this->captain = $captain;

        return $this;
    }

    public function getCaptainFinancialDueId(): ?CaptainFinancialDuesEntity
    {
        return $this->captainFinancialDueId;
    }

    public function setCaptainFinancialDueId(?CaptainFinancialDuesEntity $captainFinancialDueId): self
    {
        $this->captainFinancialDueId = $captainFinancialDueId;

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
}
