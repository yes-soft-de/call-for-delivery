<?php

namespace App\Manager\Admin\CaptainAmountFromOrderCash;

use App\AutoMapping;
use App\Entity\CaptainAmountFromOrderCashEntity;
use App\Entity\CaptainEntity;
use App\Repository\CaptainAmountFromOrderCashEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\Admin\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashFilterGetRequest;

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

    public function updateFlagBySpecificDate(string $fromDate, string $toDate, int $flag, CaptainEntity $captainId)
    {      
      $items = $this->captainAmountFromOrderCashEntityRepository->getCaptainAmountFromOrderCash($captainId->getId(), $fromDate, $toDate);
     
      foreach($items as $item) {
        $captainAmountFromOrderCashEntity = $this->captainAmountFromOrderCashEntityRepository->find($item['id']);
       
        $captainAmountFromOrderCashEntity->setFlag($flag);
       
        $this->entityManager->flush();
      }
    }
}
