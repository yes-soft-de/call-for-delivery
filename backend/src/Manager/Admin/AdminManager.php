<?php

namespace App\Manager\Admin;

use App\AutoMapping;
use App\Request\User\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\User\UserManager;

class AdminManager
{
    private $autoMapping;
    private $entityManager;
    private $userManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserManager $userManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->userManager = $userManager;
    }

    public function getUserByUserId($userID)
    {
        return $this->userManager->getUserByUserId($userID);
    }

    public function adminRegister(UserRegisterRequest $request)
    {
        $user = $this->userManager->getUserByUserId($request->getUserId());

        if (!$user) {
            $request->setRoles(["ROLE_ADMIN"]);

            $userRegister = $this->userManager->createUser($request);
            if($userRegister){
//                return $this->createProfile($request, $userRegister);
                return $userRegister;
            }
            else{
                return 'not created user';
            }
        }
        else {
//            return $this->createProfileWithUserFound($user, $request);
        }
    }

//    public function createProfile(UserRegisterRequest $request, $userRegister){
//
//        $adminProfile = $this->staffProfileEntityRepository->getCaptainProfileByCaptainID($request->getUserID());
//
//        if (!$adminProfile) {
//            $adminProfile = $this->autoMapping->map(UserRegisterRequest::class, StaffProfileEntity::class, $request);
//            $adminProfile->setAdminID($userRegister->getId());
//
//            $this->entityManager->persist($adminProfile);
//            $this->entityManager->flush();
//        }
//
//        return $userRegister;
//    }

//    public function createProfileWithUserFound($user, UserRegisterRequest $request)
//    {
//        $captainProfile = $this->staffProfileEntityRepository->getCaptainProfileByCaptainID($user['id']);
//
//        if (!$captainProfile) {
//            $captainProfile = $this->autoMapping->map(UserRegisterRequest::class, StaffProfileEntity::class, $request);
//
//            $captainProfile->setAdminID($user['id']);
//
//            $this->entityManager->persist($captainProfile);
//            $this->entityManager->flush();
//        }
//
//        return 'user is found';
//    }
}
