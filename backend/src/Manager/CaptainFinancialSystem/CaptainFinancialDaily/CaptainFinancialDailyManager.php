<?php

namespace App\Manager\CaptainFinancialSystem\CaptainFinancialDaily;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Entity\CaptainFinancialDailyEntity;
use App\Repository\CaptainFinancialDailyEntityRepository;
use App\Request\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyAmountUpdateRequest;
use App\Request\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyCreateRequest;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;

class CaptainFinancialDailyManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private CaptainFinancialDailyEntityRepository $captainFinancialDailyEntityRepository
    )
    {
    }

    public function getCaptainFinancialDailyByDate(DateTime $date): ?CaptainFinancialDailyEntity
    {
        return $this->captainFinancialDailyEntityRepository->getCaptainFinancialDailyByDate($date);
    }

    public function createCaptainFinancialDaily(CaptainFinancialDailyCreateRequest $request): CaptainFinancialDailyEntity
    {
        $captainFinancialDailyEntity = $this->autoMapping->map(CaptainFinancialDailyCreateRequest::class, CaptainFinancialDailyEntity::class, $request);

        $this->entityManager->persist($captainFinancialDailyEntity);
        $this->entityManager->flush();

        return $captainFinancialDailyEntity;
    }

    public function updateCaptainFinancialDailyAmount(CaptainFinancialDailyAmountUpdateRequest $request): int|CaptainFinancialDailyEntity
    {
        $captainFinancialDailyEntity = $this->captainFinancialDailyEntityRepository->findOneBy(['id' => $request->getId()]);

        if (! $captainFinancialDailyEntity) {
            return CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST;
        }

        $captainFinancialDailyEntity = $this->autoMapping->mapToObject(CaptainFinancialDailyAmountUpdateRequest::class, CaptainFinancialDailyEntity::class,
            $request, $captainFinancialDailyEntity);

        $this->entityManager->flush();

        return $captainFinancialDailyEntity;
    }
}
