<?php

namespace App\Manager\CaptainFinancialSystem\CaptainFinancialDaily;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Entity\CaptainFinancialDailyEntity;
use App\Repository\CaptainFinancialDailyEntityRepository;
use App\Request\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyAmountUpdateRequest;
use App\Request\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyCreateRequest;
use App\Request\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyFilterRequest;
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

    public function getCaptainFinancialDailyByDateAndCaptainProfileId(DateTime $date, int $captainProfileId): ?CaptainFinancialDailyEntity
    {
        return $this->captainFinancialDailyEntityRepository->getCaptainFinancialDailyByDateAndCaptainProfileId($date, $captainProfileId);
    }

    public function createCaptainFinancialDaily(CaptainFinancialDailyCreateRequest $request): CaptainFinancialDailyEntity
    {
        $captainFinancialDailyEntity = $this->autoMapping->map(CaptainFinancialDailyCreateRequest::class, CaptainFinancialDailyEntity::class, $request);

        // Save only date, with time equal to 00:00:00
        $captainFinancialDailyEntity->setCreatedAt(new DateTime(($request->getCreatedAt())->format('Y-m-d')));

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

    public function getCaptainFinancialAmountDailyByCaptainUserIdAndSpecificDate(int $captainId, DateTime $date): ?CaptainFinancialDailyEntity
    {
        return $this->captainFinancialDailyEntityRepository->getCaptainFinancialDailyByDateAndCaptainUserId($date, $captainId);
    }

    public function filterCaptainFinancialDaily(CaptainFinancialDailyFilterRequest $request): array
    {
        return $this->captainFinancialDailyEntityRepository->filterCaptainFinancialDaily($request);
    }
}
