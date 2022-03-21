<?php

namespace App\Manager\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\CaptainEntity;
use App\Repository\CaptainEntityRepository;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\Admin\Captain\CaptainProfileStatusUpdateByAdminRequest;
use App\Request\Admin\Captain\CaptainProfileUpdateByAdminRequest;
use App\Request\Captain\CaptainProfileUpdateRequest;
use App\Request\User\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\User\UserManager;
use App\Constant\ChatRoom\ChatRoomConstant;
use App\Manager\Image\ImageManager;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;

class CaptainManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private UserManager $userManager;
    private CaptainEntityRepository $captainEntityRepository;
    private ImageManager $imageManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserManager $userManager, CaptainEntityRepository $captainEntityRepository, ImageManager $imageManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->userManager = $userManager;
        $this->captainEntityRepository = $captainEntityRepository;
        $this->imageManager = $imageManager;
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
          
            $captainProfile->setStatus(CaptainConstant::CAPTAIN_INACTIVE);
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

            $captainProfile->setStatus(CaptainConstant::CAPTAIN_INACTIVE);
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

            //save images
            if ($request->getImage()) {
                $this->imageManager->createImage($request->getImage(), $item->getId(), ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);
            }
            if ($request->getDrivingLicence()) {
                $this->imageManager->createImage($request->getDrivingLicence(), $item->getId(), ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_DRIVE_LICENSE_IMAGE);
            }
            if ($request->getMechanicLicense()) {
                $this->imageManager->createImage($request->getMechanicLicense(), $item->getId(), ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_MECHANIC_LICENSE_IMAGE);
            }
            if ($request->getIdentity()) {
                $this->imageManager->createImage($request->getIdentity(), $item->getId(), ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_IDENTITY_IMAGE);
            }
           
            return $item;
        }
    }

    public function getCaptainProfile(int $userId): ?array
    {
        $items = $this->captainEntityRepository->getCaptainByCaptainId($userId);

        if($items) {
            $profile = $this->getCaptainProfileAndImages($items);
        }

        return  $profile;
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

    public function getCaptainsProfilesByStatusForAdmin(string $captainProfileStatus): ?array
    {
        return $this->captainEntityRepository->getCaptainsProfilesByStatusForAdmin($captainProfileStatus);
    }

    public function getCaptainProfileByIdForAdmin(int $captainProfileId): ?array
    {
        $captainProfile = $this->captainEntityRepository->getCaptainProfileByIdForAdmin($captainProfileId);
        
        if($captainProfile) {
            $profile = $this->getCaptainProfileAndImages($captainProfile);
        }

        return  $profile;
    }

    public function updateCaptainProfileStatusByAdmin(CaptainProfileStatusUpdateByAdminRequest $request): string|CaptainEntity
    {
        $captainProfileEntity = $this->captainEntityRepository->find($request->getId());

        if (! $captainProfileEntity) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        $captainProfileEntity = $this->autoMapping->mapToObject(CaptainProfileStatusUpdateByAdminRequest::class, CaptainEntity::class,
            $request, $captainProfileEntity);

        $this->entityManager->flush();

        return $captainProfileEntity;
    }

    public function updateCaptainProfileByAdmin(CaptainProfileUpdateByAdminRequest $request): string|CaptainEntity
    {
        $captainProfileEntity = $this->captainEntityRepository->find($request->getId());

        if (! $captainProfileEntity) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        $captainProfileEntity = $this->autoMapping->mapToObject(CaptainProfileUpdateByAdminRequest::class, CaptainEntity::class,
            $request, $captainProfileEntity);

        if ($captainProfileEntity->getCompleteAccountStatus() === CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED) {
            $captainProfileEntity->setCompleteAccountStatus(CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_COMPLETED);
        }

        $this->entityManager->flush();

        return $captainProfileEntity;
    }

    //items = captain profile with images
    public function getCaptainProfileAndImages(array $items) : ?array
    {
        $profile = [];

        foreach ($items as $captainProfile) {
         
            $profile['captainId'] = $captainProfile['captainId'];
            $profile['captainName'] = $captainProfile['captainName'];
            $profile['location'] = $captainProfile['location'];
            $profile['age'] = $captainProfile['age'];
            $profile['car'] = $captainProfile['car'];
            $profile['salary'] = $captainProfile['salary'];
            $profile['bounce'] = $captainProfile['bounce'];
            $profile['phone'] = $captainProfile['phone'];
            $profile['isOnline'] = $captainProfile['isOnline'];
            $profile['bankName'] = $captainProfile['bankName'];
            $profile['bankAccountNumber'] = $captainProfile['bankAccountNumber'];
            $profile['stcPay'] = $captainProfile['stcPay'];
            $profile['roomId'] = $captainProfile['roomId'];

            if($captainProfile['usedAs'] === ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE) {
              $profile['image'] = $captainProfile['imagePath'];
            }

            if($captainProfile['usedAs'] === ImageUseAsConstant::IMAGE_USE_AS_DRIVE_LICENSE_IMAGE) {
              $profile['drivingLicence'] = $captainProfile['imagePath'];
            }

            if($captainProfile['usedAs'] === ImageUseAsConstant::IMAGE_USE_AS_MECHANIC_LICENSE_IMAGE) {
              $profile['mechanicLicense'] = $captainProfile['imagePath'];
            }

            if($captainProfile['usedAs'] === ImageUseAsConstant::IMAGE_USE_AS_IDENTITY_IMAGE) {
              $profile['identity'] = $captainProfile['imagePath'];
            }
         }

         return $profile;
    }    
}
