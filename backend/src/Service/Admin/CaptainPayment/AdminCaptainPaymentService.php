<?php

namespace App\Service\Admin\CaptainPayment;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyIsPaidConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Constant\CaptainPayment\PaymentToCaptain\CaptainPaymentResultConstant;
use App\Entity\CaptainEntity;
use App\Entity\CaptainFinancialDailyEntity;
use App\Entity\CaptainPaymentEntity;
use App\Manager\Admin\CaptainPayment\AdminCaptainPaymentManager;
use App\Request\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyIsPaidUpdateByAdminRequest;
use App\Request\Admin\CaptainPayment\AdminCaptainPaymentCreateRequest;
use App\Request\Admin\CaptainPayment\PaymentToCaptain\CaptainPaymentForCaptainFinancialDailyCreateByAdminRequest;
use App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyIsPaidUpdateByAdminResponse;
use App\Response\Admin\CaptainPayment\AdminCaptainPaymentCreateResponse;
use App\Response\Admin\CaptainPayment\AdminCaptainPaymentResponse;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Payment\PaymentConstant;
use App\Response\Admin\CaptainPayment\AdminCaptainPaymentDeleteResponse;
use App\Response\Admin\CaptainPayment\PaymentToCaptain\CaptainPaymentForCaptainFinancialDailyCreateByAdminResponse;
use App\Service\Admin\Captain\AdminCaptainGetService;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialDuesService;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Entity\CaptainFinancialDuesEntity;
use App\Service\Admin\CaptainFinancialSystem\CaptainFinancialDaily\AdminCaptainFinancialDailyGetService;
use App\Service\Admin\CaptainFinancialSystem\CaptainFinancialDaily\AdminCaptainFinancialDailyService;
use Doctrine\ORM\EntityManagerInterface;

