<?php

namespace App\Service\CaptainFinancialSystem;

//use App\AutoMapping;
//use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemDetailManager;
//use App\Manager\CaptainFinancialSystem\CaptainFinancialDuesManager;
//use DateTime;
//use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
//use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
//use App\Entity\CaptainFinancialDuesEntity;
//use App\Response\CaptainFinancialSystem\CaptainStopFinancialSystemAndFinancialCycleResponse;
//use App\Service\Notification\NotificationFirebaseService;
//use App\Service\CaptainFinancialSystem\CaptainFinancialDuesService;

/**
 * The service responsible only for stopping captain financial cycle
 * This had been commented out currently but we may need it in the future
 */
class CaptainStopFinancialSystemAndFinancialCycleService
{
    public function __construct(
//        private AutoMapping $autoMapping,
//        private CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager,
//        private CaptainFinancialDuesManager $captainFinancialDuesManager,
//        private NotificationFirebaseService $notificationFirebaseService,
//        private CaptainFinancialDuesService $captainFinancialDuesService
    )
    {
    }

//    public function stopFinancialSystemAndFinancialCycle(int $userId)
//    {
//        //get Latest Captain Financial Dues
//        $captainFinancialDues = $this->captainFinancialDuesManager->getLatestCaptainFinancialDuesByUserId($userId);
//
//        if ($captainFinancialDues) {
//            if ($captainFinancialDues->getState() === CaptainFinancialDues::FINANCIAL_STATE_ACTIVE) {
//                //calculating financial dues the final
//                $this->captainFinancialDuesService->captainFinancialDues($userId);
//            }
//
//            //End of the current financial cycle
//            $captainFinancialDues->setState(CaptainFinancialDues::FINANCIAL_STATE_INACTIVE);
//            $endDate = new DateTime('now');
//            $captainFinancialDues->setEndDate($endDate->format('y-m-d'));
//            $captainFinancialDues->setCaptainStoppedFinancialCycle(true);
//
//            $this->captainFinancialDuesManager->updateCaptainFinancialDues($captainFinancialDues);
//            //Cancel approval of the chosen financial system
//            $this->captainFinancialSystemDetailManager->updateCaptainFinancialSystemDetailByCaptainId($captainFinancialDues->getCaptain()->getId(), CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_INACTIVE);
//
//             //create firebase notification to admin
//             try{
//                $this->notificationFirebaseService->notificationWhenCaptainStopFinancialCycle($captainFinancialDues->getCaptain()->getId(), $captainFinancialDues->getCaptain()->getCaptainName(), $captainFinancialDues->getId());
//              }
//             catch (\Exception $e){
//                  error_log($e);
//              }
//        }
//
//        return $this->autoMapping->map(CaptainFinancialDuesEntity::class, CaptainStopFinancialSystemAndFinancialCycleResponse::class, $captainFinancialDues);
//    }
}
