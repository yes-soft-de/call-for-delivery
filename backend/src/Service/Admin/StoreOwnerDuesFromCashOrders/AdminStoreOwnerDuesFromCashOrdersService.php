<?php

namespace App\Service\Admin\StoreOwnerDuesFromCashOrders;

use App\AutoMapping;
use App\Manager\Admin\StoreOwnerDuesFromCashOrders\AdminStoreOwnerDuesFromCashOrdersManager;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreDueSumFromCashOrderFilterByAdminRequest;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrderDeleteByAdminRequest;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersFilterGetRequest;
use App\Response\Admin\StoreOwnerDuesFromCashOrders\StoreDueSumFilterByAdminResponse;
use App\Response\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersResponse;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentFromCompanyService;
use App\Constant\Order\OrderAmountCashConstant;
use App\Service\FileUpload\UploadFileHelperService;

class AdminStoreOwnerDuesFromCashOrdersService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminStoreOwnerDuesFromCashOrdersManager $adminStoreOwnerDuesFromCashOrdersManager,
        private AdminStoreOwnerPaymentFromCompanyService $adminStoreOwnerPaymentFromCompanyService,
        private UploadFileHelperService $uploadFileHelperService
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

            foreach ($allStoreDueFromCashOrder as $key => $value) {//dd($value);
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
}
