<?php

namespace App\Manager\StoreOwner;

use App\AutoMapping;
use App\Entity\StoreOwnerProfileEntity;
use App\Repository\User\UserEntityRepository;
use App\Repository\StoreOwner\StoreOwnerProfileEntityRepository;
use App\Request\User\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use App\Manager\User\UserManager;

class StoreOwnerProfileManager
{
    private $autoMapping;
    private $entityManager;
    private $storeOwnerProfileEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordHasherInterface $encoder, UserEntityRepository $userRepository
   , UserManager $userManager, StoreOwnerProfileEntityRepository $storeOwnerProfileEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
        $this->userManager = $userManager;
        $this->storeOwnerProfileEntityRepository = $storeOwnerProfileEntityRepository;
    }

    public function storeOwnerRegister(UserRegisterRequest $request)
    {
        $user = $this->userManager->getUserByUserID($request->getUserID());
        if (!$user) {
            $request->setRoles(["ROLE_OWNER"]);

            $userRegister = $this->userManager->createUser($request);
            if($userRegister){
                return $this->createProfile($request, $userRegister);
            }
            else{
                return 'not created user';
            }
        }
        else {
            return $this->createProfileWithUserFound($user, $request);
        }
    }

    public function createProfile(UserRegisterRequest $request, $userRegister){

        $storeProfile = $this->storeOwnerProfileEntityRepository->getStoreProfileByStoreID($request->getUserID());

        if (!$storeProfile) {
            $storeProfile = $this->autoMapping->map(UserRegisterRequest::class, StoreOwnerProfileEntity::class, $request);
            $storeProfile->setStatus('inactive');
            $storeProfile->setStoreOwnerID($userRegister->getId());
            $storeProfile->setStoreOwnerName($request->getUserName());

            $this->entityManager->persist($storeProfile);
            $this->entityManager->flush();
        }

        return $userRegister;
    }

    public function createProfileWithUserFound($user, UserRegisterRequest $request)
    {
        $storeProfile = $this->storeOwnerProfileEntityRepository->getStoreProfileByStoreID($user['id']);

        if (!$storeProfile) {
            $storeProfile = $this->autoMapping->map(UserRegisterRequest::class, StoreOwnerProfileEntity::class, $request);

            $storeProfile->setStatus('inactive');
            $storeProfile->setStoreOwnerID($user['id']);
            $storeProfile->setStoreOwnerName($request->getUserName());

            $this->entityManager->persist($storeProfile);
            $this->entityManager->flush();
        }

        return 'user is found';
    }
}
