<?php

namespace App\Manager\Admin\CaptainAmountFromOrderCash;

use App\AutoMapping;
use App\Entity\CaptainAmountFromOrderCashEntity;
use App\Entity\CaptainEntity;
use App\Repository\CaptainAmountFromOrderCashEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\Admin\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashFilterGetRequest;
use App\Entity\CaptainPaymentToCompanyEntity;
use App\Constant\Order\OrderAmountCashConstant;

class AdminCaptainAmountFromOrderCashManager
{
    private AutoMapping $autoMapping;
    private CaptainAmountFromOrderCashEntityRepository $captainAmountFromOrderCashEntityRepository;
    private EntityManagerInterface $entityManager;

    public function __construct(AutoMapping $autoMapping, CaptainAmountFromOrderCashEntityRepository $captainAmountFromOrderCashEntityRepository, EntityManagerInterface $entityManager)
    {
        $this->captainAmountFromOrderCashEntityRepository = $captainAmountFromOrderCashEntityRepository;
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
    }

    public function filterCaptainAmountFromOrderCash(CaptainAmountFromOrderCashFilterGetRequest $request): ?array
    {       
        return $this->captainAmountFromOrderCashEntityRepository->filterCaptainAmountFromOrderCash($request->getCaptainId(), $request->getFromDate(), $request->getToDate());
    }

    public function updateFlagBySpecificDate(string $fromDate, string $toDate, int $flag, CaptainEntity $captainId, CaptainPaymentToCompanyEntity $captainPaymentToCompanyEntity)
    {      
      $items = $this->captainAmountFromOrderCashEntityRepository->getCaptainAmountFromOrderCash($captainId->getId(), $fromDate, $toDate);
     
      foreach($items as $item) {
        $captainAmountFromOrderCashEntity = $this->captainAmountFromOrderCashEntityRepository->find($item['id']);
       
        $captainAmountFromOrderCashEntity->setFlag($flag);
        $captainAmountFromOrderCashEntity->setCaptainPaymentToCompany($captainPaymentToCompanyEntity);
       
        $this->entityManager->flush();
      }
    }

    public function getCaptainAmountFromOrderCashByCaptainPaymentToCompanyId(CaptainPaymentToCompanyEntity $captainPaymentToCompany): ?array
    {                   
        $items = $this->captainAmountFromOrderCashEntityRepository->findBy(['captainPaymentToCompany' =>$captainPaymentToCompany->getId()]);

        foreach($items as $captainAmountFromOrderCash) {
         
          $captainAmountFromOrderCash->setCaptainPaymentToCompany(null);
          $captainAmountFromOrderCash->setFlag(OrderAmountCashConstant::ORDER_PAID_FLAG_NO);

          $this->entityManager->flush();
        }

        return $items;
    }

    public function getCaptainAmountFromOrderCashBySpecificDate(string $fromDate, string $toDate, int $captainId): ?array
    {      
      return $this->captainAmountFromOrderCashEntityRepository->getCaptainAmountFromOrderCash($captainId, $fromDate, $toDate);
    }
}
