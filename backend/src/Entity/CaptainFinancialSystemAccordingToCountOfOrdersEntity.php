<?php

namespace App\Entity;

use App\Repository\CaptainFinancialSystemAccordingToCountOfOrdersEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: CaptainFinancialSystemAccordingToCountOfOrdersEntityRepository::class)]
class CaptainFinancialSystemAccordingToCountOfOrdersEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'integer')]
    private $countOrdersInMonth;

    #[ORM\Column(type: 'float')]
    private $salary;

    #[ORM\Column(type: 'float')]
    private $monthCompensation;

    #[ORM\Column(type: 'float')]
    private $bounceMaxCountOrdersInMonth;

    #[ORM\Column(type: 'float')]
    private $bounceMinCountOrdersInMonth;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCountOrdersInMonth(): ?int
    {
        return $this->countOrdersInMonth;
    }

    public function setCountOrdersInMonth(int $countOrdersInMonth): self
    {
        $this->countOrdersInMonth = $countOrdersInMonth;

        return $this;
    }

    public function getSalary(): ?float
    {
        return $this->salary;
    }

    public function setSalary(float $salary): self
    {
        $this->salary = $salary;

        return $this;
    }

    public function getMonthCompensation(): ?float
    {
        return $this->monthCompensation;
    }

    public function setMonthCompensation(float $monthCompensation): self
    {
        $this->monthCompensation = $monthCompensation;

        return $this;
    }

    public function getBounceMaxCountOrdersInMonth(): ?float
    {
        return $this->bounceMaxCountOrdersInMonth;
    }

    public function setBounceMaxCountOrdersInMonth(?float $bounceMaxCountOrdersInMonth): self
    {
        $this->bounceMaxCountOrdersInMonth = $bounceMaxCountOrdersInMonth;

        return $this;
    }

    public function getBounceMinCountOrdersInMonth(): ?float
    {
        return $this->bounceMinCountOrdersInMonth;
    }

    public function setBounceMinCountOrdersInMonth(float $bounceMinCountOrdersInMonth): self
    {
        $this->bounceMinCountOrdersInMonth = $bounceMinCountOrdersInMonth;

        return $this;
    }
}
