<?php

namespace App\Manager\User;

use App\AutoMapping;
use App\Entity\UserEntity;
use App\Repository\User\UserEntityRepository;
use App\Request\User\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class UserManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $userRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordHasherInterface $encoder, UserEntityRepository $userRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
    }

    public function clientRegister(UserRegisterRequest $request, $roomID)
    {
        $user = $this->getUserByUserId($request->getUserId());

        if ($user === null) {

            $userRegister = $this->autoMapping->map(UserRegisterRequest::class, UserEntity::class, $request);

            $user = new UserEntity($request->getUserId());

            if ($request->getPassword()) {
                $userRegister->setPassword($this->encoder->hashPassword($user, $request->getPassword()));
            }

            $userRegister->setRoles(["ROLE_CLIENT"]);

//            $userRegister->setVerificationStatus(UserVerificationStatusConstant::$NOT_VERIFIED_STATUS);

            $this->entityManager->persist($userRegister);
            $this->entityManager->flush();

//            // Second, create the client's profile
//            $clientProfile = $this->getClientProfileByClientID($request->getUserID());
//
//            if ($clientProfile == null) {
//                $clientProfile = $this->autoMapping->map(UserRegisterRequest::class, ClientProfileEntity::class, $request);
//
//                $clientProfile->setClientID($userRegister->getId());
//                $clientProfile->setClientName($request->getUserName());
//                $clientProfile->setRoomID($roomID);
//                $clientProfile->setPhone($request->getUserID());
//
//                $this->entityManager->persist($clientProfile);
//                $this->entityManager->flush();
//                $this->entityManager->clear();
//            }
            return $userRegister;
        }
        else
        {
//            $clientProfile = $this->getClientProfileByClientID($user['id']);
//
//            if ($clientProfile == null)
//            {
//                $clientProfile = $this->autoMapping->map(UserRegisterRequest::class, ClientProfileEntity::class, $request);
//                $clientProfile->setClientID($user['id']);
//                $clientProfile->setClientName($request->getUserName());
//                $clientProfile->setRoomID($roomID);
//                $clientProfile->setPhone($request->getUserID());
//
//                $this->entityManager->persist($clientProfile);
//                $this->entityManager->flush();
//                $this->entityManager->clear();
//            }

            return true;
        }
    }

    public function getUserByUserId($userId): ?array
    {
        return $this->userRepository->getUserByUserId($userId);
    }

    public function getUserByUserIdAndRole($userId, $role): array
    {
        return $this->userRepository->getUserByUserIdAndRole($userId, $role);
    }

    public function createUser(UserRegisterRequest $request): UserEntity
    {
        $userRegister = $this->autoMapping->map(UserRegisterRequest::class, UserEntity::class, $request);

        $user = new UserEntity($request->getUserId());

        if ($request->getPassword()) {
            $userRegister->setPassword($this->encoder->hashPassword($user, $request->getPassword()));
        }

        $this->entityManager->persist($userRegister);
        $this->entityManager->flush();

        return $userRegister;
    }

    public function getUserRoleByUserId($userId): array
    {
        return $this->userRepository->getUserRoleByUserId($userId);
    }

    public function checkUserType($userType,$userID): string
    {
        $user = $this->userRepository->find($userID);

        if ($user->getRoles()[0] !== $userType) {
            return "no";
        }

        return "yes";
    }
}
