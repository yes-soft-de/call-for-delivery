<?php

namespace App\Entity;

use App\Repository\AdminNotificationToUsersEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: AdminNotificationToUsersEntityRepository::class)]
class AdminNotificationToUsersEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 150, nullable: true)]
    private $appType;

    #[ORM\Column(type: 'string', length: 255)]
    private $title;

    #[ORM\Column(type: 'text')]
    private $msg;

    #[ORM\Column(type: 'integer')]
    private $userId;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;
    
    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    #[ORM\OneToMany(mappedBy: 'AdminNotificationToUser', targetEntity: AdminAnnouncementImageEntity::class)]
    private $adminAnnouncementImageEntities;

    public function __construct()
    {
        $this->adminAnnouncementImageEntities = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getAppType(): ?string
    {
        return $this->appType;
    }

    public function setAppType(?string $appType): self
    {
        $this->appType = $appType;

        return $this;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }

    public function setTitle(string $title): self
    {
        $this->title = $title;

        return $this;
    }

    public function getMsg(): ?string
    {
        return $this->msg;
    }

    public function setMsg(string $msg): self
    {
        $this->msg = $msg;

        return $this;
    }

    public function getUserId(): ?int
    {
        return $this->userId;
    }

    public function setUserId(?int $userId): self
    {
        $this->userId = $userId;

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

    /**
     * @return Collection<int, AdminAnnouncementImageEntity>
     */
    public function getAdminAnnouncementImageEntities(): Collection
    {
        return $this->adminAnnouncementImageEntities;
    }

    public function addAdminAnnouncementImageEntity(AdminAnnouncementImageEntity $adminAnnouncementImageEntity): self
    {
        if (!$this->adminAnnouncementImageEntities->contains($adminAnnouncementImageEntity)) {
            $this->adminAnnouncementImageEntities[] = $adminAnnouncementImageEntity;
            $adminAnnouncementImageEntity->setAdminNotificationToUser($this);
        }

        return $this;
    }

    public function removeAdminAnnouncementImageEntity(AdminAnnouncementImageEntity $adminAnnouncementImageEntity): self
    {
        if ($this->adminAnnouncementImageEntities->removeElement($adminAnnouncementImageEntity)) {
            // set the owning side to null (unless already changed)
            if ($adminAnnouncementImageEntity->getAdminNotificationToUser() === $this) {
                $adminAnnouncementImageEntity->setAdminNotificationToUser(null);
            }
        }

        return $this;
    }
}
