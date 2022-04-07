<?php

namespace App\Entity;

use App\Repository\CaptainFinancialSystemAccordingOnOrderEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: CaptainFinancialSystemAccordingOnOrderEntityRepository::class)]
class CaptainFinancialSystemAccordingOnOrderEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 255)]
    private $categoryName;

    #[ORM\Column(type: 'integer')]
    private $countKilometersFrom;

    #[ORM\Column(type: 'integer')]
    private $countKilometersTo;

    #[ORM\Column(type: 'float')]
    private $amount;

    #[ORM\Column(type: 'float', nullable: true)]
    private $bounce;

    #[ORM\Column(type: 'integer', nullable: true)]
    private $bounceCountOrdersInMonth;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCategoryName(): ?string
    {
        return $this->categoryName;
    }

    public function setCategoryName(string $categoryName): self
    {
        $this->categoryName = $categoryName;

        return $this;
    }

    public function getCountKilometersFrom(): ?int
    {
        return $this->countKilometersFrom;
    }

    public function setCountKilometersFrom(int $countKilometersFrom): self
    {
        $this->countKilometersFrom = $countKilometersFrom;

        return $this;
    }

    public function getCountKilometersTo(): ?int
    {
        return $this->countKilometersTo;
    }

    public function setCountKilometersTo(int $countKilometersTo): self
    {
        $this->countKilometersTo = $countKilometersTo;

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

    public function getBounce(): ?float
    {
        return $this->bounce;
    }

    public function setBounce(?float $bounce): self
    {
        $this->bounce = $bounce;

        return $this;
    }

    public function getBounceCountOrdersInMonth(): ?int
    {
        return $this->bounceCountOrdersInMonth;
    }

    public function setBounceCountOrdersInMonth(?int $bounceCountOrdersInMonth): self
    {
        $this->bounceCountOrdersInMonth = $bounceCountOrdersInMonth;

        return $this;
    }
}
