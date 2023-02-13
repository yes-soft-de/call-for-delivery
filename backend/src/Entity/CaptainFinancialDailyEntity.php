<?php

namespace App\Entity;

use App\Repository\CaptainFinancialDailyEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: CaptainFinancialDailyEntityRepository::class)]
class CaptainFinancialDailyEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'bigint')]
    private $id;

    #[ORM\ManyToOne(targetEntity: CaptainEntity::class, inversedBy: 'captainFinancialDailyEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $captainProfile;

    #[ORM\Column(type: 'float')]
    private $amount;

    // captain financial due which he/she had received before.
    #[ORM\Column(type: 'float')]
    private $alreadyHadAmount;

    #[ORM\Column(type: 'integer')]
    private $financialSystemType;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $financialSystemPlan;

    #[ORM\Column(type: 'smallint')]
    private $isPaid;

    #[ORM\Column(type: 'boolean')]
    private $withBonus;

    #[ORM\Column(type: 'float', nullable: true)]
    private $bonus;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime', nullable: true)]
    private $updatedAt;

    #[ORM\OneToMany(mappedBy: 'captainFinancialDailyEntity', targetEntity: CaptainPaymentEntity::class)]
    private $captainPayment;

    public function __construct()
    {
        $this->captainPayment = new ArrayCollection();
    }

    public function getId(): ?string
    {
        return $this->id;
    }

    public function getCaptainProfile(): ?CaptainEntity
    {
        return $this->captainProfile;
    }

    public function setCaptainProfile(?CaptainEntity $captainProfile): self
    {
        $this->captainProfile = $captainProfile;

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

    public function getAlreadyHadAmount(): ?float
    {
        return $this->alreadyHadAmount;
    }

    public function setAlreadyHadAmount(float $alreadyHadAmount): self
    {
        $this->alreadyHadAmount = $alreadyHadAmount;

        return $this;
    }

    public function getFinancialSystemType(): ?int
    {
        return $this->financialSystemType;
    }

    public function setFinancialSystemType(int $financialSystemType): self
    {
        $this->financialSystemType = $financialSystemType;

        return $this;
    }

    public function getFinancialSystemPlan(): ?int
    {
        return $this->financialSystemPlan;
    }

    public function setFinancialSystemPlan(?int $financialSystemPlan): self
    {
        $this->financialSystemPlan = $financialSystemPlan;

        return $this;
    }

    public function getIsPaid(): ?int
    {
        return $this->isPaid;
    }

    public function setIsPaid(int $isPaid): self
    {
        $this->isPaid = $isPaid;

        return $this;
    }

    public function getWithBonus(): ?bool
    {
        return $this->withBonus;
    }

    public function setWithBonus(bool $withBonus): self
    {
        $this->withBonus = $withBonus;

        return $this;
    }

    public function getBonus(): ?float
    {
        return $this->bonus;
    }

    public function setBonus(?float $bonus): self
    {
        $this->bonus = $bonus;

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

    public function setUpdatedAt(?\DateTimeInterface $updatedAt): self
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    /**
     * @return Collection<int, CaptainPaymentEntity>
     */
    public function getCaptainPayment(): Collection
    {
        return $this->captainPayment;
    }

    public function addCaptainPayment(CaptainPaymentEntity $captainPayment): self
    {
        if (!$this->captainPayment->contains($captainPayment)) {
            $this->captainPayment[] = $captainPayment;
            $captainPayment->setCaptainFinancialDailyEntity($this);
        }

        return $this;
    }

    public function removeCaptainPayment(CaptainPaymentEntity $captainPayment): self
    {
        if ($this->captainPayment->removeElement($captainPayment)) {
            // set the owning side to null (unless already changed)
            if ($captainPayment->getCaptainFinancialDailyEntity() === $this) {
                $captainPayment->setCaptainFinancialDailyEntity(null);
            }
        }

        return $this;
    }
}
