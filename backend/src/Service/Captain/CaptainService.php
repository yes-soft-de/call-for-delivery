<?php

namespace App\Service\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\CaptainEntity;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\Captain\CaptainProfileUpdateRequest;
use App\Request\CaptainFinancialSystem\CaptainFinancialSystemDetailRequest;
use App\Request\Verification\VerificationCreateRequest;
use App\Response\Captain\CaptainProfileResponse;
use App\Response\Captain\CaptainStatusResponse;
use App\Entity\UserEntity;
use App\Request\User\UserRegisterRequest;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemDetailResponse;
use App\Response\User\UserRegisterResponse;
use App\Manager\Captain\CaptainManager;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemDetailService;
use App\Service\FileUpload\UploadFileHelperService;
use App\Service\Rate\RatingService;
use App\Request\Captain\CaptainProfileIsOnlineUpdateByCaptainRequest;
use App\Response\Captain\CaptainIsOnlineResponse;
use App\Service\Verification\VerificationService;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemDetailStatusResponse;

class CaptainService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private CaptainManager $captainManager,
        private UploadFileHelperService $uploadFileHelperService,
        private RatingService $ratingService,
        private VerificationService $verificationService,
        private CaptainFinancialSystemDetailService $captainFinancialSystemDetailService
    )
    {
    }

    public function createCaptainFinancialSystemDetail(int $captainUserId): CaptainFinancialSystemDetailResponse|string
    {
        $request = new CaptainFinancialSystemDetailRequest();

        $request->setCaptain($captainUserId);
        $request->setCaptainFinancialSystemType(CaptainFinancialSystem::CAPTAIN_FINANCIAL_DEFAULT_SYSTEM_CONST);
        $request->setCaptainFinancialSystemId(1);

        return $this->captainFinancialSystemDetailService->createCaptainFinancialSystemDetail($request);
    }

    public function captainRegister(UserRegisterRequest $request): UserRegisterResponse
    {
        $userRegister = $this->captainManager->captainRegister($request);

        if ($userRegister === UserReturnResultConstant::USER_IS_FOUND_RESULT) {

            $user['found'] = UserReturnResultConstant::YES_RESULT;

            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }

        // create verification code for the user
        $this->createVerificationCodeForCaptain($userRegister);
      
        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function createVerificationCodeForCaptain(UserEntity $userEntity)
    {
        $verificationCodeRequest = new VerificationCreateRequest();

        $verificationCodeRequest->setUser($userEntity);

        $this->verificationService->createVerificationCode($verificationCodeRequest);
    }

    public function captainProfileUpdate(CaptainProfileUpdateRequest $request): CaptainProfileResponse
    {
        $captainProfile = $this->captainManager->captainProfileUpdate($request);

        // if this first time of updating captain profile then subscribe with the financial default system
        if ($captainProfile->getCompleteAccountStatus() !== CaptainConstant::COMPLETE_ACCOUNT_STATUS_SYSTEM_FINANCIAL_SELECTED) {
            $captainFinancialSystem = $this->createCaptainFinancialSystemDetail($captainProfile->getCaptainId());

            // if captain subscribed successfully with the financial system, then update completeAccountStatus
            if ($captainFinancialSystem !== CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE) {
                $this->updateCaptainProfileCompleteAccountStatusByCaptainUserId($captainProfile->getCaptainId(),
                    CaptainConstant::COMPLETE_ACCOUNT_STATUS_SYSTEM_FINANCIAL_SELECTED);
            }
        }

        return $this->autoMapping->map(CaptainEntity::class, CaptainProfileResponse::class, $captainProfile);
    }

    public function getCaptainProfile($userId): CaptainProfileResponse
    {
        $item = $this->captainManager->getCaptainProfile($userId);

        if($item) {
            if($item['roomId']) {
            
                $item['roomId'] = $item['roomId']->toBase32();
            }

           $item['images'] = $this->uploadFileHelperService->getImageParams($item['profileImage']);
           $item['mechanicLicense'] = $this->uploadFileHelperService->getImageParams($item['mechanicLicense']);
           $item['identity'] = $this->uploadFileHelperService->getImageParams($item['identity']);
           $item['drivingLicence'] = $this->uploadFileHelperService->getImageParams($item['drivingLicence']);

           $item['averageRating'] = $this->ratingService->getAverageRating($userId);
        }

        return $this->autoMapping->map('array', CaptainProfileResponse::class, $item);
    }

    public function getCompleteAccountStatusOfCaptainProfile(string $storeOwnerId): ?array
    {
        return $this->captainManager->getCompleteAccountStatusOfCaptainProfile($storeOwnerId);
    }

    public function captainProfileCompleteAccountStatusUpdate(CompleteAccountStatusUpdateRequest $request): CaptainEntity|string
    {
        return $this->captainManager->captainProfileCompleteAccountStatusUpdate($request);
    }
 
    public function captainIsActive($captainId): ?CaptainStatusResponse
    {
        $captainStatus = $this->captainManager->captainIsActive($captainId);

        return $this->autoMapping->map('array', CaptainStatusResponse::class, $captainStatus);
    }
 
    public function updateIsOnline(CaptainProfileIsOnlineUpdateByCaptainRequest $request): ?CaptainIsOnlineResponse
    {
        $captainStatus = $this->captainManager->updateIsOnline($request);

        return $this->autoMapping->map(CaptainEntity::class, CaptainIsOnlineResponse::class, $captainStatus);
    }
 
    public function getCaptain(int $captainProfileId): ?array
    {
        $captainResult = $this->captainManager->getCaptain($captainProfileId);

        if (!empty($captainResult)) {
            $captainResult['averageRating'] = $this->ratingService->getAverageRating($captainResult['captainId']);
        }

        return $captainResult;
    }

     public function getCaptainFinancialSystemStatus(int $captainId): ?CaptainFinancialSystemDetailStatusResponse
     {
         $captainStatus = $this->captainManager->getCaptainFinancialSystemStatus($captainId);

         return $this->autoMapping->map('array', CaptainFinancialSystemDetailStatusResponse::class, $captainStatus);
     }

    public function deleteCaptainProfileByCaptainId(int $captainId): ?CaptainEntity
    {
        return $this->captainManager->deleteCaptainProfileByCaptainId($captainId);
    }

    public function getCaptainProfileByUserId(int $userId): ?CaptainEntity
    {
        return $this->captainManager->getCaptainProfileByUserId($userId);
    }

    // get captain specific info for order by id response for admin
    public function getCaptainInfoForAdmin(int $captainProfileId): ?array
    {
        $captainResult = $this->captainManager->getCaptainForAdmin($captainProfileId);

        if (! empty($captainResult)) {
            $captainResult['images'] = $this->uploadFileHelperService->getImageParams($captainResult['images']);

            $captainResult['averageRating'] = $this->ratingService->getAverageRating($captainResult['captainId']);
        }

        return $captainResult;
    }

    public function getCaptainNameByCaptainUserId(int $captainUserId): string
    {
        $captainProfile = $this->captainManager->getCaptainProfileByUserId($captainUserId);

        if ($captainProfile) {
            return $captainProfile->getCaptainName();
        }

        return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
    }

    public function getCaptainProfileIdByCaptainUserId(int $userId): int|string
    {
        $captainProfile = $this->captainManager->getCaptainProfileByUserId($userId);

        if (! $captainProfile) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        return $captainProfile->getId();
    }

    public function updateCaptainProfileCompleteAccountStatusByCaptainUserId(int $captainUserId, string $completeAccountStatus): CaptainEntity|string
    {
        $request = new CompleteAccountStatusUpdateRequest();

        $request->setUserId($captainUserId);
        $request->setCompleteAccountStatus($completeAccountStatus);

        return $this->captainProfileCompleteAccountStatusUpdate($request);
    }
}
