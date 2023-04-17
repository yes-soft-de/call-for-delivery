<?php

namespace App\Manager\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialDuesEntity;
use App\Repository\CaptainFinancialDuesEntityRepository;
use App\Request\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\CaptainFinancialSystem\CreateCaptainFinancialDuesRequest;
use App\Manager\Captain\CaptainManager;
use DateTime;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Request\CaptainFinancialSystem\CreateCaptainFinancialDuesByOptionalDatesRequest;

class CaptainFinancialDuesManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private CaptainFinancialDuesEntityRepository $captainFinancialDuesRepository,
        private CaptainManager $captainManager
    )
    {
    }

    public function createCaptainFinancialDues(CreateCaptainFinancialDuesRequest $request): CaptainFinancialDuesEntity
    {
        $request->setCaptain($this->captainManager->getCaptainProfileById($request->getCaptain()));
      
        $captainFinancialDuesEntity = $this->autoMapping->map(CreateCaptainFinancialDuesRequest::class, CaptainFinancialDuesEntity::class, $request);
       
        $captainFinancialDuesEntity->setState(CaptainFinancialDues::FINANCIAL_STATE_ACTIVE);
       
        $this->entityManager->persist($captainFinancialDuesEntity);
        $this->entityManager->flush();

        return $captainFinancialDuesEntity;
    }

    public function getCaptainFinancialDues(int $captainId, int $state): ?CaptainFinancialDuesEntity
    {
        return $this->captainFinancialDuesRepository->findOneBy(["captain" => $captainId, "state" => $state]);
    } 

    public function updateCaptainFinancialDues(CaptainFinancialDuesEntity $captainFinancialDues): CaptainFinancialDuesEntity
    {
        $this->entityManager->flush();

        return $captainFinancialDues;
    } 
    
    public function getCaptainFinancialDuesByUserId(int $userId): array
    {
        return $this->captainFinancialDuesRepository->getCaptainFinancialDuesByUserId($userId);
    } 
    
    public function getSumCaptainFinancialDuesById(int $captainFinancialDueId): array
    {
        return $this->captainFinancialDuesRepository->getSumCaptainFinancialDuesById($captainFinancialDueId);
    } 

    public function getLatestCaptainFinancialDues(int $captainId): ?array
    {
        return $this->captainFinancialDuesRepository->getLatestCaptainFinancialDues($captainId);
    } 

    public function getCaptainFinancialDuesByEndDate(int $userId, DateTime $date): ?array
    {
        return $this->captainFinancialDuesRepository->getCaptainFinancialDuesByEndDate($userId, $date);
    }

    public function getFinancialDuesByCaptainId(int $captainId): array
    {
        return $this->captainFinancialDuesRepository->getFinancialDuesByCaptainId($captainId);
    }

    public function updateCaptainFinancialDuesStateToInactive(int $id): ?CaptainFinancialDuesEntity
    {
        $captainFinancialDuesEntity = $this->captainFinancialDuesRepository->find($id);
     
        if(! $captainFinancialDuesEntity) {
            return $captainFinancialDuesEntity;
        }

        $captainFinancialDuesEntity->setState(CaptainFinancialDues::FINANCIAL_STATE_INACTIVE);
      
        $this->entityManager->flush();

        return $captainFinancialDuesEntity;
    }
    
    public function getCaptainFinancialDuesByUserIDAndState(int $userId, int $state): ?CaptainFinancialDuesEntity
    {
        $captain = $this->captainManager->getCaptainProfileByUserId($userId);
  
        return $this->getCaptainFinancialDues($captain->getId(), $state);
    }

    /**
     * used by stopFinancialSystemAndFinancialCycle
     * This had been commented out currently but we may need it in the future
     */
//    public function getLatestCaptainFinancialDuesByUserId(int $userId): ?CaptainFinancialDuesEntity
//    {
//        return $this->captainFinancialDuesRepository->getLatestCaptainFinancialDuesByUserId($userId);
//    }

    public function getCaptainFinancialDuesByUserIDAndOrderId(int $userId, int $orderId, string $orderCreatedAt): ?CaptainFinancialDuesEntity
    {  
        return $this->captainFinancialDuesRepository->getCaptainFinancialDuesByUserIDAndOrderId($userId, $orderId, $orderCreatedAt);
    } 

    public function createCaptainFinancialDuesByOptionalDates(CreateCaptainFinancialDuesByOptionalDatesRequest $request): CaptainFinancialDuesEntity
    {
        $request->setCaptain($this->captainManager->getCaptainProfileById($request->getCaptain()));
      
        $captainFinancialDuesEntity = $this->autoMapping->map(CreateCaptainFinancialDuesByOptionalDatesRequest::class, CaptainFinancialDuesEntity::class, $request);
       
        $captainFinancialDuesEntity->setState(CaptainFinancialDues::FINANCIAL_STATE_INACTIVE);
       
        $this->entityManager->persist($captainFinancialDuesEntity);
        $this->entityManager->flush();

        return $captainFinancialDuesEntity;
    }

    public function getCaptainProfile($captainProfileId)
    {
        return $this->captainManager->getCaptainProfileById($captainProfileId);      
    }
  
    //--------------->START fix create financial dues  
    public function getCaptainFinancialDuesByUserIDAndOrderIdForFixByUserID(int $userId, int $orderId, $createdDate): ?CaptainFinancialDuesEntity
    {  
        return $this->captainFinancialDuesRepository->getCaptainFinancialDuesByUserIDAndOrderIdForFixByUserID($userId, $orderId, $createdDate);
    } 

    public function getCaptainFinancialDuesByUserIDAndOrderIdForFix(int $captainId, int $orderId, $createdDate)
    {  
        return $this->captainFinancialDuesRepository->getCaptainFinancialDuesByUserIDAndOrderIdForFix($captainId, $orderId, $createdDate);
    } 
    //--------------->END fix create financial dues

    public function getFinancialDuesSumByCaptainId(int $captainId): array
    {
        return $this->captainFinancialDuesRepository->getFinancialDuesSumByCaptainId($captainId);
    }

    public function deleteAllCaptainFinancialDuesByCaptainId(int $captainId): array
    {
        $financialDues = $this->captainFinancialDuesRepository->getCaptainFinancialDueEntitiesByCaptainId($captainId);

        if (count($financialDues) > 0) {
            foreach ($financialDues as $financialDue) {
                $this->entityManager->remove($financialDue);
                $this->entityManager->flush();
            }
        }

        return $financialDues;
    }

    /**
     * Get the start and end dates of the current active financial cycle of the captain
     */
    public function getCurrentAndActiveCaptainFinancialDueByCaptainProfileId(int $captainProfileId): array
    {
        return $this->captainFinancialDuesRepository->findBy(['captain' => $captainProfileId, 'state' => CaptainFinancialDues::FINANCIAL_STATE_ACTIVE],
            ['id'=>'DESC'], 1);
    }

    /**
     * Creates captain financial due by CaptainFinancialDueCreateRequest
     */
    public function createCaptainFinancialDue(CaptainFinancialDueCreateRequest $request)
    {
        $captainFinancialDuesEntity = $this->autoMapping->map(CaptainFinancialDueCreateRequest::class, CaptainFinancialDuesEntity::class,
            $request);

        $this->entityManager->persist($captainFinancialDuesEntity);
        $this->entityManager->flush();

        return $captainFinancialDuesEntity;
    }
}
