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

class CaptainService
{
    private AutoMapping $autoMapping;
    private CaptainManager $captainManager;

    public function __construct(AutoMapping $autoMapping, CaptainManager $captainManager)
    {
        $this->autoMapping = $autoMapping;
        $this->captainManager = $captainManager;
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
