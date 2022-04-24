<?php

namespace App\Manager\Admin\CaptainPayment;

use App\AutoMapping;
use App\Entity\CaptainPaymentEntity;
use App\Repository\CaptainPaymentEntityRepository;
use App\Request\Admin\CaptainPayment\AdminCaptainPaymentCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\Captain\CaptainManager;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Payment\PaymentConstant;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialDuesManager;

class AdminCaptainPaymentManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private CaptainPaymentEntityRepository $captainPaymentEntityRepository;
    private CaptainManager $captainManager;
    private AdminCaptainFinancialDuesManager $adminCaptainFinancialDuesManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CaptainPaymentEntityRepository $captainPaymentEntityRepository, CaptainManager $captainManager, AdminCaptainFinancialDuesManager $adminCaptainFinancialDuesManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainPaymentEntityRepository = $captainPaymentEntityRepository;
        $this->captainManager = $captainManager;
        $this->adminCaptainFinancialDuesManager = $adminCaptainFinancialDuesManager;
    }

    public function createCaptainPayment(AdminCaptainPaymentCreateRequest $request): CaptainPaymentEntity|string
    {
        $captain = $this->captainManager->getCaptainProfileById($request->getCaptain());
       
        if(! $captain) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        $captainFinancialDuesEntity = $this->adminCaptainFinancialDuesManager->getCaptainFinancialDuesById($request->getCaptainFinancialDuesId());

        $request->setCaptain($captain);

        $captainPaymentEntity = $this->autoMapping->map(AdminCaptainPaymentCreateRequest::class, CaptainPaymentEntity::class, $request);
        $captainPaymentEntity->setCaptainFinancialDues($captainFinancialDuesEntity);

        $this->entityManager->persist($captainPaymentEntity);
        $this->entityManager->flush();

        $this->adminCaptainFinancialDuesManager->updateCaptainFinancialDuesStatus($captainFinancialDuesEntity, $request->getStatus());
       
        return $captainPaymentEntity;
    }

    public function deleteCaptainPayment($id): CaptainPaymentEntity|string
    {
        $captainPaymentEntity = $this->captainPaymentEntityRepository->find($id);

        if (! $captainPaymentEntity) {     
            
            return PaymentConstant::PAYMENT_NOT_EXISTS;
        }
       
        $this->entityManager->remove($captainPaymentEntity);
        $this->entityManager->flush();
       
        return $captainPaymentEntity;
    }

    public function getAllCaptainPayments(int $captainId): ?array
    {
        return $this->captainPaymentEntityRepository->getAllCaptainPayments($captainId);
    }
}
