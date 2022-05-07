<?php

namespace App\Entity;

use App\Repository\CaptainPaymentToCompanyEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: CaptainPaymentToCompanyEntityRepository::class)]
class CaptainPaymentToCompanyEntity
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

    #[ORM\Column(type: 'text', nullable: true)]
    private $note;

    #[ORM\ManyToOne(targetEntity: CaptainEntity::class, inversedBy: 'captainPaymentToCompanyEntity')]
    #[ORM\JoinColumn(nullable: false)]
    private $captain;

    #[ORM\OneToMany(mappedBy: 'captainPaymentToCompany', targetEntity: CaptainAmountFromOrderCashEntity::class)]
    private $captainAmountFromOrderCashEntities;

    public function __construct()
    {
        $this->captainAmountFromOrderCashEntities = new ArrayCollection();
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

    public function getNote(): ?string
    {
        return $this->note;
    }

    public function setNote(?string $note): self
    {
        $this->note = $note;

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

    /**
     * @return Collection<int, CaptainAmountFromOrderCashEntity>
     */
    public function getCaptainAmountFromOrderCashEntities(): Collection
    {
        return $this->captainAmountFromOrderCashEntities;
    }

    public function addCaptainAmountFromOrderCashEntity(CaptainAmountFromOrderCashEntity $captainAmountFromOrderCashEntity): self
    {
        if (!$this->captainAmountFromOrderCashEntities->contains($captainAmountFromOrderCashEntity)) {
            $this->captainAmountFromOrderCashEntities[] = $captainAmountFromOrderCashEntity;
            $captainAmountFromOrderCashEntity->setCaptainPaymentToCompany($this);
        }

        return $this;
    }

    public function removeCaptainAmountFromOrderCashEntity(CaptainAmountFromOrderCashEntity $captainAmountFromOrderCashEntity): self
    {
        if ($this->captainAmountFromOrderCashEntities->removeElement($captainAmountFromOrderCashEntity)) {
            // set the owning side to null (unless already changed)
            if ($captainAmountFromOrderCashEntity->getCaptainPaymentToCompany() === $this) {
                $captainAmountFromOrderCashEntity->setCaptainPaymentToCompany(null);
            }
        }

        return $this;
    }
}
