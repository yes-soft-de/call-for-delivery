<?php

namespace App\Service\Account;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\User\UserRoleConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Response\Account\CompleteAccountStatusGetResponse;
use App\Service\StoreOwner\StoreOwnerProfileService;

class AccountService
{
    private AutoMapping $autoMapping;
    private StoreOwnerProfileService $storeOwnerProfileService;

    public function __construct(AutoMapping $autoMapping, StoreOwnerProfileService $storeOwnerProfileService)
    {
        $this->autoMapping = $autoMapping;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
    }

    public function getCompleteAccountStatusByUserId(string $userId, string $userType): ?CompleteAccountStatusGetResponse
    {
        if($userType === UserRoleConstant::STORE_OWNER_USER_TYPE) {
            $completeAccountStatus = $this->storeOwnerProfileService->getCompleteAccountStatusByStoreOwnerId($userId);

            return $this->autoMapping->map('array', CompleteAccountStatusGetResponse::class, $completeAccountStatus);
        }

        // sections for captain and supplier will be added lately when both entities will be set
    }

    public function updateCompleteAccountStatus(CompleteAccountStatusUpdateRequest $request, string $userType): CompleteAccountStatusGetResponse|string|null
    {
        if($userType === UserRoleConstant::STORE_OWNER_USER_TYPE) {
            $storeOwnerProfileResult = $this->storeOwnerProfileService->storeOwnerProfileCompleteAccountStatusUpdate($request);

            if($storeOwnerProfileResult === StoreProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS) {
                return StoreProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS;
            }

            return $this->autoMapping->map(StoreOwnerProfileEntity::class, CompleteAccountStatusGetResponse::class, $storeOwnerProfileResult);
        }

        // sections for captain and supplier will be added lately when both entities will be set
    }
}
