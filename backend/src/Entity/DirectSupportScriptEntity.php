<?php

namespace App\Entity;

use App\Repository\DirectSupportScriptEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: DirectSupportScriptEntityRepository::class)]
class DirectSupportScriptEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    // the subject of the script/message
    #[ORM\Column(type: 'integer')]
    private $action;

    #[ORM\Column(type: 'string', length: 255)]
    private $message;

    // type of the app that the script relates to
    #[ORM\Column(type: 'integer')]
    private $appType;

    #[ORM\ManyToOne(targetEntity: AdminProfileEntity::class, inversedBy: 'directSupportScriptEntities')]
    #[ORM\JoinColumn(nullable: false)]
    private $adminProfile;

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

    public function getAction(): ?int
    {
        return $this->action;
    }

    public function setAction(int $action): self
    {
        $this->action = $action;

        return $this;
    }

    public function getMessage(): ?string
    {
        return $this->message;
    }

    public function setMessage(string $message): self
    {
        $this->message = $message;

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

    public function getAdminProfile(): ?AdminProfileEntity
    {
        return $this->adminProfile;
    }

    public function setAdminProfile(?AdminProfileEntity $adminProfile): self
    {
        $this->adminProfile = $adminProfile;

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
