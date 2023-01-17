<?php

namespace App\Service\Admin\StoreOwnerDuesFromCashOrders;

use App\AutoMapping;
use App\Manager\Admin\StoreOwnerDuesFromCashOrders\AdminStoreOwnerDuesFromCashOrdersManager;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrderDeleteByAdminRequest;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersFilterGetRequest;
use App\Response\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersResponse;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentFromCompanyService;
use App\Constant\Order\OrderAmountCashConstant;

class AdminStoreOwnerDuesFromCashOrdersService
{
    private AutoMapping $autoMapping;
    private AdminStoreOwnerDuesFromCashOrdersManager $adminStoreOwnerDuesFromCashOrdersManager;
    private AdminStoreOwnerPaymentFromCompanyService $adminStoreOwnerPaymentFromCompanyService;

    public function __construct(AutoMapping $autoMapping, AdminStoreOwnerDuesFromCashOrdersManager $adminStoreOwnerDuesFromCashOrdersManager, AdminStoreOwnerPaymentFromCompanyService $adminStoreOwnerPaymentFromCompanyService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminStoreOwnerDuesFromCashOrdersManager = $adminStoreOwnerDuesFromCashOrdersManager;
        $this->adminStoreOwnerPaymentFromCompanyService = $adminStoreOwnerPaymentFromCompanyService;
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
}
