<?php

namespace App\Entity;

use App\Repository\AppFeatureEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: AppFeatureEntityRepository::class)]
class AppFeatureEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 100)]
    private $featureName;

    #[ORM\Column(type: 'boolean')]
    private $featureStatus;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getFeatureName(): ?string
    {
        return $this->featureName;
    }

    public function setFeatureName(string $featureName): self
    {
        $this->featureName = $featureName;

        return $this;
    }

    public function getFeatureStatus(): ?bool
    {
        return $this->featureStatus;
    }

    public function setFeatureStatus(bool $featureStatus): self
    {
        $this->featureStatus = $featureStatus;

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
}
