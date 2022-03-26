<?php

namespace App\Entity;

use App\Repository\RateEntityRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: RateEntityRepository::class)]
class RateEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'integer')]
    private $rating;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $comment;

    #[ORM\ManyToOne(targetEntity: userEntity::class, inversedBy: 'rateEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $rater;

    #[ORM\ManyToOne(targetEntity: userEntity::class, inversedBy: 'rateEntities')]
    private $rated;

    #[ORM\ManyToOne(targetEntity: OrderEntity::class, inversedBy: 'rateEntity')]
    private $orderId;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getRating(): ?int
    {
        return $this->rating;
    }

    public function setRating(int $rating): self
    {
        $this->rating = $rating;

        return $this;
    }

    public function getComment(): ?string
    {
        return $this->comment;
    }

    public function setComment(?string $comment): self
    {
        $this->comment = $comment;

        return $this;
    }

    public function getRater(): ?userEntity
    {
        return $this->rater;
    }

    public function setRater(?userEntity $rater): self
    {
        $this->rater = $rater;

        return $this;
    }

    public function getRated(): ?userEntity
    {
        return $this->rated;
    }

    public function setRated(?userEntity $rated): self
    {
        $this->rated = $rated;

        return $this;
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
}
