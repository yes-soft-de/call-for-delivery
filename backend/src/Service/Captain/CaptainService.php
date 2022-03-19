<?php

namespace App\Service\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\CaptainEntity;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\Captain\CaptainProfileUpdateRequest;
use App\Response\Captain\CaptainProfileResponse;
use App\Response\Captain\CaptainStatusResponse;
use App\Entity\UserEntity;
use App\Request\User\UserRegisterRequest;
use App\Response\User\UserRegisterResponse;
use App\Manager\Captain\CaptainManager;
use App\Service\FileUpload\UploadFileHelperService;

class CaptainService
{
    private AutoMapping $autoMapping;
    private CaptainManager $captainManager;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, CaptainManager $captainManager, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->captainManager = $captainManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
    }

    public function captainRegister(UserRegisterRequest $request): UserRegisterResponse
    {
        $userRegister = $this->captainManager->captainRegister($request);

        if ($userRegister === UserReturnResultConstant::USER_IS_FOUND_RESULT) {

            $user['found'] = UserReturnResultConstant::YES_RESULT;

            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }
      
        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function captainProfileUpdate(CaptainProfileUpdateRequest $request): CaptainProfileResponse
    {
        $item = $this->captainManager->captainProfileUpdate($request);

        return $this->autoMapping->map(CaptainEntity::class, CaptainProfileResponse::class, $item);
    }

    public function getCaptainProfile($userId)
    {
        $item = $this->captainManager->getCaptainProfile($userId);

        if($item['roomId']) {
          
            $item['roomId'] = $item['roomId']->toBase32();
        }

        $item['images'] = $this->uploadFileHelperService->getImageParams($item['images']);
        $item['mechanicLicense'] = $this->uploadFileHelperService->getImageParams($item['mechanicLicense']);
        $item['identity'] = $this->uploadFileHelperService->getImageParams($item['identity']);
        $item['drivingLicence'] = $this->uploadFileHelperService->getImageParams($item['drivingLicence']);

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

        return $this->autoMapping->map('array',CaptainStatusResponse::class, $captainStatus);
     }

}
