<?php

namespace App\Service\StoreOwner;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Request\StoreOwner\StoreOwnerCompleteAccountStatusUpdateRequest;
use App\Request\StoreOwner\StoreOwnerProfileUpdateRequest;
use App\Response\StoreOwner\StoreOwnerCompleteAccountStatusGetResponse;
use App\Response\StoreOwner\StoreOwnerCompleteAccountStatusUpdateResponse;
use App\Response\StoreOwner\StoreOwnerProfileResponse;
use App\Entity\UserEntity;
use App\Request\User\UserRegisterRequest;
use App\Response\User\UserRegisterResponse;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class StoreOwnerProfileService
{
    private $autoMapping;
    private $params;
    private $storeOwnerProfileManager;

    public function __construct(AutoMapping $autoMapping, StoreOwnerProfileManager $storeOwnerProfileManager, ParameterBagInterface $params)
    {
        $this->params = $params->get('upload_base_url') . '/';
        $this->autoMapping = $autoMapping;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
    }

    public function storeOwnerRegister(UserRegisterRequest $request): UserRegisterResponse
    {
        //TODO Use roomId (uuid) new feature of symfony .
        $userRegister = $this->storeOwnerProfileManager->storeOwnerRegister($request);

        if ($userRegister === UserReturnResultConstant::USER_IS_FOUND_RESULT) {
            $user['found'] = UserReturnResultConstant::YES_RESULT;
            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }
      
        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function storeOwnerProfileUpdate(StoreOwnerProfileUpdateRequest $request): StoreOwnerProfileResponse
    {
        $item = $this->storeOwnerProfileManager->storeOwnerProfileUpdate($request);

        return $this->autoMapping->map(StoreOwnerProfileEntity::class, StoreOwnerProfileResponse::class, $item);
    }

    public function getStoreOwnerProfile($userId)
    {
        $item = $this->storeOwnerProfileManager->getStoreProfileByStoreId($userId);

        if($item)
        {
            $item['images'] = $this->getImageParams($item['images'], $this->params.$item['images'], $this->params);
        }

        return $this->autoMapping->map('array', StoreOwnerProfileResponse::class, $item);
    }

    public function getCompleteAccountStatusByStoreOwnerId($storeOwnerId): StoreOwnerCompleteAccountStatusGetResponse
    {
        $completeAccountStatusResult = $this->storeOwnerProfileManager->getCompleteAccountStatusByStoreOwnerId($storeOwnerId);

        return $this->autoMapping->map('array', StoreOwnerCompleteAccountStatusGetResponse::class, $completeAccountStatusResult);
    }

    public function storeOwnerProfileCompleteAccountStatusUpdate(StoreOwnerCompleteAccountStatusUpdateRequest $request): StoreOwnerCompleteAccountStatusUpdateResponse|string
    {
        $storeOwnerProfileResult = $this->storeOwnerProfileManager->storeOwnerProfileCompleteAccountStatusUpdate($request);

        if($storeOwnerProfileResult === StoreProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS) {
            return StoreProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS;
        }

        return $this->autoMapping->map(StoreOwnerProfileEntity::class, StoreOwnerCompleteAccountStatusUpdateResponse::class, $storeOwnerProfileResult);
    }

    public function getImageParams($imageURL, $image, $baseURL): array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }
}
