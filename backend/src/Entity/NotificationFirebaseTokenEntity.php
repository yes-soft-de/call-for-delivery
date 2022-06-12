<?php

namespace App\Entity;

use App\Repository\NotificationFirebaseTokenEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: NotificationFirebaseTokenEntityRepository::class)]
class NotificationFirebaseTokenEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;
 
    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[ORM\Column(type: 'string', length: 255)]
    private $token;

    #[ORM\OneToOne(targetEntity: UserEntity::class, cascade: ['persist'])]
    #[ORM\JoinColumn(nullable: false)]
    private $user;

    #[ORM\Column(type: 'integer')]
    private $appType;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private $sound;

    public function getId(): ?int
    {
        return $this->id;
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

    public function getToken(): ?string
    {
        return $this->token;
    }

    public function setToken(string $token): self
    {
        $this->token = $token;

        return $this;
    }

    public function getUser(): ?UserEntity
    {
        return $this->user;
    }

    public function setUser(UserEntity $user): self
    {
        $this->user = $user;

        return $this;
    }

    public function getAppType(): ?int
    {
        return $this->appType;
    }

    public function setAppType(int $appType): self
    {
        $this->appType = $appType;

        return $this;
    }

    public function getSound(): ?string
    {
        return $this->sound;
    }

    public function setSound(?string $sound): self
    {
        $this->sound = $sound;

        return $this;
    }
}
