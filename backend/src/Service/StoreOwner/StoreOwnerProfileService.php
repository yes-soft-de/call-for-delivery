<?php

namespace App\Service\StoreOwner;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Request\StoreOwner\StoreOwnerProfileUpdateRequest;
use App\Response\StoreOwner\StoreOwnerProfileResponse;
use App\Service\User\UserService;
use App\Entity\UserEntity;
use App\Request\User\UserRegisterRequest;
use App\Response\User\UserRegisterResponse;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class StoreOwnerProfileService
{
    private $autoMapping;

    public function __construct( AutoMapping $autoMapping, StoreOwnerProfileManager $storeOwnerProfileManager,  ParameterBagInterface $params)
    {
        $this->params = $params->get('upload_base_url') . '/';
        $this->autoMapping = $autoMapping;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
    }

    public function storeOwnerRegister(UserRegisterRequest $request)
    {
        //TODO Use roomId (uuid) new feature of symfony .
        $userRegister = $this->storeOwnerProfileManager->storeOwnerRegister($request);

        if ($userRegister == "user is found") {
            $user['found']="yes";
            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }
      
        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function storeOwnerProfileUpdate(StoreOwnerProfileUpdateRequest $request)
    {
        $item = $this->storeOwnerProfileManager->storeOwnerProfileUpdate($request);

        return $this->autoMapping->map(StoreOwnerProfileEntity::class, StoreOwnerProfileResponse::class, $item);
    }

    public function getStoreOwnerProfile($userID)
    {
        $response = null;

        $item = $this->storeOwnerProfileManager->getStoreProfileByStoreID($userID);

        if($item)
        {
            $item['image'] = $this->getImageParams($item['image'], $this->params.$item['image'], $this->params);

            $response = $this->autoMapping->map('array', StoreOwnerProfileResponse::class, $item);
        }

        return $response;
    }

    public function getImageParams($imageURL, $image, $baseURL):array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }

}
