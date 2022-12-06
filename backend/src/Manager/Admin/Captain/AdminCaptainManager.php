<?php

namespace App\Manager\Admin\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Entity\CaptainEntity;
use App\Repository\CaptainEntityRepository;
use App\Request\Admin\Captain\CaptainProfileStatusUpdateByAdminRequest;
use App\Request\Admin\Captain\CaptainProfileUpdateByAdminRequest;
use App\Request\Admin\Report\CaptainWithDeliveredOrdersDuringSpecificTimeFilterByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminCaptainManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private CaptainEntityRepository $captainEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CaptainEntityRepository $captainEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainEntityRepository = $captainEntityRepository;
    }

    public function getCaptainsProfilesByStatusForAdmin(string $captainProfileStatus): array
    {
        return $this->captainEntityRepository->getCaptainsProfilesByStatusForAdmin($captainProfileStatus);
    }

    public function getCaptainProfileByIdForAdmin(int $captainProfileId): ?array
    {
        $captainProfile = $this->captainEntityRepository->getCaptainProfileByIdForAdmin($captainProfileId);

        if($captainProfile) {
            $captainProfile = $this->getCaptainProfileAndImages($captainProfile);
        }

        return $captainProfile;
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

    public function getCaptainsCountByStatusForAdmin(string $status): int
    {
        return $this->captainEntityRepository->count(['status'=>$status]);
    }

    public function getReadyCaptainsAndCountOfTheirCurrentOrders(): array
    {
        return $this->captainEntityRepository->getReadyCaptainsAndCountOfTheirCurrentOrders();
    }
   
    public function getCaptainProfileById($captainId): ?CaptainEntity
    {
        return $this->captainEntityRepository->find($captainId);
    }

    public function getLastThreeActiveCaptainsProfilesForAdmin(): array
    {
        return $this->captainEntityRepository->getLastThreeActiveCaptainsProfilesForAdmin();
    }

    public function getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByAdmin(): array
    {
        return $this->captainEntityRepository->getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByAdmin();
    }

    //items = captain profile with images
    public function getCaptainProfileAndImages(array $items) : ?array
    {
        $profile = [];

        $profile['captainId'] = $items[0]['captainId'];
        $profile['captainName'] = $items[0]['captainName'];
        $profile['location'] = $items[0]['location'];
        $profile['age'] = $items[0]['age'];
        $profile['car'] = $items[0]['car'];
        $profile['salary'] = $items[0]['salary'];
        $profile['bounce'] = $items[0]['bounce'];
        $profile['phone'] = $items[0]['phone'];
        $profile['isOnline'] = $items[0]['isOnline'];
        $profile['bankName'] = $items[0]['bankName'];
        $profile['bankAccountNumber'] = $items[0]['bankAccountNumber'];
        $profile['stcPay'] = $items[0]['stcPay'];
        $profile['roomId'] = $items[0]['roomId'];
        $profile['status'] = $items[0]['status'];
        $profile['address'] = $items[0]['address'];

        if (array_key_exists("completeAccountStatus", $items[0])) {
            $profile['completeAccountStatus'] = $items[0]['completeAccountStatus'];
        }

        if (array_key_exists("userId", $items[0])) {
            $profile['userId'] = $items[0]['userId'];
        }

        if (array_key_exists("verificationStatus", $items[0])) {
            $profile['verificationStatus'] = $items[0]['verificationStatus'];
        }

        foreach ($items as $captainProfile) {

            if($captainProfile['usedAs'] === ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE) {
                $profile['profileImage'] = $captainProfile['imagePath'];
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

        if(! isset($profile['profileImage'])) {
            $profile['profileImage'] = ImageEntityTypeConstant::IMAGE_NULL;
        }

        if(! isset($profile['drivingLicence'])) {
            $profile['drivingLicence'] = ImageEntityTypeConstant::IMAGE_NULL;
        }

        if(! isset($profile['mechanicLicense'])) {
            $profile['mechanicLicense'] = ImageEntityTypeConstant::IMAGE_NULL;
        }

        if(! isset($profile['identity'])) {
            $profile['identity'] = ImageEntityTypeConstant::IMAGE_NULL;
        }

        return $profile;
    }

    public function getCaptainsRatingsForAdmin(): array
    {
        return $this->captainEntityRepository->getCaptainsRatingsForAdmin();
    }

    public function getCaptainsWhoDeliveredOrdersDuringSpecificTime(CaptainWithDeliveredOrdersDuringSpecificTimeFilterByAdminRequest $request): array
    {
        return $this->captainEntityRepository->getCaptainsWhoDeliveredOrdersDuringSpecificTime($request);
    }
}
