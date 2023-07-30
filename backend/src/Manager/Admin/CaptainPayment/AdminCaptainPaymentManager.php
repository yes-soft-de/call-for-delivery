<?php

namespace App\Manager\Admin\CaptainPayment;

use App\AutoMapping;
use App\Constant\CaptainPayment\PaymentToCaptain\CaptainPaymentResultConstant;
use App\Entity\CaptainPaymentEntity;
use App\Repository\CaptainPaymentEntityRepository;
use App\Request\Admin\CaptainPayment\AdminCaptainPaymentCreateRequest;
use App\Request\Admin\CaptainPayment\PaymentToCaptain\CaptainPaymentAmountAndNoteUpdateByAdminRequest;
use App\Request\Admin\CaptainPayment\PaymentToCaptain\CaptainPaymentDeleteByAdminRequest;
use App\Request\Admin\CaptainPayment\PaymentToCaptain\CaptainPaymentFilterByAdminRequest;
use App\Request\Admin\CaptainPayment\PaymentToCaptain\CaptainPaymentForCaptainFinancialDailyCreateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\Captain\CaptainManager;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Payment\PaymentConstant;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialDuesManager;

class AdminCaptainPaymentManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private CaptainPaymentEntityRepository $captainPaymentEntityRepository,
        private CaptainManager $captainManager,
        private AdminCaptainFinancialDuesManager $adminCaptainFinancialDuesManager)
    {
    }

    public function createCaptainPayment(AdminCaptainPaymentCreateRequest $request): CaptainPaymentEntity|string
    {
        $captain = $this->captainManager->getCaptainProfileById($request->getCaptain());
       
        if (! $captain) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        $captainFinancialDuesEntity = $this->adminCaptainFinancialDuesManager->getCaptainFinancialDuesById($request->getCaptainFinancialDuesId());

        $request->setCaptain($captain);

        $captainPaymentEntity = $this->autoMapping->map(AdminCaptainPaymentCreateRequest::class, CaptainPaymentEntity::class, $request);
        $captainPaymentEntity->setCaptainFinancialDues($captainFinancialDuesEntity);

        $this->entityManager->persist($captainPaymentEntity);
        $this->entityManager->flush();

        $differenceAmount = ($captainFinancialDuesEntity->getAmount() - $captainFinancialDuesEntity->getAmountForStore())
            - $captainPaymentEntity->getAmount();

        // End the captain financial due, in order to create a new one
        $this->adminCaptainFinancialDuesManager->endCaptainFinancialDue($captainFinancialDuesEntity);

        // Create new captain financial due
        $this->adminCaptainFinancialDuesManager->createNewCaptainFinancialDueByAdmin($captain, $differenceAmount);
       
        return $captainPaymentEntity;
    }

    /**
     * Delete payment to captain linked with captain financial due (not with captain financial daily)
     */
    public function deleteCaptainPayment($id): CaptainPaymentEntity|string|int
    {
        $captainPaymentEntity = $this->captainPaymentEntityRepository->find($id);

        if (! $captainPaymentEntity) {
            return PaymentConstant::PAYMENT_NOT_EXISTS;
        }

        if ($captainPaymentEntity->getCaptainFinancialDailyEntity()) {
            return CaptainPaymentResultConstant::CAPTAIN_PAYMENT_LINKED_TO_CAPTAIN_FINANCIAL_DAILY_CONST;
        }
       
        $this->entityManager->remove($captainPaymentEntity);
        $this->entityManager->flush();
       
        return $captainPaymentEntity;
    }

    public function getAllCaptainPayments(int $captainId): array
    {
        return $this->captainPaymentEntityRepository->getAllCaptainPayments($captainId);
    }

    public function getSumPaymentsToCaptainByCaptainFinancialDuesId(int $captainFinancialDuesId): ?array
    {
        return $this->captainPaymentEntityRepository->getSumPaymentsToCaptainByCaptainFinancialDuesId($captainFinancialDuesId);
    }

    public function createCaptainPaymentForCaptainFinancialDailyAmount(CaptainPaymentForCaptainFinancialDailyCreateByAdminRequest $request): CaptainPaymentEntity
    {
        $captainPaymentEntity = $this->autoMapping->map(CaptainPaymentForCaptainFinancialDailyCreateByAdminRequest::class,
            CaptainPaymentEntity::class, $request);

        $this->entityManager->persist($captainPaymentEntity);
        $this->entityManager->flush();

        return $captainPaymentEntity;
    }

    /**
     * Delete payment to captain linked with captain financial daily (not with captain financial due)
     */
    public function deleteCaptainPaymentRelatedToCaptainFinancialDailyAmount(CaptainPaymentDeleteByAdminRequest $request): int|CaptainPaymentEntity
    {
        $captainPaymentEntity = $this->captainPaymentEntityRepository->findOneBy(['id' => $request->getId()]);

        if (! $captainPaymentEntity) {
            return CaptainPaymentResultConstant::CAPTAIN_PAYMENT_NOT_EXIST;
        }

        // Make sure the payment isn't linked to captain financial due
        if ($captainPaymentEntity->getCaptainFinancialDues()) {
            return CaptainPaymentResultConstant::CAPTAIN_PAYMENT_LINKED_TO_CAPTAIN_FINANCIAL_DUE_CONST;
        }

        $this->entityManager->remove($captainPaymentEntity);
        $this->entityManager->flush();

        return $captainPaymentEntity;
    }

    public function updateCaptainPaymentAmountAndNoteByAdmin(CaptainPaymentAmountAndNoteUpdateByAdminRequest $request): int|CaptainPaymentEntity
    {
        $captainPaymentEntity = $this->captainPaymentEntityRepository->findOneBy(['id' => $request->getId()]);

        if (! $captainPaymentEntity) {
            return CaptainPaymentResultConstant::CAPTAIN_PAYMENT_NOT_EXIST;
        }

        $captainPaymentEntity = $this->autoMapping->mapToObject(CaptainPaymentAmountAndNoteUpdateByAdminRequest::class,
            CaptainPaymentEntity::class, $request, $captainPaymentEntity);

        $this->entityManager->flush();

        return $captainPaymentEntity;
    }

    public function filterCaptainPaymentByAdmin(CaptainPaymentFilterByAdminRequest $request): array
    {
        return $this->captainPaymentEntityRepository->filterCaptainPaymentByAdmin($request);
    }

    /**
     * epic 13
     */
    public function filterCaptainPaymentByAdminV2(CaptainPaymentFilterByAdminRequest $request): array
    {
        return $this->captainPaymentEntityRepository->filterCaptainPaymentByAdminV2($request);
    }

    public function getCaptainPaymentSumByCaptainProfileIdAndCaptainFinancialDemand(int $captainProfileId): array
    {
        return $this->captainPaymentEntityRepository->getCaptainPaymentSumByCaptainProfileIdAndCaptainFinancialDemand($captainProfileId);
    }

    public function getLastCaptainPaymentByCaptainProfileId(int $captainProfileId): array
    {
        return $this->captainPaymentEntityRepository->getLastCaptainPaymentByCaptainProfileId($captainProfileId);
    }
}
