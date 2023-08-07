<?php

namespace App\Entity;

use App\Repository\AdminProfileEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

#[ORM\Entity(repositoryClass: AdminProfileEntityRepository::class)]
class AdminProfileEntity
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 100)]
    private $name;

    #[ORM\Column(type: 'string', length: 100, nullable: true)]
    private $phone;

    #[Gedmo\Timestampable(on: 'create')]
    #[ORM\Column(type: 'datetime')]
    private $createdAt;

    #[Gedmo\Timestampable(on: 'update')]
    #[ORM\Column(type: 'datetime')]
    private $updatedAt;

    #[ORM\Column(type: 'boolean')]
    private $status = false;

    #[ORM\OneToOne(targetEntity: UserEntity::class, cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private $user;

    #[ORM\OneToMany(mappedBy: 'user', targetEntity: ImageEntity::class)]
    private $images;

    #[ORM\OneToMany(mappedBy: 'adminProfile', targetEntity: DirectSupportScriptEntity::class)]
    private $directSupportScriptEntities;

    #[ORM\OneToMany(mappedBy: 'adminProfile', targetEntity: DashboardLocalNotificationEntity::class)]
    private $dashboardLocalNotificationEntities;

    #[ORM\OneToMany(mappedBy: 'updatedBy', targetEntity: ExternalDeliveryCompanyCriteriaEntity::class)]
    private $externalDeliveryCompanyCriteriaEntities;

    #[ORM\OneToMany(mappedBy: 'updatedBy', targetEntity: CaptainFinancialDefaultSystemEntity::class)]
    private $captainFinancialDefaultSystemEntities;

    #[ORM\OneToMany(mappedBy: 'createdByAdmin', targetEntity: CaptainPaymentEntity::class)]
    private $captainPaymentEntities;

    #[ORM\OneToMany(mappedBy: 'adminProfile', targetEntity: EPaymentFromStoreLogEntity::class)]
    private $ePaymentFromStoreLogs;

    public function __construct()
    {
        $this->images = new ArrayCollection();
        $this->directSupportScriptEntities = new ArrayCollection();
        $this->dashboardLocalNotificationEntities = new ArrayCollection();
        $this->externalDeliveryCompanyCriteriaEntities = new ArrayCollection();
        $this->captainFinancialDefaultSystemEntities = new ArrayCollection();
        $this->captainPaymentEntities = new ArrayCollection();
        $this->ePaymentFromStoreLogs = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getPhone(): ?string
    {
        return $this->phone;
    }

    public function setPhone(?string $phone): self
    {
        $this->phone = $phone;

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

    public function getStatus(): ?bool
    {
        return $this->status;
    }

    public function setStatus(bool $status): self
    {
        $this->status = $status;

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

    /**
     * @return Collection|ImageEntity[]
     */
    public function getImages(): Collection
    {
        return $this->images;
    }

    public function addImage(ImageEntity $image): self
    {
        if (!$this->images->contains($image)) {
            $this->images[] = $image;
            $image->setUser($this);
        }

        return $this;
    }

    public function removeImage(ImageEntity $image): self
    {
        if ($this->images->removeElement($image)) {
            // set the owning side to null (unless already changed)
            if ($image->getUser() === $this) {
                $image->setUser(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, DirectSupportScriptEntity>
     */
    public function getDirectSupportScriptEntities(): Collection
    {
        return $this->directSupportScriptEntities;
    }

    public function addDirectSupportScriptEntity(DirectSupportScriptEntity $directSupportScriptEntity): self
    {
        if (!$this->directSupportScriptEntities->contains($directSupportScriptEntity)) {
            $this->directSupportScriptEntities[] = $directSupportScriptEntity;
            $directSupportScriptEntity->setAdminProfile($this);
        }

        return $this;
    }

    public function removeDirectSupportScriptEntity(DirectSupportScriptEntity $directSupportScriptEntity): self
    {
        if ($this->directSupportScriptEntities->removeElement($directSupportScriptEntity)) {
            // set the owning side to null (unless already changed)
            if ($directSupportScriptEntity->getAdminProfile() === $this) {
                $directSupportScriptEntity->setAdminProfile(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, DashboardLocalNotificationEntity>
     */
    public function getDashboardLocalNotificationEntities(): Collection
    {
        return $this->dashboardLocalNotificationEntities;
    }

    public function addDashboardLocalNotificationEntity(DashboardLocalNotificationEntity $dashboardLocalNotificationEntity): self
    {
        if (!$this->dashboardLocalNotificationEntities->contains($dashboardLocalNotificationEntity)) {
            $this->dashboardLocalNotificationEntities[] = $dashboardLocalNotificationEntity;
            $dashboardLocalNotificationEntity->setAdminProfile($this);
        }

        return $this;
    }

    public function removeDashboardLocalNotificationEntity(DashboardLocalNotificationEntity $dashboardLocalNotificationEntity): self
    {
        if ($this->dashboardLocalNotificationEntities->removeElement($dashboardLocalNotificationEntity)) {
            // set the owning side to null (unless already changed)
            if ($dashboardLocalNotificationEntity->getAdminProfile() === $this) {
                $dashboardLocalNotificationEntity->setAdminProfile(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, ExternalDeliveryCompanyCriteriaEntity>
     */
    public function getExternalDeliveryCompanyCriteriaEntities(): Collection
    {
        return $this->externalDeliveryCompanyCriteriaEntities;
    }

    public function addExternalDeliveryCompanyCriteriaEntity(ExternalDeliveryCompanyCriteriaEntity $externalDeliveryCompanyCriteriaEntity): self
    {
        if (!$this->externalDeliveryCompanyCriteriaEntities->contains($externalDeliveryCompanyCriteriaEntity)) {
            $this->externalDeliveryCompanyCriteriaEntities[] = $externalDeliveryCompanyCriteriaEntity;
            $externalDeliveryCompanyCriteriaEntity->setUpdatedBy($this);
        }

        return $this;
    }

    public function removeExternalDeliveryCompanyCriteriaEntity(ExternalDeliveryCompanyCriteriaEntity $externalDeliveryCompanyCriteriaEntity): self
    {
        if ($this->externalDeliveryCompanyCriteriaEntities->removeElement($externalDeliveryCompanyCriteriaEntity)) {
            // set the owning side to null (unless already changed)
            if ($externalDeliveryCompanyCriteriaEntity->getUpdatedBy() === $this) {
                $externalDeliveryCompanyCriteriaEntity->setUpdatedBy(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, CaptainFinancialDefaultSystemEntity>
     */
    public function getCaptainFinancialDefaultSystemEntities(): Collection
    {
        return $this->captainFinancialDefaultSystemEntities;
    }

    public function addCaptainFinancialDefaultSystemEntity(CaptainFinancialDefaultSystemEntity $captainFinancialDefaultSystemEntity): self
    {
        if (!$this->captainFinancialDefaultSystemEntities->contains($captainFinancialDefaultSystemEntity)) {
            $this->captainFinancialDefaultSystemEntities[] = $captainFinancialDefaultSystemEntity;
            $captainFinancialDefaultSystemEntity->setUpdatedBy($this);
        }

        return $this;
    }

    public function removeCaptainFinancialDefaultSystemEntity(CaptainFinancialDefaultSystemEntity $captainFinancialDefaultSystemEntity): self
    {
        if ($this->captainFinancialDefaultSystemEntities->removeElement($captainFinancialDefaultSystemEntity)) {
            // set the owning side to null (unless already changed)
            if ($captainFinancialDefaultSystemEntity->getUpdatedBy() === $this) {
                $captainFinancialDefaultSystemEntity->setUpdatedBy(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, CaptainPaymentEntity>
     */
    public function getCaptainPaymentEntities(): Collection
    {
        return $this->captainPaymentEntities;
    }

    public function addCaptainPaymentEntity(CaptainPaymentEntity $captainPaymentEntity): self
    {
        if (!$this->captainPaymentEntities->contains($captainPaymentEntity)) {
            $this->captainPaymentEntities[] = $captainPaymentEntity;
            $captainPaymentEntity->setCreatedByAdmin($this);
        }

        return $this;
    }

    public function removeCaptainPaymentEntity(CaptainPaymentEntity $captainPaymentEntity): self
    {
        if ($this->captainPaymentEntities->removeElement($captainPaymentEntity)) {
            // set the owning side to null (unless already changed)
            if ($captainPaymentEntity->getCreatedByAdmin() === $this) {
                $captainPaymentEntity->setCreatedByAdmin(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, EPaymentFromStoreLogEntity>
     */
    public function getEPaymentFromStoreLogs(): Collection
    {
        return $this->ePaymentFromStoreLogs;
    }

    public function addEPaymentFromStoreLog(EPaymentFromStoreLogEntity $ePaymentFromStoreLog): self
    {
        if (!$this->ePaymentFromStoreLogs->contains($ePaymentFromStoreLog)) {
            $this->ePaymentFromStoreLogs[] = $ePaymentFromStoreLog;
            $ePaymentFromStoreLog->setAdminProfile($this);
        }

        return $this;
    }

    public function removeEPaymentFromStoreLog(EPaymentFromStoreLogEntity $ePaymentFromStoreLog): self
    {
        if ($this->ePaymentFromStoreLogs->removeElement($ePaymentFromStoreLog)) {
            // set the owning side to null (unless already changed)
            if ($ePaymentFromStoreLog->getAdminProfile() === $this) {
                $ePaymentFromStoreLog->setAdminProfile(null);
            }
        }

        return $this;
    }
}
