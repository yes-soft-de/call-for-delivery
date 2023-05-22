<?php

namespace App\Entity;

use App\Constant\OrderDistanceConflict\OrderDistanceConflictIsResolvedConstant;
use App\Repository\OrderDistanceConflictEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: OrderDistanceConflictEntityRepository::class)]
class OrderDistanceConflictEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\OneToOne(inversedBy: 'orderDistanceConflictEntity', targetEntity: OrderEntity::class, cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private $orderId;

    #[ORM\Column(type: 'integer')]
    private $conflictIssuedBy;

    #[ORM\Column(type: 'smallint')]
    private $conflictIssuedByUserType;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $conflictResolvedBy;

    #[ORM\Column(type: 'smallint', nullable: true)]
    private $conflictResolvedByUserType;

    #[ORM\Column(type: 'boolean')]
    private $isResolved = OrderDistanceConflictIsResolvedConstant::ORDER_DISTANCE_CONFLICT_NOT_RESOLVED_CONST;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private $resolvedAt;

    #[ORM\Column(type: 'text')]
    private $conflictNote;

    #[ORM\Column(type: 'text', nullable: true)]
    private $adminNote;

    #[ORM\Column(type: 'float', nullable: true)]
    private $oldDistance;

    #[ORM\Column(type: 'float', nullable: true)]
    private $newDistance;

    #[ORM\Column(type: 'json')]
    private $oldDestination = [];

    #[ORM\Column(type: 'json', nullable: true)]
    private $newDestination = [];

    // the proposed destination or kilometers by the user who create the conflict
    #[ORM\Column(type: 'text')]
    private $proposedDestinationOrDistance;

    // refers to the type of the resolve: either by adding direct distance, or by adding new destination
    #[ORM\Column(type: 'smallint', nullable: true)]
    private $resolveType;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getOrderId(): ?OrderEntity
    {
        return $this->orderId;
    }

    public function setOrderId(OrderEntity $orderId): self
    {
        $this->orderId = $orderId;

        return $this;
    }

    public function getConflictIssuedBy(): ?int
    {
        return $this->conflictIssuedBy;
    }

    public function setConflictIssuedBy(int $conflictIssuedBy): self
    {
        $this->conflictIssuedBy = $conflictIssuedBy;

        return $this;
    }

    public function getConflictIssuedByUserType(): ?int
    {
        return $this->conflictIssuedByUserType;
    }

    public function setConflictIssuedByUserType(int $conflictIssuedByUserType): self
    {
        $this->conflictIssuedByUserType = $conflictIssuedByUserType;

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

    public function getConflictResolvedBy(): ?int
    {
        return $this->conflictResolvedBy;
    }

    public function setConflictResolvedBy(?int $conflictResolvedBy): self
    {
        $this->conflictResolvedBy = $conflictResolvedBy;

        return $this;
    }

    public function getConflictResolvedByUserType(): ?int
    {
        return $this->conflictResolvedByUserType;
    }

    public function setConflictResolvedByUserType(?int $conflictResolvedByUserType): self
    {
        $this->conflictResolvedByUserType = $conflictResolvedByUserType;

        return $this;
    }

    public function getIsResolved(): ?bool
    {
        return $this->isResolved;
    }

    public function setIsResolved(bool $isResolved): self
    {
        $this->isResolved = $isResolved;

        return $this;
    }

    public function getResolvedAt(): ?\DateTimeInterface
    {
        return $this->resolvedAt;
    }

    public function setResolvedAt(?\DateTimeInterface $resolvedAt): self
    {
        $this->resolvedAt = $resolvedAt;

        return $this;
    }

    public function getConflictNote(): ?string
    {
        return $this->conflictNote;
    }

    public function setConflictNote(string $conflictNote): self
    {
        $this->conflictNote = $conflictNote;

        return $this;
    }

    public function getAdminNote(): ?string
    {
        return $this->adminNote;
    }

    public function setAdminNote(?string $adminNote): self
    {
        $this->adminNote = $adminNote;

        return $this;
    }

    public function getOldDistance(): ?float
    {
        return $this->oldDistance;
    }

    public function setOldDistance(?float $oldDistance): self
    {
        $this->oldDistance = $oldDistance;

        return $this;
    }

    public function getNewDistance(): ?float
    {
        return $this->newDistance;
    }

    public function setNewDistance(?float $newDistance): self
    {
        $this->newDistance = $newDistance;

        return $this;
    }

    public function getOldDestination(): ?array
    {
        return $this->oldDestination;
    }

    public function setOldDestination(array $oldDestination): self
    {
        $this->oldDestination = $oldDestination;

        return $this;
    }

    public function getNewDestination(): ?array
    {
        return $this->newDestination;
    }

    public function setNewDestination(?array $newDestination): self
    {
        $this->newDestination = $newDestination;

        return $this;
    }

    public function getProposedDestinationOrDistance(): ?string
    {
        return $this->proposedDestinationOrDistance;
    }

    public function setProposedDestinationOrDistance(string $proposedDestinationOrDistance): self
    {
        $this->proposedDestinationOrDistance = $proposedDestinationOrDistance;

        return $this;
    }

    public function getResolveType(): ?int
    {
        return $this->resolveType;
    }

    public function setResolveType(?int $resolveType): self
    {
        $this->resolveType = $resolveType;

        return $this;
    }
}
