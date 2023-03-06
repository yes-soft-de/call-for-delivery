<?php

namespace App\Manager\Admin\CaptainFinancialSystem\CaptainFinancialDaily;

use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Entity\CaptainFinancialDailyEntity;
use App\Repository\CaptainFinancialDailyEntityRepository;
use App\Request\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyFilterByAdminRequest;
use App\Request\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyIsPaidUpdateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminCaptainFinancialDailyManager
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private CaptainFinancialDailyEntityRepository $captainFinancialDailyEntityRepository
    )
    {
    }

    public function getCaptainFinancialDailyById(int $captainFinancialDailyId): ?CaptainFinancialDailyEntity
    {
        return $this->captainFinancialDailyEntityRepository->findOneBy(['id' => $captainFinancialDailyId]);
    }

    public function updateCaptainFinancialDailyIsPaid(CaptainFinancialDailyIsPaidUpdateByAdminRequest $request): CaptainFinancialDailyEntity|int
    {
        $captainFinancialDaily = $this->captainFinancialDailyEntityRepository->findOneBy(['id' => $request->getId()]);

        if (! $captainFinancialDaily) {
            return CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST;
        }

        $captainFinancialDaily->setIsPaid($request->getIsPaid());

        $this->entityManager->flush();

        return $captainFinancialDaily;
    }

    public function filterCaptainFinancialDailyByAdmin(CaptainFinancialDailyFilterByAdminRequest $request): array
    {
        return $this->captainFinancialDailyEntityRepository->filterCaptainFinancialDailyByAdmin($request);
    }
}
