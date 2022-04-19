<?php

namespace App\Entity;

use App\Repository\SubscriptionHistoryEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: SubscriptionHistoryEntityRepository::class)]
class SubscriptionHistoryEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\ManyToOne(targetEntity: StoreOwnerProfileEntity::class, inversedBy: 'note')]
    #[ORM\JoinColumn(nullable: false)]
    private $storeOwner;

    #[ORM\Column(type: 'text', nullable: true)]
    private $note;

    #[ORM\Column(type: 'boolean', length: 100, nullable: true)]
    private $type;

    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\OneToOne(targetEntity: SubscriptionEntity::class, cascade: ['persist', 'remove'])]
    private $subscription;
    
    #[ORM\Column(type: 'boolean', length: 100, nullable: true)]
    private $flag;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getStoreOwner(): ?StoreOwnerProfileEntity
    {
        return $this->storeOwner;
    }

    public function setStoreOwner(?StoreOwnerProfileEntity $storeOwner): self
    {
        $this->storeOwner = $storeOwner;

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

    public function getType(): ?bool
    {
        return $this->type;
    }

    public function setType(?bool $type): self
    {
        $this->type = $type;

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

    public function getSubscription(): ?SubscriptionEntity
    {
        return $this->subscription;
    }

    public function setSubscription(?SubscriptionEntity $subscription): self
    {
        $this->subscription = $subscription;

        return $this;
    }
    
    public function getFlag(): ?bool
    {
        return $this->flag;
    }

    public function setFlag(?bool $flag): self
    {
        $this->flag = $flag;

        return $this;
    }
}
