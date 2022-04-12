<?php

namespace App\Service\Account;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Constant\User\UserRoleConstant;
use App\Entity\CaptainEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SupplierProfileEntity;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Response\Account\CompleteAccountStatusGetResponse;
use App\Service\Captain\CaptainService;
use App\Service\StoreOwner\StoreOwnerProfileService;
use App\Service\Supplier\SupplierProfileService;

class AccountService
{
    private AutoMapping $autoMapping;
    private StoreOwnerProfileService $storeOwnerProfileService;
    private CaptainService $captainService;
    private SupplierProfileService $supplierProfileService;

    public function __construct(AutoMapping $autoMapping, StoreOwnerProfileService $storeOwnerProfileService, CaptainService $captainService, SupplierProfileService $supplierProfileService)
    {
        $this->autoMapping = $autoMapping;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
        $this->captainService = $captainService;
        $this->supplierProfileService = $supplierProfileService;
    }

    public function getCompleteAccountStatusByUserId(string $userId, string $userType): ?CompleteAccountStatusGetResponse
    {
        if($userType === UserRoleConstant::STORE_OWNER_USER_TYPE) {
            $completeAccountStatus = $this->storeOwnerProfileService->getCompleteAccountStatusByStoreOwnerId($userId);

            return $this->autoMapping->map('array', CompleteAccountStatusGetResponse::class, $completeAccountStatus);

        } elseif ($userType === UserRoleConstant::CAPTAIN_USER_TYPE) {
            $completeAccountStatus = $this->captainService->getCompleteAccountStatusOfCaptainProfile($userId);

            return $this->autoMapping->map('array', CompleteAccountStatusGetResponse::class, $completeAccountStatus);

        } elseif ($userType === UserRoleConstant::SUPPLIER_USER_TYPE) {
            $completeAccountStatus = $this->supplierProfileService->getCompleteAccountStatusBySupplierId($userId);

            return $this->autoMapping->map('array', CompleteAccountStatusGetResponse::class, $completeAccountStatus);
        }
    }

    public function updateCompleteAccountStatus(CompleteAccountStatusUpdateRequest $request, string $userType): CompleteAccountStatusGetResponse|string|null
    {
        if($userType === UserRoleConstant::STORE_OWNER_USER_TYPE) {
            $storeOwnerProfileResult = $this->storeOwnerProfileService->storeOwnerProfileCompleteAccountStatusUpdate($request);

            if($storeOwnerProfileResult === StoreProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS) {
                return StoreProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS;
            }

            return $this->autoMapping->map(StoreOwnerProfileEntity::class, CompleteAccountStatusGetResponse::class, $storeOwnerProfileResult);

        } elseif ($userType === UserRoleConstant::CAPTAIN_USER_TYPE) {
            $captainProfileResult = $this->captainService->captainProfileCompleteAccountStatusUpdate($request);

            if($captainProfileResult === CaptainConstant::WRONG_COMPLETE_ACCOUNT_STATUS) {
                return CaptainConstant::WRONG_COMPLETE_ACCOUNT_STATUS;
            }

            return $this->autoMapping->map(CaptainEntity::class, CompleteAccountStatusGetResponse::class, $captainProfileResult);

        } elseif ($userType === UserRoleConstant::SUPPLIER_USER_TYPE) {
            $supplierProfileResult = $this->supplierProfileService->supplierProfileCompleteAccountStatusUpdate($request);

            if ($supplierProfileResult === SupplierProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS) {
                return SupplierProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS;
            }

            return $this->autoMapping->map(SupplierProfileEntity::class, CompleteAccountStatusGetResponse::class, $supplierProfileResult);

        }
    }
}
