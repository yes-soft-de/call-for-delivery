<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialDuesManager;
use App\Entity\CaptainFinancialDuesEntity;
use App\Response\CaptainFinancialSystem\CaptainStopFinancialSystemAndFinancialCycleResponse;
use App\Service\Notification\NotificationFirebaseService;
use App\Request\Admin\CaptainFinancialSystem\ApprovalOrRefusalFinancialSystemAndFinancialCycleByAdminRequest;
use App\Constant\Notification\NotificationFirebaseConstant;
use App\Service\Notification\NotificationLocalService;
use App\Constant\Notification\NotificationConstant;

class AdminStopFinancialSystemAndFinancialCycleService
{
    private AdminCaptainFinancialDuesManager $adminCaptainFinancialDuesManager;
    private AutoMapping $autoMapping;
    private NotificationFirebaseService $notificationFirebaseService;
    private NotificationLocalService $notificationLocalService;

    public function __construct(AutoMapping $autoMapping, AdminCaptainFinancialDuesManager $adminCaptainFinancialDuesManager, NotificationFirebaseService $notificationFirebaseService, NotificationLocalService $notificationLocalService)
    {
        $this->adminCaptainFinancialDuesManager = $adminCaptainFinancialDuesManager;
        $this->autoMapping = $autoMapping;
        $this->notificationFirebaseService = $notificationFirebaseService;
        $this->notificationLocalService = $notificationLocalService;
    }
    //captainFinancialDuesId
    public function approvalOrRefusalFinancialSystemAndFinancialCycle(ApprovalOrRefusalFinancialSystemAndFinancialCycleByAdminRequest $request)
    { 
        $captainFinancialDues = $this->adminCaptainFinancialDuesManager->getCaptainFinancialDuesById($request->getId());
       
        if ($request->getState() === true) {
           //create firebase notification to captain
           try{
              $this->notificationFirebaseService->notificationToUserWithoutOrderByUserId($captainFinancialDues?->getCaptain()->getCaptainId(), NotificationFirebaseConstant::PLEASE_RECEIVE_DUES.' '.$request->getDate());
            }
           catch (\Exception $e){
              error_log($e);
            }
            //create local notification to captain
            $this->notificationLocalService->createNotificationLocal($captainFinancialDues?->getCaptain()->getCaptainId(), NotificationConstant::TITLE_OK, NotificationConstant::PLEASE_RECEIVE_DUES.' '.$request->getDate());
            return $this->autoMapping->map(CaptainFinancialDuesEntity::class, CaptainStopFinancialSystemAndFinancialCycleResponse::class, $captainFinancialDues);
        }
       
    }
}
