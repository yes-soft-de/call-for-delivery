<?php

namespace App\Manager\User;

use App\AutoMapping;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\UserEntity;
use App\Repository\UserEntityRepository;
use App\Request\Admin\AdminRegisterRequest;
use App\Request\User\UserPasswordUpdateBySuperAdminRequest;
use App\Request\User\UserRegisterRequest;
use App\Request\User\UserVerificationStatusUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use App\Manager\ChatRoom\ChatRoomManager;

class UserManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private UserPasswordHasherInterface $encoder;
    private UserEntityRepository $userRepository;
    private ChatRoomManager $chatRoomManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordHasherInterface $encoder, UserEntityRepository $userRepository, ChatRoomManager $chatRoomManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
        $this->chatRoomManager = $chatRoomManager;
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

    public function createUser(UserRegisterRequest $request, int $usedAs): UserEntity
    {
        $userRegister = $this->autoMapping->map(UserRegisterRequest::class, UserEntity::class, $request);

        $user = new UserEntity($request->getUserId());

        if ($request->getPassword()) {
            $userRegister->setPassword($this->encoder->hashPassword($user, $request->getPassword()));
        }

        $this->entityManager->persist($userRegister);
        $this->entityManager->flush();

        $this->chatRoomManager->createChatRoom($userRegister->getId(), $usedAs);

        return $userRegister;
    }

    /**
     * This function for persisting new user in the DB with role equals to Admin
     * It's separated from createUser because of the separation of AdminRegisterRequest and UserRegisterRequest
     */
    public function createAdmin(AdminRegisterRequest $request): UserEntity
    {
        $adminRegister = $this->autoMapping->map(AdminRegisterRequest::class, UserEntity::class, $request);

        $user = new UserEntity($request->getUserId());

        if ($request->getPassword()) {
            $adminRegister->setPassword($this->encoder->hashPassword($user, $request->getPassword()));
        }

        $this->entityManager->persist($adminRegister);
        $this->entityManager->flush();

        return $adminRegister;
    }

    public function getUserRoleByUserId($userId): array
    {
        return $this->userRepository->getUserRoleByUserId($userId);
    }

    // This function checks if the type of the user being provided is similar to the stored one
    public function checkUserType($userType,$userID): string
    {
        $user = $this->userRepository->find($userID);

        if ($user->getRoles()[0] !== $userType) {
            // the type of the user being retrieved does not match the provided one
            return "no";
        }

        // the type of the user being retrieved matches the provided one
        return "yes";
    }

    public function filterUsersBySuperAdmin($request): ?array
    {
        return $this->userRepository->filterUsersBySuperAdmin($request);
    }

    public function updateUserPasswordBySuperAdmin(UserPasswordUpdateBySuperAdminRequest $request): string|UserEntity
    {
        $userEntity = $this->userRepository->find($request->getId());

        if(! $userEntity) {
            return UserReturnResultConstant::USER_NOT_FOUND_RESULT;

        } else {
            $userEntity = $this->autoMapping->mapToObject(UserPasswordUpdateBySuperAdminRequest::class, UserEntity::class,
                $request, $userEntity);

            $userEntity->setPassword($this->encoder->hashPassword($userEntity, $request->getPassword()));

            $this->entityManager->flush();

            return $userEntity;
        }
    }
    
    public function getUser($id): ?UserEntity
    {
        return $this->userRepository->find($id);
    }

    public function getUserEntityByUserId(string $userId): ?UserEntity
    {
        return $this->userRepository->findOneBy(["userId"=>$userId]);
    }
    
    public function getUserByCaptainProfileId($captainProfileId): ?UserEntity
    {
        return $this->userRepository->getUserByCaptainProfileId($captainProfileId);
    }
    
    public function getUserByStoreProfileId($storeProfileId): ?UserEntity
    {
        return $this->userRepository->getUserByStoreProfileId($storeProfileId);
    }

    public function getUserBySupplierProfileId(int $supplierProfileId): ?UserEntity
    {
        return $this->userRepository->getUserBySupplierProfileId($supplierProfileId);
    }

    public function updateUserVerificationStatus(UserVerificationStatusUpdateRequest $request): string|UserEntity
    {
        $userEntity = $this->userRepository->findOneBy(["id"=>$request->getUser()]);

        if (! $userEntity) {
            return UserReturnResultConstant::USER_NOT_FOUND_RESULT;
        }

        $userEntity = $this->autoMapping->mapToObject(UserVerificationStatusUpdateRequest::class, UserEntity::class, $request, $userEntity);

        $this->entityManager->flush();
        $this->entityManager->clear();

        return $userEntity;
    }
}
