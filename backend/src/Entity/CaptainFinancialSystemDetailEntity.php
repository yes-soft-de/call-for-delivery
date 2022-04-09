<?php

namespace App\Entity;

use App\Repository\CaptainFinancialSystemDetailEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: CaptainFinancialSystemDetailEntityRepository::class)]
class CaptainFinancialSystemDetailEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'integer')]
    private $captainFinancialSystemType;

    #[ORM\Column(type: 'integer')]
    private $captainFinancialSystemId;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\ManyToOne(targetEntity: CaptainEntity::class, inversedBy: 'captainFinancialSystemDetailEntity')]
    private $captain;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $updatedBy;

    #[ORM\Column(type: 'boolean')]
    private $status;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCaptainFinancialSystemType(): ?int
    {
        return $this->captainFinancialSystemType;
    }

    public function setCaptainFinancialSystemType(int $captainFinancialSystemType): self
    {
        $this->captainFinancialSystemType = $captainFinancialSystemType;

        return $this;
    }

    public function getCaptainFinancialSystemId(): ?int
    {
        return $this->captainFinancialSystemId;
    }

    public function setCaptainFinancialSystemId(int $captainFinancialSystemId): self
    {
        $this->captainFinancialSystemId = $captainFinancialSystemId;

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

    public function getCaptain(): ?CaptainEntity
    {
        return $this->captain;
    }

    public function setCaptain(?CaptainEntity $captain): self
    {
        $this->captain = $captain;

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

    public function getUpdatedBy(): ?int
    {
        return $this->updatedBy;
    }

    public function setUpdatedBy(?int $updatedBy): self
    {
        $this->updatedBy = $updatedBy;

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
