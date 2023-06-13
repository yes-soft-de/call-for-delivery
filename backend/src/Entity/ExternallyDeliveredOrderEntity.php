<?php

namespace App\Entity;

use App\Repository\ExternallyDeliveredOrderEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: ExternallyDeliveredOrderEntityRepository::class)]
class ExternallyDeliveredOrderEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'bigint')]
    private $id;

    #[ORM\ManyToOne(targetEntity: OrderEntity::class, inversedBy: 'externallyDeliveredOrderEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $orderId;

    #[ORM\Column(type: 'bigint')]
    private $externalOrderId;

    #[ORM\ManyToOne(targetEntity: ExternalDeliveryCompanyEntity::class, inversedBy: 'externallyDeliveredOrderEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $externalDeliveryCompany;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    // The status of the order at the external company
    #[ORM\Column(type: 'string', length: 255)]
    private $status;

    public function getId(): ?string
    {
        return $this->id;
    }

    public function getOrderId(): ?OrderEntity
    {
        return $this->orderId;
    }

    public function setOrderId(?OrderEntity $orderId): self
    {
        $this->orderId = $orderId;

        return $this;
    }

    public function getExternalOrderId(): ?string
    {
        return $this->externalOrderId;
    }

    public function setExternalOrderId(string $externalOrderId): self
    {
        $this->externalOrderId = $externalOrderId;

        return $this;
    }

    public function getExternalDeliveryCompany(): ?ExternalDeliveryCompanyEntity
    {
        return $this->externalDeliveryCompany;
    }

    public function setExternalDeliveryCompany(?ExternalDeliveryCompanyEntity $externalDeliveryCompany): self
    {
        $this->externalDeliveryCompany = $externalDeliveryCompany;

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

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(string $status): self
    {
        $this->status = $status;

        return $this;
    }
}
