<?php

namespace App\Entity;

use App\Repository\CaptainFinancialSystemAccordingToCountOfHoursEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: CaptainFinancialSystemAccordingToCountOfHoursEntityRepository::class)]
class CaptainFinancialSystemAccordingToCountOfHoursEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'integer')]
    private $countHours;

    #[ORM\Column(type: 'float')]
    private $compensationForEveryOrder;

    #[ORM\Column(type: 'float')]
    private $salary;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCountHours(): ?int
    {
        return $this->countHours;
    }

    public function setCountHours(int $countHours): self
    {
        $this->countHours = $countHours;

        return $this;
    }

    public function getCompensationForEveryOrder(): ?float
    {
        return $this->compensationForEveryOrder;
    }

    public function setCompensationForEveryOrder(float $compensationForEveryOrder): self
    {
        $this->compensationForEveryOrder = $compensationForEveryOrder;

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
}
