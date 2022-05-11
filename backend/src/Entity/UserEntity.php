<?php

namespace App\Entity;

use App\Repository\UserEntityRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\UserInterface;

#[ORM\Entity(repositoryClass: UserEntityRepository::class)]
class UserEntity implements UserInterface, PasswordAuthenticatedUserInterface
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private $id;

    #[ORM\Column(type: 'string', length: 180, unique: true)]
    private $userId;

    #[ORM\Column(type: 'json')]
    private $roles = [];

    #[ORM\Column(type: 'string')]
    private $password;

    #[ORM\OneToMany(mappedBy: 'rater', targetEntity: RateEntity::class)]
    private $rateEntities;

    #[ORM\OneToMany(mappedBy: 'user', targetEntity: VerificationEntity::class)]
    private $verificationEntities;

    #[ORM\Column(type: 'integer')]
    private $verificationStatus = 0;

    #[ORM\OneToMany(mappedBy: 'user', targetEntity: ResetPasswordOrderEntity::class)]
    private $resetPasswordOrderEntities;

    public function __construct($userID)
    {
        $this->userId = $userID;
        $this->rateEntities = new ArrayCollection();
        $this->verificationEntities = new ArrayCollection();
        $this->resetPasswordOrderEntities = new ArrayCollection();
    }

    /**
     * A visual identifier that represents this user.
     *
     * @see UserInterface
     */
    public function getUsername(): string
    {
        return (string) $this->userId;
    }


    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUserId(): ?string
    {
        return $this->userId;
    }

    public function setUserId(string $userId): self
    {
        $this->userId = $userId;

        return $this;
    }

    /**
     * A visual identifier that represents this user.
     *
     * @see UserInterface
     */
    public function getUserIdentifier(): string
    {
        return (string) $this->userId;
    }

    /**
     * @see UserInterface
     */
    public function getRoles(): array
    {
        $roles = $this->roles;
        // guarantee every user at least has ROLE_USER
        $roles[] = 'ROLE_USER';

        return array_unique($roles);
    }

    public function setRoles(array $roles): self
    {
        $this->roles = $roles;

        return $this;
    }

    /**
     * @see PasswordAuthenticatedUserInterface
     */
    public function getPassword(): string
    {
        return $this->password;
    }

    public function setPassword(string $password): self
    {
        $this->password = $password;

        return $this;
    }

    /**
     * @see UserInterface
     */
    public function eraseCredentials()
    {
        // If you store any temporary, sensitive data on the user, clear it here
        // $this->plainPassword = null;
    }

    /**
     * @return Collection|RateEntity[]
     */
    public function getRateEntities(): Collection
    {
        return $this->rateEntities;
    }

    public function addRateEntity(RateEntity $rateEntity): self
    {
        if (!$this->rateEntities->contains($rateEntity)) {
            $this->rateEntities[] = $rateEntity;
            $rateEntity->setRater($this);
        }

        return $this;
    }

    public function removeRateEntity(RateEntity $rateEntity): self
    {
        if ($this->rateEntities->removeElement($rateEntity)) {
            // set the owning side to null (unless already changed)
            if ($rateEntity->getRater() === $this) {
                $rateEntity->setRater(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection|VerificationEntity[]
     */
    public function getVerificationEntities(): Collection
    {
        return $this->verificationEntities;
    }

    public function addVerificationEntity(VerificationEntity $verificationEntity): self
    {
        if (!$this->verificationEntities->contains($verificationEntity)) {
            $this->verificationEntities[] = $verificationEntity;
            $verificationEntity->setUser($this);
        }

        return $this;
    }

    public function removeVerificationEntity(VerificationEntity $verificationEntity): self
    {
        if ($this->verificationEntities->removeElement($verificationEntity)) {
            // set the owning side to null (unless already changed)
            if ($verificationEntity->getUser() === $this) {
                $verificationEntity->setUser(null);
            }
        }

        return $this;
    }

    public function getVerificationStatus(): ?int
    {
        return $this->verificationStatus;
    }

    public function setVerificationStatus(int $verificationStatus): self
    {
        $this->verificationStatus = $verificationStatus;

        return $this;
    }

    /**
     * @return Collection|ResetPasswordOrderEntity[]
     */
    public function getResetPasswordOrderEntities(): Collection
    {
        return $this->resetPasswordOrderEntities;
    }

    public function addResetPasswordOrderEntity(ResetPasswordOrderEntity $resetPasswordOrderEntity): self
    {
        if (!$this->resetPasswordOrderEntities->contains($resetPasswordOrderEntity)) {
            $this->resetPasswordOrderEntities[] = $resetPasswordOrderEntity;
            $resetPasswordOrderEntity->setUser($this);
        }

        return $this;
    }

    public function removeResetPasswordOrderEntity(ResetPasswordOrderEntity $resetPasswordOrderEntity): self
    {
        if ($this->resetPasswordOrderEntities->removeElement($resetPasswordOrderEntity)) {
            // set the owning side to null (unless already changed)
            if ($resetPasswordOrderEntity->getUser() === $this) {
                $resetPasswordOrderEntity->setUser(null);
            }
        }

        return $this;
    }
}
