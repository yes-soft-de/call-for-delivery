<?php

namespace App\Manager\Admin\CaptainPayment;

use App\AutoMapping;
use App\Entity\CaptainPaymentToCompanyEntity;
use App\Repository\CaptainPaymentToCompanyEntityRepository;
use App\Request\Admin\CaptainPayment\AdminCaptainPaymentCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\Captain\CaptainManager;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Payment\PaymentConstant;
use App\Manager\Admin\CaptainAmountFromOrderCash\AdminCaptainAmountFromOrderCashManager;
use App\Request\Admin\CaptainPayment\AdminCaptainPaymentToCompanyForOrderCashCreateRequest;
use App\Constant\Order\OrderAmountCashConstant;

class AdminCaptainPaymentToCompanyManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private CaptainPaymentToCompanyEntityRepository $captainPaymentToCompanyEntityRepository;
    private CaptainManager $captainManager;
    private AdminCaptainAmountFromOrderCashManager $adminCaptainAmountFromOrderCashManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CaptainPaymentToCompanyEntityRepository $captainPaymentToCompanyEntityRepository, CaptainManager $captainManager, AdminCaptainAmountFromOrderCashManager $adminCaptainAmountFromOrderCashManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainPaymentToCompanyEntityRepository = $captainPaymentToCompanyEntityRepository;
        $this->captainManager = $captainManager;
        $this->adminCaptainAmountFromOrderCashManager = $adminCaptainAmountFromOrderCashManager;

    }

    public function createCaptainPaymentToCompany(AdminCaptainPaymentToCompanyForOrderCashCreateRequest $request): CaptainPaymentToCompanyEntity|string
    {
        $captain = $this->captainManager->getCaptainProfileById($request->getCaptain());
       
        if(! $captain) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        $request->setCaptain($captain);

        $amountFromOrderCash = $this->adminCaptainAmountFromOrderCashManager->getCaptainAmountFromOrderCashBySpecificDateOnUnpaidCondition($request->getFromDate(), $request->getToDate(), $request->getCaptain()->getId());

        if($amountFromOrderCash) {
            $captainPaymentToCompanyEntity = $this->autoMapping->map(AdminCaptainPaymentToCompanyForOrderCashCreateRequest::class, CaptainPaymentToCompanyEntity::class, $request);

            $this->entityManager->persist($captainPaymentToCompanyEntity);
            $this->entityManager->flush();
    
            $this->adminCaptainAmountFromOrderCashManager->updateFlagBySpecificDate($amountFromOrderCash, OrderAmountCashConstant::ORDER_PAID_FLAG_YES, $captainPaymentToCompanyEntity, false);
         
            return $captainPaymentToCompanyEntity;
        }
  
        return OrderAmountCashConstant::NOT_ORDER_CASH;        
    }

    public function deleteCaptainPaymentToCompany($id): CaptainPaymentToCompanyEntity|string
    {
        $captainPaymentToCompanyEntity = $this->captainPaymentToCompanyEntityRepository->find($id);

        $this->adminCaptainAmountFromOrderCashManager->getCaptainAmountFromOrderCashByCaptainPaymentToCompanyId($captainPaymentToCompanyEntity);

        if (! $captainPaymentToCompanyEntity) {     
            
            return PaymentConstant::PAYMENT_NOT_EXISTS;
        }
       
        $this->entityManager->remove($captainPaymentToCompanyEntity);
        $this->entityManager->flush();
       
        return $captainPaymentToCompanyEntity;
    }

    public function getAllCaptainPaymentsToCompany(int $captainId): ?array
    {
        return $this->captainPaymentToCompanyEntityRepository->getAllCaptainPaymentsToCompany($captainId);
    }

    public function getSumPaymentsToCompany(int $captainId): ?array
    {
        return $this->captainPaymentToCompanyEntityRepository->getSumPayments($captainId);
    }

    public function  getSumPaymentsToCompanyInSpecificDate(int $captainId, string $fromDate, string $toDate): ?array
    {
        return $this->captainPaymentToCompanyEntityRepository->getSumPaymentsToCompanyInSpecificDate($captainId, $fromDate, $toDate);
    }
}
