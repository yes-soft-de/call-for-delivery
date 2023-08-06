<?php

namespace App\Entity;

use App\Repository\EPaymentFromStoreLogEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

/**
 * Log of E-Payments from Store to Administration
 */
#[ORM\Entity(repositoryClass: EPaymentFromStoreLogEntityRepository::class)]
class EPaymentFromStoreLogEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\ManyToOne(targetEntity: EPaymentFromStoreEntity::class, inversedBy: 'ePaymentFromStoreLogs')]
    #[ORM\JoinColumn(nullable: false)]
    private $EPaymentFromStore;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    // the int value refers to the resulting action of the payment
    #[ORM\Column(type: 'integer')]
    private $action;

    #[ORM\Column(type: 'text', nullable: true)]
    private $details;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getEPaymentFromStore(): ?EPaymentFromStoreEntity
    {
        return $this->EPaymentFromStore;
    }

    public function setEPaymentFromStore(?EPaymentFromStoreEntity $EPaymentFromStore): self
    {
        $this->EPaymentFromStore = $EPaymentFromStore;

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

    public function getAction(): ?int
    {
        return $this->action;
    }

    public function setAction(int $action): self
    {
        $this->action = $action;

        return $this;
    }

    public function getDetails(): ?string
    {
        return $this->details;
    }

    public function setDetails(?string $details): self
    {
        $this->details = $details;

        return $this;
    }
}
