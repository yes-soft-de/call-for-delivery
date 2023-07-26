<?php

namespace App\Manager\Admin\CaptainAmountFromOrderCash;

use App\Repository\CaptainAmountFromOrderCashEntityRepository;
use App\Request\Admin\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashDeleteByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\Admin\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashFilterGetRequest;
use App\Entity\CaptainPaymentToCompanyEntity;
use App\Constant\Order\OrderAmountCashConstant;

class AdminCaptainAmountFromOrderCashManager
{
    public function __construct(
        private CaptainAmountFromOrderCashEntityRepository $captainAmountFromOrderCashEntityRepository,
        private EntityManagerInterface $entityManager
    )
    {
    }

    public function filterCaptainAmountFromOrderCash(CaptainAmountFromOrderCashFilterGetRequest $request): ?array
    {       
        return $this->captainAmountFromOrderCashEntityRepository->filterCaptainAmountFromOrderCash($request->getCaptainId(), $request->getFromDate(), $request->getToDate());
    }

    public function updateFlagBySpecificDate(array $captainAmountFromCashOrderArray, int $flag, CaptainPaymentToCompanyEntity $captainPaymentToCompanyEntity, bool $editingByCaptain): array
    {
        $captainAmountFromOrderCashResultArray = [];

        foreach ($captainAmountFromCashOrderArray as $captainAmountFromCashOrder) {
            $captainAmountFromOrderCashEntity = $this->captainAmountFromOrderCashEntityRepository->findOneBy(['id' => $captainAmountFromCashOrder['id']]);

            if ($captainAmountFromOrderCashEntity) {
                $captainAmountFromOrderCashEntity->setFlag($flag);
                $captainAmountFromOrderCashEntity->setCaptainPaymentToCompany($captainPaymentToCompanyEntity);
                $captainAmountFromOrderCashEntity->setEditingByCaptain($editingByCaptain);

                $this->entityManager->flush();
                $captainAmountFromOrderCashResultArray[] = $captainAmountFromOrderCashEntity;
            }
        }

        return $captainAmountFromOrderCashResultArray;
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

    //Get the captain's amount from the cash system according to a specific date on an unpaid condition
    public function getCaptainAmountFromOrderCashBySpecificDateOnUnpaidCondition(string $fromDate, string $toDate, int $captainId): ?array
    {      
      return $this->captainAmountFromOrderCashEntityRepository->getCaptainAmountFromOrderCashBySpecificDateOnUnpaidCondition($captainId, $fromDate, $toDate);
    }

    public function deleteCaptainAmountFromCashOrderByCaptainProfileIdAndOrderId(CaptainAmountFromOrderCashDeleteByAdminRequest $request): array|int
    {
        $captainAmountsFromCashOrder = $this->captainAmountFromOrderCashEntityRepository->findOneBy(['captain' => $request->getCaptainProfileId(),
            'orderId' => $request->getOrderId()]);

        if (! $captainAmountsFromCashOrder) {
            return OrderAmountCashConstant::CAPTAIN_AMOUNT_FROM_CASH_ORDER_NOT_EXIST_CONST;
        }

        $payment = $captainAmountsFromCashOrder->getCaptainPaymentToCompany();

        $captainAmountsFromCashOrder->setCaptainPaymentToCompany(null);

        $this->entityManager->remove($captainAmountsFromCashOrder);
        $this->entityManager->flush();

        return [$captainAmountsFromCashOrder, $payment];
    }
}
