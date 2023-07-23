<?php

namespace App\Entity;

use App\Repository\CaptainFinancialDuesEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: CaptainFinancialDuesEntityRepository::class)]
class CaptainFinancialDuesEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    // 1: paid. 2: unpaid. 3: partially paid
    #[ORM\Column(type: 'integer')]
    private $status;

    #[ORM\Column(type: 'float')]
    private $amount;

    #[ORM\Column(type: 'date')]
    private $startDate;

    #[ORM\Column(type: 'date')]
    private $endDate;
    
    #[ORM\Column(type: 'float', nullable: true)]
    private $amountForStore;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $statusAmountForStore;

    #[ORM\ManyToOne(targetEntity: CaptainEntity::class, inversedBy: 'captainFinancialDuesEntity')]
    private $captain;

    #[ORM\OneToMany(mappedBy: 'captainFinancialDues', targetEntity: CaptainPaymentEntity::class)]
    private $captainPaymentEntities;
    //active = 1, inactive = 0
    #[ORM\Column(type: 'integer')]
    private $state;

    #[ORM\Column(type: 'boolean', nullable: true)]
    private $captainStoppedFinancialCycle;

    #[ORM\OneToMany(mappedBy: 'captainFinancialDueId', targetEntity: CaptainFinancialDemandEntity::class)]
    private $captainFinancialDemands;

    public function __construct()
    {
        $this->captainPaymentEntities = new ArrayCollection();
        $this->captainFinancialDemands = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getStatus(): ?int
    {
        return $this->status;
    }

    public function setStatus(int $status): self
    {
        $this->status = $status;

        return $this;
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

    public function getStatusAmountForStore(): ?float
    {
        return $this->statusAmountForStore;
    }

    public function setStatusAmountForStore(float $statusAmountForStore): self
    {
        $this->statusAmountForStore = $statusAmountForStore;

        return $this;
    }

    public function getStartDate()
    {
        return $this->startDate;
    }

    public function setStartDate($startDate): self
    {
        $this->startDate = new \DateTime($startDate);

        return $this;
    }

    public function getEndDate()
    {
        return $this->endDate;
    }

    public function setEndDate($endDate): self
    {
        $this->endDate = new \DateTime($endDate);

        return $this;
    }

    public function getAmountForStore(): ?float
    {
        return $this->amountForStore;
    }

    public function setAmountForStore(float $amountForStore): self
    {
        $this->amountForStore = $amountForStore;

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
     * @return Collection<int, CaptainPaymentEntity>
     */
    public function getCaptainPaymentEntities(): Collection
    {
        return $this->captainPaymentEntities;
    }

    public function addCaptainPaymentEntity(CaptainPaymentEntity $captainPaymentEntity): self
    {
        if (!$this->captainPaymentEntities->contains($captainPaymentEntity)) {
            $this->captainPaymentEntities[] = $captainPaymentEntity;
            $captainPaymentEntity->setCaptainFinancialDues($this);
        }

        return $this;
    }

    public function removeCaptainPaymentEntity(CaptainPaymentEntity $captainPaymentEntity): self
    {
        if ($this->captainPaymentEntities->removeElement($captainPaymentEntity)) {
            // set the owning side to null (unless already changed)
            if ($captainPaymentEntity->getCaptainFinancialDues() === $this) {
                $captainPaymentEntity->setCaptainFinancialDues(null);
            }
        }

        return $this;
    }

    public function getState(): ?int
    {
        return $this->state;
    }

    public function setState(int $state): self
    {
        $this->state = $state;

        return $this;
    }

    public function getCaptainStoppedFinancialCycle(): ?bool
    {
        return $this->captainStoppedFinancialCycle;
    }

    public function setCaptainStoppedFinancialCycle(?bool $captainStoppedFinancialCycle): self
    {
        $this->captainStoppedFinancialCycle = $captainStoppedFinancialCycle;

        return $this;
    }

    /**
     * @return Collection<int, CaptainFinancialDemandEntity>
     */
    public function getCaptainFinancialDemands(): Collection
    {
        return $this->captainFinancialDemands;
    }

    public function addCaptainFinancialDemand(CaptainFinancialDemandEntity $captainFinancialDemand): self
    {
        if (!$this->captainFinancialDemands->contains($captainFinancialDemand)) {
            $this->captainFinancialDemands[] = $captainFinancialDemand;
            $captainFinancialDemand->setCaptainFinancialDueId($this);
        }

        return $this;
    }

    public function removeCaptainFinancialDemand(CaptainFinancialDemandEntity $captainFinancialDemand): self
    {
        if ($this->captainFinancialDemands->removeElement($captainFinancialDemand)) {
            // set the owning side to null (unless already changed)
            if ($captainFinancialDemand->getCaptainFinancialDueId() === $this) {
                $captainFinancialDemand->setCaptainFinancialDueId(null);
            }
        }

        return $this;
    }
}
