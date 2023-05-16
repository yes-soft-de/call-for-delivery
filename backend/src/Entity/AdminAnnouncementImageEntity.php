<?php

namespace App\Entity;

use App\Repository\AdminAnnouncementImageEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: AdminAnnouncementImageEntityRepository::class)]
class AdminAnnouncementImageEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 255)]
    private $imagePath;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;


    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    #[ORM\ManyToOne(targetEntity: AdminNotificationToUsersEntity::class, inversedBy: 'adminAnnouncementImageEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $AdminNotificationToUser;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getImagePath(): ?string
    {
        return $this->imagePath;
    }

    public function setImagePath(string $imagePath): self
    {
        $this->imagePath = $imagePath;

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

    public function getUpdatedAt(): \DateTimeInterface
    {
        return $this->updatedAt;
    }

    public function setUpdatedAt(\DateTimeInterface $updatedAt): self
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    public function getAdminNotificationToUser(): ?AdminNotificationToUsersEntity
    {
        return $this->AdminNotificationToUser;
    }

    public function setAdminNotificationToUser(?AdminNotificationToUsersEntity $AdminNotificationToUser): self
    {
        $this->AdminNotificationToUser = $AdminNotificationToUser;

        return $this;
    }
}
