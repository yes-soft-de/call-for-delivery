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

class AdminCaptainPaymentManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private CaptainPaymentEntityRepository $captainPaymentEntityRepository;
    private CaptainManager $captainManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CaptainPaymentEntityRepository $captainPaymentEntityRepository, CaptainManager $captainManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainPaymentEntityRepository = $captainPaymentEntityRepository;
        $this->captainManager = $captainManager;
    }

    public function createCaptainPayment(AdminCaptainPaymentCreateRequest $request): CaptainPaymentEntity|string
    {
        $captain = $this->captainManager->getCaptainProfile($request->getCaptain());
       
        if(! $captain) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        $request->setCaptain($captain);

        $captainPaymentEntity = $this->autoMapping->map(AdminCaptainPaymentCreateRequest::class, CaptainPaymentEntity::class, $request);

        $this->entityManager->persist($captainPaymentEntity);
        $this->entityManager->flush();

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
