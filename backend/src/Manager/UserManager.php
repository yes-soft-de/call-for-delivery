<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\UserEntity;
use App\Repository\UserEntityRepository;
use App\Request\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class UserManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $userRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordHasherInterface $encoder, UserEntityRepository $userRepository
    )
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
    }

    public function clientRegister(UserRegisterRequest $request, $roomID)
    {
        $user = $this->getUserByUserID($request->getUserID());

        if ($user == null) {

            $userRegister = $this->autoMapping->map(UserRegisterRequest::class, UserEntity::class, $request);

            $user = new UserEntity($request->getUserID());

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

    public function getUserByUserID($userID)
    {
        return $this->userRepository->getUserByUserID($userID);
    }

    public function getUserByUserIdAndRole($userID, $role)
    {
        return $this->userRepository->getUserByUserIdAndRole($userID, $role);
    }

    public function createUser(UserRegisterRequest $request)
    {
        $userRegister = $this->autoMapping->map(UserRegisterRequest::class, UserEntity::class, $request);

        $user = new UserEntity($request->getUserID());

        if ($request->getPassword()) {
            $userRegister->setPassword($this->encoder->hashPassword($user, $request->getPassword()));
        }

        $this->entityManager->persist($userRegister);
        $this->entityManager->flush();

        return $userRegister;
    }
}
