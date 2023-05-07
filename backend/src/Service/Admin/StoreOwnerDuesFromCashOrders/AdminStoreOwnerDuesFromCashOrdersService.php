<?php

namespace App\Service\Admin\StoreOwnerDuesFromCashOrders;

use App\AutoMapping;
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
        $sumAmountStorOwnerDues = 0;
        $finishedPayments = [];
       
        $items = $this->adminStoreOwnerDuesFromCashOrdersManager->filterStoreOwnerDuesFromCashOrders($request);
       
        foreach ($items as $storeOwnerDuesFromCashOrders) {
            //Unfinished Payments
            if($storeOwnerDuesFromCashOrders['flag'] ===  OrderAmountCashConstant::ORDER_PAID_FLAG_NO){
                $sumAmountStorOwnerDues = $sumAmountStorOwnerDues + $storeOwnerDuesFromCashOrders['storeAmount'];

                $detail[] = $this->autoMapping->map("array", StoreOwnerDuesFromCashOrdersResponse::class, $storeOwnerDuesFromCashOrders);
            }
            //Finished Payments
            else{
                $finishedPayments[] = $this->autoMapping->map("array", StoreOwnerDuesFromCashOrdersResponse::class, $storeOwnerDuesFromCashOrders);
            }
        }

        $total = $this->getTotal($sumAmountStorOwnerDues, $request->getStoreId(), $request->getFromDate(), $request->getToDate());

        return ['detail' => $detail, 'finishedPayments' => $finishedPayments, 'total' => $total];
    }
    
    public function getTotal(float $sumAmountStorOwnerDues, int $storeId, string $fromDate, string $toDate): array
    {
        $sumPaymentsFromCompany = $this->adminStoreOwnerPaymentFromCompanyService->getSumPaymentsFromCompany($storeId, $fromDate, $toDate);
      
        //Now this field shown only in the front the rest of the fields are not needed at the present time
        $item['sumAmountStorOwnerDues'] = $sumAmountStorOwnerDues;

        $item['sumPaymentsFromCompany'] = $sumPaymentsFromCompany['sumPaymentsFromCompany'];

        $total = $item['sumPaymentsFromCompany'] -  $sumAmountStorOwnerDues ;
    
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
                if ($this->checkIfStoreDueSumFilterByAdminResponseArrayHasSpecificValueForSpecificProperty($value->getStore()->getId(), $response, 'storeOwnerProfileId') === false) {
                    $tempResponse['id'] = $value->getId();
                    $tempResponse['storeOwnerProfileId'] = $value->getStore()->getId();
                    $tempResponse['storeOwnerName'] = $value->getStore()->getStoreOwnerName();
                    $tempResponse['image'] = $this->uploadFileHelperService->getImageParams($value->getStore()->getImages());
                    // Get the sum of the due for the store
                    $tempResponse['amountSum'] = $this->getStoreOwnerDueSumFromCashOrderByIsPaidFlagAndStoreOwnerProfileId($tempResponse['storeOwnerProfileId'],
                        $request->getIsPaid());
                    // Get the rest to be paid to the store according to the sum of the due and sum of the payments (if exists)
                    $tempResponse['toBePaid'] = $this->calculateAndGetToBePaidAmountByStoreOwnerDueArrayAndStoreOwnerProfileIdAndDueSum($allStoreDueFromCashOrder,
                        $tempResponse['storeOwnerProfileId'], $tempResponse['amountSum']);

                    $response[] = $this->autoMapping->map('array', StoreDueSumFilterByAdminResponse::class, $tempResponse);
                }
            }
        }

        return $response;
    }

    /**
     * Calculate and return the remind payment amount for a group of captain financial daily
     */
    public function calculateAndGetToBePaidAmountByStoreOwnerDueArrayAndStoreOwnerProfileIdAndDueSum(array $storeOwnerDuesFromCashOrdersArray, int $storeOwnerProfileId, float $sumAmount): float
    {
        if (count($storeOwnerDuesFromCashOrdersArray) === 0) {
            return 0.0;
        }

        $paymentsSum = 0.0;

        foreach ($storeOwnerDuesFromCashOrdersArray as $storeOwnerDueFromCashOrderEntity) {
            if ($storeOwnerDueFromCashOrderEntity->getStore()->getId() === $storeOwnerProfileId) {
                $payment = $storeOwnerDueFromCashOrderEntity->getStoreOwnerPaymentFromCompany();

                if ($payment) {
                    $paymentsSum += $payment->getAmount();
                }
            }
        }

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
    public function calculateStoreOwnerDuePaymentSumByStoreOwnerDueFromCashOrderEntitiesArray(array $storeOwnerDueFromCashOrderArray)
    {
        $sum = 0.0;

        $summedPayments = [];

        if (count($storeOwnerDueFromCashOrderArray) > 0) {
            foreach ($storeOwnerDueFromCashOrderArray as $item) {
                $storePaymentFromCompanyEntity = $item->getStoreOwnerPaymentFromCompany();

                if ($storePaymentFromCompanyEntity) {
                    $storePaymentFromCompanyId = $storePaymentFromCompanyEntity->getId();
                    $storePaymentFromCompanyAmount = $storePaymentFromCompanyEntity->getAmount();

                    if (array_search($storePaymentFromCompanyId, $summedPayments) === false) {
                        $summedPayments[] = $storePaymentFromCompanyId;

                        $sum = $sum + $storePaymentFromCompanyAmount;
                    }
                }
            }
        }

        return $sum;
    }

    /**
     * Get array of the start and end dates of each month of an array
     */
    public function getStartAndEndDateTimeOfEachMonthByYear(string $year, string $timeZone = null): array
    {
        return $this->dateFactoryService->getStartAndEndDateTimeOfEachMonthByYear($year, $timeZone);
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
                $paymentSum = $this->calculateStoreOwnerDuePaymentSumByStoreOwnerDueFromCashOrderEntitiesArray($storeOwnersDueFromCashOrdersArray);

                if ($paymentSum === 0.0) {
                    $response[$index]->toBePaid = $response[$index]->amount;

                } else {
                    $response[$index]->toBePaid = $response[$index]->amount - $paymentSum;
                }

                $index++;
            }
        }

        return $response;
    }
}
