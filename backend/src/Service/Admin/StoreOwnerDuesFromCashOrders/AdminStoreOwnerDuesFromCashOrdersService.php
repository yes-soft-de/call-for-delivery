<?php

namespace App\Service\Admin\StoreOwnerDuesFromCashOrders;

use App\AutoMapping;
use App\Constant\StoreOwnerDueFromCashOrder\StoreOwnerDueFromCashOrderStoreAmountConstant;
use App\Entity\StoreOwnerDuesFromCashOrdersEntity;
use App\Manager\Admin\StoreOwnerDuesFromCashOrders\AdminStoreOwnerDuesFromCashOrdersManager;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreDueSumFromCashOrderFilterByAdminRequest;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDueFromCashOrderFilterByAdminRequest;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrderDeleteByAdminRequest;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersFilterGetRequest;
use App\Response\Admin\StoreOwnerDuesFromCashOrders\StoreDueSumFilterByAdminResponse;
use App\Response\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDueFromCashOrderMonthlyFilterByAdminResponse;
use App\Response\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersResponse;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentFromCompanyService;
use App\Constant\Order\OrderAmountCashConstant;
use App\Service\DateFactory\DateFactoryService;
use App\Service\FileUpload\UploadFileHelperService;
use DateTime;

class AdminStoreOwnerDuesFromCashOrdersService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminStoreOwnerDuesFromCashOrdersManager $adminStoreOwnerDuesFromCashOrdersManager,
        private AdminStoreOwnerPaymentFromCompanyService $adminStoreOwnerPaymentFromCompanyService,
        private UploadFileHelperService $uploadFileHelperService,
        private DateFactoryService $dateFactoryService
    )
    {
    }

    public function filterStoreOwnerDuesFromCashOrders(StoreOwnerDuesFromCashOrdersFilterGetRequest $request): array
    {
        $detail = [];
        $sumAmountStoreOwnerDues = 0;
        $finishedPayments = [];
       
        $items = $this->adminStoreOwnerDuesFromCashOrdersManager->filterStoreOwnerDuesFromCashOrders($request);
       
        foreach ($items as $storeOwnerDuesFromCashOrders) {
            //Unfinished Payments
            if($storeOwnerDuesFromCashOrders['flag'] ===  OrderAmountCashConstant::ORDER_PAID_FLAG_NO){
                $sumAmountStoreOwnerDues = $sumAmountStoreOwnerDues + $storeOwnerDuesFromCashOrders['storeAmount'];

                $detail[] = $this->autoMapping->map("array", StoreOwnerDuesFromCashOrdersResponse::class, $storeOwnerDuesFromCashOrders);
            }
            //Finished Payments
            else{
                $finishedPayments[] = $this->autoMapping->map("array", StoreOwnerDuesFromCashOrdersResponse::class, $storeOwnerDuesFromCashOrders);
            }
        }

        $total = $this->getTotal($sumAmountStoreOwnerDues, $request->getStoreId(), $request->getFromDate(), $request->getToDate());

        return ['detail' => $detail, 'finishedPayments' => $finishedPayments, 'total' => $total];
    }
    
    public function getTotal(float $sumAmountStoreOwnerDues, int $storeId, string $fromDate, string $toDate): array
    {
        $sumPaymentsFromCompany = $this->adminStoreOwnerPaymentFromCompanyService->getSumPaymentsFromCompany($storeId);
      
        //Now this field shown only in the front the rest of the fields are not needed at the present time
        $item['sumAmountStorOwnerDues'] = $sumAmountStoreOwnerDues;

        $item['sumPaymentsFromCompany'] = $sumPaymentsFromCompany['sumPaymentsFromCompany'];

        $total = $item['sumPaymentsFromCompany'] - $sumAmountStoreOwnerDues ;
    
        $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;

        if($total <= 0 ) {
            $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $item['total'] = abs($total);

        return $item;
    }

    public function deleteStoreOwnerDuesFromCashOrderByAdmin(StoreOwnerDuesFromCashOrderDeleteByAdminRequest $request): int|array
    {
        return $this->adminStoreOwnerDuesFromCashOrdersManager->deleteStoreOwnerDuesFromCashOrderByAdmin($request);
    }

    /**
     * Check if array of StoreDueSumFilterByAdminResponse has a specific value for a specific property
     */
    public function checkIfStoreDueSumFilterByAdminResponseArrayHasSpecificValueForSpecificProperty($value, array $searchingArray, string $columnName): bool
    {
        if (count($searchingArray) === 0) {
            return false;
        }

        foreach ($searchingArray as $item) {
            if ($item->$columnName === $value) {
                return true;
            }
        }

        return false;
    }

    /**
     * Get the sum of a specific store due and depending on paid flag
     */
    public function getStoreOwnerDueSumFromCashOrderByIsPaidFlagAndStoreOwnerProfileId(int $storeOwnerProfileId, int $isPaid = null)
    {
        $allStoreDueFromCashOrder = $this->adminStoreOwnerDuesFromCashOrdersManager->getStoreOwnerDueSumFromCashOrderByIsPaidFlagAndStoreOwnerProfileId($storeOwnerProfileId,
            $isPaid);

        if (count($allStoreDueFromCashOrder) > 0) {
            return $allStoreDueFromCashOrder[0];
        }

        return 0.0;
    }

    /**
     * Get all stores due sum from cash orders depending on filtering options
     */
    public function filterStoreDueFromCashOrdersByAdmin(StoreDueSumFromCashOrderFilterByAdminRequest $request): array
    {
        $response = [];

        $allStoreDueFromCashOrder = $this->adminStoreOwnerDuesFromCashOrdersManager->filterStoreDueFromCashOrdersByAdmin($request);

        if (count($allStoreDueFromCashOrder) > 0) {
            $tempResponse = [];

            foreach ($allStoreDueFromCashOrder as $value) {
                if ($this->checkIfStoreDueSumFilterByAdminResponseArrayHasSpecificValueForSpecificProperty($value->getStore()->getId(),
                        $response, 'storeOwnerProfileId') === false) {
                    $tempResponse['id'] = $value->getId();
                    $tempResponse['storeOwnerProfileId'] = $value->getStore()->getId();
                    $tempResponse['storeOwnerName'] = $value->getStore()->getStoreOwnerName();
                    $tempResponse['image'] = $this->uploadFileHelperService->getImageParams($value->getStore()->getImages());
                    // Get the sum of the due for the store
                    $tempResponse['amountSum'] = $this->getStoreOwnerDueSumFromCashOrderByIsPaidFlagAndStoreOwnerProfileId($tempResponse['storeOwnerProfileId'],
                        $request->getIsPaid());
                    // Get the rest to be paid to the store according to the sum of the due and sum of the payments (if exists)
                    $tempResponse['toBePaid'] = $this->calculateAndGetToBePaidAmountByStoreOwnerDueSum($tempResponse['storeOwnerProfileId'],
                        $tempResponse['amountSum']);

                    $response[] = $this->autoMapping->map('array', StoreDueSumFilterByAdminResponse::class, $tempResponse);
                }
            }
        }

        return $response;
    }

    public function getStorePaymentFromCompanyAmountById(int $id): float
    {
        return $this->adminStoreOwnerPaymentFromCompanyService->getStorePaymentFromCompanyAmountById($id);
    }

    public function getSumPaymentsFromCompany(int $storeOwnerProfileId): float
    {
        $sumPaymentsArrayResult = $this->adminStoreOwnerPaymentFromCompanyService->getSumPaymentsFromCompany($storeOwnerProfileId);

        if ($sumPaymentsArrayResult) {
            if (count($sumPaymentsArrayResult) > 0) {
                if ($sumPaymentsArrayResult['sumPaymentsFromCompany']) {
                    return $sumPaymentsArrayResult['sumPaymentsFromCompany'];
                }
            }
        }

        return 0.0;
    }

    /**
     * Calculate and return the remind payment amount for a group of captain financial daily
     */
    public function calculateAndGetToBePaidAmountByStoreOwnerDueSum(int $storeOwnerProfileId, float $sumAmount): float
    {
        $paymentsSum = $this->getSumPaymentsFromCompany($storeOwnerProfileId);

        return ($sumAmount - $paymentsSum);
    }

    /**
     * get the sum of Store Due From Cash Order By Store Due Entities Array
     */
    public function getStoreDueFromCashOrderSumByStoreDueEntitiesArray(array $storeOwnerDueFromCashOrderArray)
    {
        $sum = 0.0;

        if (count($storeOwnerDueFromCashOrderArray) > 0) {
            foreach ($storeOwnerDueFromCashOrderArray as $item) {
                $sum += $item->getStoreAmount();
            }
        }

        return $sum;
    }

    /**
     * get the sum of the payment of Store Due From Cash Order amount
     */
    public function calculateToBePaidMonthlyByStoreOwnerProfileIdAndStoreOwnerDueAndMonth(int $storeOwnerProfileId, float $storeOwnerDueSum, DateTime $month): float
    {
        $paymentFromCompanySum = $this->getStorePaymentFromCompanySumByMonth($storeOwnerProfileId, $month);

        return ($storeOwnerDueSum - $paymentFromCompanySum);
    }

    /**
     * Get array of the start and end dates of each month of an array
     */
    public function getStartAndEndDateTimeOfEachMonthByYear(string $year, string $timeZone = null): array
    {
        return $this->dateFactoryService->getStartAndEndDateTimeOfEachMonthByYear($year, $timeZone);
    }

    public function getDateOnlyFromStringDateTime(string $dateTime): DateTime
    {
        return $this->dateFactoryService->getDateOnlyFromStringDateTime($dateTime);
    }

    /**
     * Filter all store owners due from cash orders by admin
     */
    public function filterStoreOwnerDueFromCashOrderMonthlyByAdmin(StoreOwnerDueFromCashOrderFilterByAdminRequest $request): array
    {
        $response = [];

        if (($request->getYear()) && ($request->getYear() !== "")) {
            $yearMonthsArray = $this->getStartAndEndDateTimeOfEachMonthByYear($request->getYear());

        } else {
            $yearMonthsArray = $this->getStartAndEndDateTimeOfEachMonthByYear(date('Y'));
        }

        $index = 0;

        foreach ($yearMonthsArray as $month) {
            $request->setFromDate($month[1]);
            $request->setToDate($month[2]);

            $storeOwnersDueFromCashOrdersArray = $this->adminStoreOwnerDuesFromCashOrdersManager->filterStoreOwnerDueFromCashOrderByAdmin($request);

            if (count($storeOwnersDueFromCashOrdersArray) > 0) {
                $response[$index] = $this->autoMapping->map('array', StoreOwnerDueFromCashOrderMonthlyFilterByAdminResponse::class,
                    $storeOwnersDueFromCashOrdersArray);

                $response[$index]->month = $month[0];
                $response[$index]->storeOwnerProfileId = $storeOwnersDueFromCashOrdersArray[0]->getStore()->getId();
                $response[$index]->storeOwnerName = $storeOwnersDueFromCashOrdersArray[0]->getStore()->getStoreOwnerName();
                $response[$index]->image = $this->uploadFileHelperService->getImageParams($storeOwnersDueFromCashOrdersArray[0]->getStore()->getImages());
                $response[$index]->amount = $this->getStoreDueFromCashOrderSumByStoreDueEntitiesArray($storeOwnersDueFromCashOrdersArray);
                // Calculate the remaining payment for the store
                $response[$index]->toBePaid = $this->calculateToBePaidMonthlyByStoreOwnerProfileIdAndStoreOwnerDueAndMonth($storeOwnersDueFromCashOrdersArray[0]->getStore()->getId(),
                    $response[$index]->amount, $this->getDateOnlyFromStringDateTime($month[2]));

                $index++;
            }
        }

        return $response;
    }

    public function getStorePaymentFromCompanySumByMonth(int $storeOwnerProfileId, DateTime $month): float
    {
        $arrayResult = $this->adminStoreOwnerPaymentFromCompanyService->getStorePaymentFromCompanySumByMonth($storeOwnerProfileId,
            $month);

        if (count($arrayResult) > 0) {
            return $arrayResult[0];
        }

        return 0.0;
    }

    public function deleteStoreOwnerDueFromCashOrderById(int $id): int|StoreOwnerDuesFromCashOrdersEntity
    {
        $storeOwnerDue = $this->adminStoreOwnerDuesFromCashOrdersManager->deleteStoreOwnerDueFromCashOrderById($id);

        if (! $storeOwnerDue) {
            return StoreOwnerDueFromCashOrderStoreAmountConstant::STORE_DUE_FROM_CASH_ORDER_NOT_EXIST_CONST;
        }

        return $storeOwnerDue;
    }
}