class AdminCaptainPaymentService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private AdminCaptainPaymentManager $adminCaptainPaymentManager,
        private AdminCaptainFinancialDuesService $adminCaptainFinancialDuesService,
        private AdminCaptainGetService $adminCaptainGetService,
        private AdminCaptainFinancialDailyGetService $adminCaptainFinancialDailyGetService,
        private AdminCaptainFinancialDailyService $adminCaptainFinancialDailyService
    )
    {
    }

    public function createCaptainPayment(AdminCaptainPaymentCreateRequest $request): AdminCaptainPaymentCreateResponse|string
    {
        $payment = $this->adminCaptainPaymentManager->createCaptainPayment($request);
       
        if($payment === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return $payment;
        }

        return $this->autoMapping->map(CaptainPaymentEntity::class, AdminCaptainPaymentCreateResponse::class, $payment);
    }

    public function deleteCaptainPayment($id): AdminCaptainPaymentDeleteResponse|string
    {
        $payment = $this->adminCaptainPaymentManager->deleteCaptainPayment($id);
      
        if($payment ===  PaymentConstant::PAYMENT_NOT_EXISTS) {
            return $payment;
        }

        $this->updateCaptainFinancialDuesStatus($payment->getCaptainFinancialDues());
       
        return $this->autoMapping->map(CaptainPaymentEntity::class, AdminCaptainPaymentDeleteResponse::class, $payment);
    }

    public function getAllCaptainPayments(int $captainId): array
    {
        $response = [];

        $payments = $this->adminCaptainPaymentManager->getAllCaptainPayments($captainId);

        foreach ($payments as $payment) {
           
            $response[] = $this->autoMapping->map('array', AdminCaptainPaymentResponse::class, $payment);
        }

        return $response;
    }

    public function updateCaptainFinancialDuesStatus(CaptainFinancialDuesEntity $captainFinancialDues): CaptainFinancialDuesEntity
    {
        $sumPayments = [];
       
        $sumPayments = $this->adminCaptainPaymentManager->getSumPaymentsToCaptainByCaptainFinancialDuesId($captainFinancialDues->getId());
       
        if( $captainFinancialDues->getAmount() > 0) {
                
            if( $sumPayments['sumPaymentsToCaptain'] === null || $sumPayments['sumPaymentsToCaptain'] === 0) {

                return $this->adminCaptainFinancialDuesService->updateCaptainFinancialDuesStatus($captainFinancialDues, CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
            }

            if( $sumPayments['sumPaymentsToCaptain'] === $captainFinancialDues->getAmount()) {

                return $this->adminCaptainFinancialDuesService->updateCaptainFinancialDuesStatus($captainFinancialDues, CaptainFinancialDues::FINANCIAL_DUES_PAID);
            }
    
            if( $sumPayments['sumPaymentsToCaptain'] < $captainFinancialDues->getAmount()) {
                return $this->adminCaptainFinancialDuesService->updateCaptainFinancialDuesStatus($captainFinancialDues, CaptainFinancialDues::FINANCIAL_DUES_PARTIALLY_PAID);
    
            }
           
            if( $sumPayments['sumPaymentsToCaptain'] > $captainFinancialDues->getAmount()) {
                return $this->adminCaptainFinancialDuesService->updateCaptainFinancialDuesStatus($captainFinancialDues, CaptainFinancialDues::FINANCIAL_DUES_PAID);
            }
        }
        
        return $captainFinancialDues;
    }

//    public function getCaptainProfileById(int $captainProfileId): CaptainEntity|string
//    {
//        return $this->adminCaptainGetService->getCaptainProfileById($captainProfileId);
//    }

    public function getCaptainFinancialDailyById(int $captainFinancialDailyId): CaptainFinancialDailyEntity|int
    {
        return $this->adminCaptainFinancialDailyGetService->getCaptainFinancialDailyById($captainFinancialDailyId);
    }

    public function initializeAndGetCaptainFinancialDailyIsPaidUpdateByAdminRequest(int $captainFinancialDailyId, int $isPaid): CaptainFinancialDailyIsPaidUpdateByAdminRequest
    {
        $captainFinancialDailyIsPaidUpdateByAdminRequest = new CaptainFinancialDailyIsPaidUpdateByAdminRequest();

        $captainFinancialDailyIsPaidUpdateByAdminRequest->setId($captainFinancialDailyId);
        $captainFinancialDailyIsPaidUpdateByAdminRequest->setIsPaid($isPaid);

        return $captainFinancialDailyIsPaidUpdateByAdminRequest;
    }

    public function updateCaptainFinancialDailyIsPaidAccordingToPaymentAmountAndCaptainFinancialDailyAmount(CaptainFinancialDailyEntity $captainFinancialDailyEntity): int|CaptainFinancialDailyIsPaidUpdateByAdminResponse
    {
        // Check if payment amount equal, bigger, or less than the captain financial daily amount
        $captainPayments = $captainFinancialDailyEntity->getCaptainPayment()->toArray();

        if (count($captainPayments) === 0) {
            // no payments are exists, no need to update isPaid field
            return CaptainPaymentResultConstant::CAPTAIN_PAYMENT_NOT_EXIST;
        }

        // There are payment/s, sum their/its amount
        $paymentSum = 0.0;

        foreach ($captainPayments as $captainPayment) {
            $paymentSum += $captainPayment->getAmount();
        }

        if ($paymentSum > $captainFinancialDailyEntity->getAmount()) {
            $captainFinancialDailyIsPaidUpdateByAdminRequest = $this->initializeAndGetCaptainFinancialDailyIsPaidUpdateByAdminRequest($captainFinancialDailyEntity->getId(),
                CaptainFinancialDailyIsPaidConstant::CAPTAIN_FINANCIAL_DAILY_IS_OVER_PAID_CONST);

            return $this->adminCaptainFinancialDailyService->updateCaptainFinancialDailyIsPaid($captainFinancialDailyIsPaidUpdateByAdminRequest);

        } elseif ($paymentSum === $captainFinancialDailyEntity->getAmount()) {
            $captainFinancialDailyIsPaidUpdateByAdminRequest = $this->initializeAndGetCaptainFinancialDailyIsPaidUpdateByAdminRequest($captainFinancialDailyEntity->getId(),
                CaptainFinancialDailyIsPaidConstant::CAPTAIN_FINANCIAL_DAILY_IS_PAID_CONST);

            return $this->adminCaptainFinancialDailyService->updateCaptainFinancialDailyIsPaid($captainFinancialDailyIsPaidUpdateByAdminRequest);
        }

        $captainFinancialDailyIsPaidUpdateByAdminRequest = $this->initializeAndGetCaptainFinancialDailyIsPaidUpdateByAdminRequest($captainFinancialDailyEntity->getId(),
            CaptainFinancialDailyIsPaidConstant::CAPTAIN_FINANCIAL_DAILY_IS_PAID_PARTIALLY_CONST);

        return $this->adminCaptainFinancialDailyService->updateCaptainFinancialDailyIsPaid($captainFinancialDailyIsPaidUpdateByAdminRequest);
    }

    public function createCaptainPaymentForCaptainFinancialDailyAmount(CaptainPaymentForCaptainFinancialDailyCreateByAdminRequest $request): int|string|CaptainPaymentForCaptainFinancialDailyCreateByAdminResponse
    {
        // First get captain profile entity
        //$captainProfile = $this->getCaptainProfileById($request->getCaptain());

//        if ($captainProfile === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
//            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
//        }

        // Second get captain financial daily entity
        $captainFinancialDaily = $this->getCaptainFinancialDailyById($request->getCaptainFinancialDailyEntity());

        if ($captainFinancialDaily === CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST) {
            return CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST;
        }

        $request->setCaptain($captainFinancialDaily->getCaptainProfile());
        $request->setCaptainFinancialDailyEntity($captainFinancialDaily);

        try {
            $this->entityManager->getConnection()->beginTransaction();

            // Create the captain payment
            $captainPaymentEntity = $this->adminCaptainPaymentManager->createCaptainPaymentForCaptainFinancialDailyAmount($request);

            // Update isPaid field of the captain financial daily
            if ($captainPaymentEntity instanceof CaptainPaymentEntity) {
                $updateIsPaidResult = $this->updateCaptainFinancialDailyIsPaidAccordingToPaymentAmountAndCaptainFinancialDailyAmount($captainFinancialDaily);

                if ($updateIsPaidResult === CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST) {
                    $this->entityManager->getConnection()->rollBack();

                    return CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST;
                }

                $this->entityManager->getConnection()->commit();

                return $this->autoMapping->map(CaptainPaymentEntity::class, CaptainPaymentForCaptainFinancialDailyCreateByAdminResponse::class,
                    $captainPaymentEntity);
            }

            $this->entityManager->getConnection()->rollBack();

            return CaptainPaymentResultConstant::CAPTAIN_PAYMENT_CREATE_FOR_CAPTAIN_FINANCIAL_DAILY_ERROR_CONST;

        } catch (\Exception $e) {
            $this->entityManager->getConnection()->rollBack();
            throw $e;
        }
    }
}
