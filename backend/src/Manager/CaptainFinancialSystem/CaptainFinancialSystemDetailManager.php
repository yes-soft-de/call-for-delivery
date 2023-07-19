<?php

namespace App\Manager\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Repository\CaptainFinancialSystemDetailEntityRepository;
use App\Request\CaptainFinancialSystem\CaptainFinancialSystemDetail\CaptainFinancialSystemDetailTypeAndIdUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\CaptainFinancialSystem\CaptainFinancialSystemDetailRequest;
use App\Manager\Captain\CaptainManager;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Captain\CaptainConstant;

class CaptainFinancialSystemDetailManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private CaptainFinancialSystemDetailEntityRepository $captainFinancialSystemDetailEntityRepository,
        private CaptainManager $captainManager
    )
    {
    }

    public function createCaptainFinancialSystemDetail(CaptainFinancialSystemDetailRequest $request): CaptainFinancialSystemDetailEntity|string
    {
        $request->setCaptain($this->captainManager->getCaptainProfileByUserId($request->getCaptain()));

        $captainFinancialSystemDetailEntity = $this->captainFinancialSystemDetailEntityRepository->findOneBy(["captain" => $request->getCaptain()]);
        
        if($captainFinancialSystemDetailEntity) {
            return CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE;
        }
       
        $captainFinancialSystemDetailEntity = $this->autoMapping->map(CaptainFinancialSystemDetailRequest::class, CaptainFinancialSystemDetailEntity::class, $request);
      
        $captainFinancialSystemDetailEntity->setStatus(CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_INACTIVE);
        $this->entityManager->persist($captainFinancialSystemDetailEntity);
        $this->entityManager->flush();
        $this->captainManager->captainProfileCompleteAccountStatusUpdateCreateRequest($request->getCaptain()->getCaptainId(), CaptainConstant::COMPLETE_ACCOUNT_STATUS_SYSTEM_FINANCIAL_SELECTED);
        return $captainFinancialSystemDetailEntity;
    }

    public function getCaptainFinancialSystemDetailCurrent(int $userId): ?array
    {
        $captainId = $this->captainManager->getCaptainProfileByUserId($userId)->getId();
      
        $financialSystemDetail = $this->captainFinancialSystemDetailEntityRepository->getCaptainFinancialSystemDetailCurrent($captainId);
        
        if($financialSystemDetail) {
            $financialSystemDetail['captainId'] = $captainId;
        }
      
        return $financialSystemDetail;
    }

    public function updateCaptainFinancialSystemDetail(bool $status, int $userId): CaptainFinancialSystemDetailEntity |null
    {      
        $captainId = $this->captainManager->getCaptainProfileByUserId($userId)->getId();

        $financialSystemDetail = $this->captainFinancialSystemDetailEntityRepository->findOneBy(['captain' => $captainId]);
        if(! $financialSystemDetail) {
            return $financialSystemDetail;
        }

        $financialSystemDetail->setStatus($status);
        $financialSystemDetail->setUpdatedBy(null);
        $this->entityManager->flush();

        return  $financialSystemDetail;
    }

    public function deleteCaptainFinancialSystemDetailsByCaptainId(int $captainId): array
    {
        $financialSystemDetails = $this->captainFinancialSystemDetailEntityRepository->getFinancialSystemDetailsEntitiesByCaptainId($captainId);

        if (! empty($financialSystemDetails)) {
            foreach ($financialSystemDetails as $financialSystemDetail) {
                $this->entityManager->remove($financialSystemDetail);
                $this->entityManager->flush();
            }
        }

        return $financialSystemDetails;
    }

    /**
     * used by stopFinancialSystemAndFinancialCycle
     * This had been commented out currently but we may need it in the future
     */
//    public function updateCaptainFinancialSystemDetailByCaptainId(int $captainId, int $status): CaptainFinancialSystemDetailEntity
//    {
//        $financialSystemDetail = $this->captainFinancialSystemDetailEntityRepository->findOneBy(["captain" => $captainId]);
//
//        if ($financialSystemDetail) {
//          $financialSystemDetail->setStatus($status);
//          $this->entityManager->flush();
//        }
//
//        return $financialSystemDetail;
//    }

    public function updateCaptainFinancialSystemDetailCaptainFinancialSystemType(CaptainFinancialSystemDetailTypeAndIdUpdateRequest $request)
    {
        $captainFinancialSystemDetail = $this->captainFinancialSystemDetailEntityRepository->findOneBy(['id' => $request->getId()]);

        if ($captainFinancialSystemDetail) {
            $captainFinancialSystemDetail = $this->autoMapping->mapToObject(CaptainFinancialSystemDetailTypeAndIdUpdateRequest::class,
                CaptainFinancialSystemDetailEntity::class, $request, $captainFinancialSystemDetail);

            $this->entityManager->flush();
        }

        return $captainFinancialSystemDetail;
    }
}
