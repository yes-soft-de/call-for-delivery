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

class AdminCaptainPaymentToCompanyManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private CaptainPaymentToCompanyEntityRepository $captainPaymentToCompanyEntityRepository;
    private CaptainManager $captainManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CaptainPaymentToCompanyEntityRepository $captainPaymentToCompanyEntityRepository, CaptainManager $captainManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainPaymentToCompanyEntityRepository = $captainPaymentToCompanyEntityRepository;
        $this->captainManager = $captainManager;
    }

    public function createCaptainPaymentToCompany(AdminCaptainPaymentCreateRequest $request): CaptainPaymentToCompanyEntity|string
    {
        $captain = $this->captainManager->getCaptainProfileById($request->getCaptain());
       
        if(! $captain) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        $request->setCaptain($captain);

        $captainPaymentToCompanyEntity = $this->autoMapping->map(AdminCaptainPaymentCreateRequest::class, CaptainPaymentToCompanyEntity::class, $request);

        $this->entityManager->persist($captainPaymentToCompanyEntity);
        $this->entityManager->flush();

        return $captainPaymentToCompanyEntity;
    }

    public function deleteCaptainPaymentToCompany($id): CaptainPaymentToCompanyEntity|string
    {
        $captainPaymentToCompanyEntity = $this->captainPaymentToCompanyEntityRepository->find($id);

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
}
