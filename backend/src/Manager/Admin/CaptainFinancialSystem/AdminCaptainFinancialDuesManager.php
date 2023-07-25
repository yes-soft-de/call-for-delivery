<?php

namespace App\Manager\Admin\CaptainFinancialSystem;

use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Entity\CaptainEntity;
use App\Entity\CaptainFinancialDuesEntity;
use App\Repository\CaptainFinancialDuesEntityRepository;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;

class AdminCaptainFinancialDuesManager
{
    public function __construct(
        private CaptainFinancialDuesEntityRepository $captainFinancialDuesRepository,
        private EntityManagerInterface $entityManager
    )
    {
    }
    
    public function getCaptainFinancialDuesByCaptainId(int $captainId): array
    {
        return $this->captainFinancialDuesRepository->getCaptainFinancialDuesByCaptainId($captainId);
    } 
    
    public function updateCaptainFinancialDuesStatus(CaptainFinancialDuesEntity $captainFinancialDuesEntity, int $status): CaptainFinancialDuesEntity
    {
        $captainFinancialDuesEntity->setStatus($status);

        $this->entityManager->flush();

        return $captainFinancialDuesEntity;
    } 
    
    public function getCaptainFinancialDuesById(int $id): CaptainFinancialDuesEntity
    {
        return $this->captainFinancialDuesRepository->find($id);
    } 
    
    public function getSumCaptainFinancialDuesById(int $id): array
    {
        return $this->captainFinancialDuesRepository->getSumCaptainFinancialDuesById($id);
    } 

    public function stateToActive()
    { 
       $items = $this->captainFinancialDuesRepository->findAll();

       foreach($items as $captainFinancialDuesEntity) {
        
        if($captainFinancialDuesEntity) {
            $captainFinancialDuesEntity->setState(1);
         }

         $this->entityManager->flush();
       }
       
        return "ok";
    }

    public function endCaptainFinancialDue(CaptainFinancialDuesEntity $captainFinancialDuesEntity): CaptainFinancialDuesEntity
    {
        $captainFinancialDuesEntity->setStatus(CaptainFinancialDues::FINANCIAL_DUES_PAID);
        $captainFinancialDuesEntity->setEndDate((new DateTime('now')));
        $captainFinancialDuesEntity->setState(CaptainFinancialDues::FINANCIAL_STATE_INACTIVE);
        $captainFinancialDuesEntity->setCaptainStoppedFinancialCycle(CaptainFinancialDues::CAPTAIN_STOPPED_FINANCIAL_CYCLE_TRUE_CONST);

        $this->entityManager->flush();

        return $captainFinancialDuesEntity;
    }

    public function createNewCaptainFinancialDueByAdmin(CaptainEntity $captainEntity, float $amount): CaptainFinancialDuesEntity
    {
        $captainFinancialDue = new CaptainFinancialDuesEntity();

        $captainFinancialDue->setCaptain($captainEntity);
        $captainFinancialDue->setStartDate((new DateTime('now')));
        $captainFinancialDue->setEndDate((new DateTime('+365 day')));
        $captainFinancialDue->setState(CaptainFinancialDues::FINANCIAL_STATE_ACTIVE);
        $captainFinancialDue->setStatus(CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
        $captainFinancialDue->setStatusAmountForStore(CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
        $captainFinancialDue->setAmount($amount);
        $captainFinancialDue->setAmountForStore(0.0);

        $this->entityManager->persist($captainFinancialDue);
        $this->entityManager->flush();

        return $captainFinancialDue;
    }

    public function getCaptainFinancialDueByCaptainProfileIdAndOrderCreationDate(int $captainProfileId, \DateTimeInterface $orderCreationDate): array
    {
        return $this->captainFinancialDuesRepository->getCaptainFinancialDueByCaptainProfileIdAndOrderCreationDate($captainProfileId,
            $orderCreationDate);
    }

    public function subtractValueFromCaptainFinancialDueAmountForStore(CaptainFinancialDuesEntity $captainFinancialDuesEntity, float $value): CaptainFinancialDuesEntity
    {
        $captainFinancialDuesEntity->setAmountForStore($captainFinancialDuesEntity->getAmountForStore() - $value);

        $this->entityManager->flush();

        return $captainFinancialDuesEntity;
    }
}
