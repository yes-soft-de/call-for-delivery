<?php

namespace App\Service\Admin\StoreOwnerDuesFromCashOrders;

use App\AutoMapping;
use App\Manager\Admin\StoreOwnerDuesFromCashOrders\AdminStoreOwnerDuesFromCashOrdersManager;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersFilterGetRequest;
use App\Response\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersResponse;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentFromCompanyService;

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
       
        $items = $this->adminStoreOwnerDuesFromCashOrdersManager->filterStoreOwnerDuesFromCashOrders($request);

        foreach ($items as $storeOwnerDuesFromCashOrders) {
            $sumAmountStorOwnerDues = $sumAmountStorOwnerDues + $storeOwnerDuesFromCashOrders['amount'];

            $detail[] = $this->autoMapping->map("array", StoreOwnerDuesFromCashOrdersResponse::class, $storeOwnerDuesFromCashOrders);
        }

        $total = $this->getTotal($sumAmountStorOwnerDues, $request->getStoreId());

        return ['detail' => $detail, 'total' => $total];
    }
    
    public function getTotal($sumAmountStorOwnerDues, $storeId): array
    {
        $sumPaymentsFromCompany = $this->adminStoreOwnerPaymentFromCompanyService->getSumPaymentsFromCompany($storeId);

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
}
