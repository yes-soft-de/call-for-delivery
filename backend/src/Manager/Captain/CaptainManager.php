<?php

namespace App\Manager\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\CaptainEntity;
use App\Repository\CaptainEntityRepository;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\Captain\CaptainProfileUpdateRequest;
use App\Request\User\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\User\UserManager;
use App\Constant\ChatRoom\ChatRoomConstant;

class CaptainManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private UserManager $userManager;
    private CaptainEntityRepository $captainEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserManager $userManager, CaptainEntityRepository $captainEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->userManager = $userManager;
        $this->captainEntityRepository = $captainEntityRepository;
    }

    public function captainRegister(UserRegisterRequest $request): mixed
    {
        $user = $this->userManager->getUserByUserId($request->getUserId());

        if (! $user) {
            $request->setRoles(["ROLE_CAPTAIN", "ROLE_USER"]);

            $userRegister = $this->userManager->createUser($request, ChatRoomConstant::ADMIN_CAPTAIN);

            if ($userRegister) {
             
                return $this->createProfile($request, $userRegister);
            }

            return UserReturnResultConstant::USER_IS_NOT_CREATED_RESULT;
        } 
        
        return $this->createProfileWithUserFound($user, $request);
        
    }

    public function createProfile(UserRegisterRequest $request, $userRegister): mixed
    {
        $captainProfile = $this->captainEntityRepository->getCaptainByCaptainId($request->getUserID());

        if (! $captainProfile) {
            $captainProfile = $this->autoMapping->map(UserRegisterRequest::class, CaptainEntity::class, $request);
          //TODO change to CAPTAIN_INACTIVE
            $captainProfile->setStatus(CaptainConstant::CAPTAIN_ACTIVE);
            $captainProfile->setCaptainId($userRegister->getId());
            $captainProfile->setCaptainName(0);
            $captainProfile->setIsOnline(CaptainConstant::CAPTAIN_ONLINE_TRUE);
            $captainProfile->setCompleteAccountStatus(CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED);

            $this->entityManager->persist($captainProfile);
            $this->entityManager->flush();
        }

        return $userRegister;
    }

    public function createProfileWithUserFound($user, UserRegisterRequest $request): string
    {
        $captainProfile = $this->captainEntityRepository->getCaptainByCaptainId($user['id']);

        if (! $captainProfile) {
            $captainProfile = $this->autoMapping->map(UserRegisterRequest::class, CaptainEntity::class, $request);

            //TODO change to CAPTAIN_INACTIVE
            $captainProfile->setStatus(CaptainConstant::CAPTAIN_ACTIVE);
            $captainProfile->setCaptainId($user['id']);
            $captainProfile->setCaptainName(0);
            $captainProfile->setIsOnline(CaptainConstant::CAPTAIN_ONLINE_TRUE);
            $captainProfile->setCompleteAccountStatus(CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED);

            $this->entityManager->persist($captainProfile);
            $this->entityManager->flush();
        }

        return UserReturnResultConstant::USER_IS_FOUND_RESULT;
    }

    public function captainProfileUpdate(CaptainProfileUpdateRequest $request): mixed
    {
        $item = $this->captainEntityRepository->getUserProfile($request->getCaptainId());

        if ($item) {
            if ($request->getCaptainName() === null) {
                $request->setCaptainName($item->getCaptainName());
            }

            $item = $this->autoMapping->mapToObject(CaptainProfileUpdateRequest::class, CaptainEntity::class, $request, $item);

            if($item->getCompleteAccountStatus() === CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED) {
                $item->setCompleteAccountStatus(CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_COMPLETED);
            }

            $this->entityManager->flush();

            return $item;
        }
    }

    public function getCaptainProfile($userId): ?array
    {
        return $this->captainEntityRepository->getCaptainByCaptainId($userId);
    }

    public function getCompleteAccountStatusOfCaptainProfile($storeOwnerId): ?array
    {
        return $this->captainEntityRepository->getCompleteAccountStatusByCaptainId($storeOwnerId);
    }

    public function captainProfileCompleteAccountStatusUpdate(CompleteAccountStatusUpdateRequest $request): CaptainEntity|string
    {
        if(! $this->checkCompleteAccountStatusValidity($request->getCompleteAccountStatus())) {
            return CaptainConstant::WRONG_COMPLETE_ACCOUNT_STATUS;

        } else {
            $captainProfile = $this->captainEntityRepository->getUserProfile($request->getUserId());

            if ($captainProfile) {
                $captainProfile = $this->autoMapping->mapToObject(CompleteAccountStatusUpdateRequest::class, CaptainEntity::class, $request, $captainProfile);

                $this->entityManager->flush();

                return $captainProfile;
            }
        }
    }

    public function checkCompleteAccountStatusValidity(string $completeAccountStatus): bool
    {
        if ($completeAccountStatus !== CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED && $completeAccountStatus !== CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_COMPLETED &&
            $completeAccountStatus !== CaptainConstant::COMPLETE_ACCOUNT_STATUS_SUBSCRIPTION_CREATED && $completeAccountStatus !== CaptainConstant::COMPLETE_ACCOUNT_STATUS_BRANCH_CREATED) {
            return false;
        }

        return true;
    }
    
    public function captainIsActive($captainId): ?array
    {
        return $this->captainEntityRepository->captainIsActive($captainId);
    }
    
    public function getCaptainProfileByUserId($captainId): ?CaptainEntity
    {
        return $this->captainEntityRepository->findOneBy(["captainId" => $captainId]);
    }
}
