<?php

namespace App\Service\OrderLogs;

use App\AutoMapping;
use App\Manager\OrderLogs\OrderLogsManager;
use App\Request\OrderLogs\OrderLogsCreateRequest;
use App\Entity\OrderLogsEntity;
use App\Entity\OrderEntity;
use App\Response\OrderLogs\OrderLogsResponse;
use App\Response\OrderLogs\OrderLogsByOrderIdResponse;
use App\Service\StoreOwnerBranch\StoreOwnerBranchService;
use App\Entity\StoreOwnerBranchEntity;

class OrderLogsService
{
    private AutoMapping $autoMapping;
    private OrderLogsManager $orderLogsManager;
    private StoreOwnerBranchService $storeOwnerBranchService;

    public function __construct(AutoMapping $autoMapping, OrderLogsManager $orderLogsManager, StoreOwnerBranchService $storeOwnerBranchService)
    {
       $this->autoMapping = $autoMapping;
       $this->orderLogsManager = $orderLogsManager;
       $this->storeOwnerBranchService = $storeOwnerBranchService;
    }

    public function createOrderLogs(OrderLogsCreateRequest $request): OrderLogsResponse
    {
       $orderLog = $this->orderLogsManager->createOrderLogs($request);
    
       return $this->autoMapping->map(OrderLogsEntity::class, OrderLogsResponse::class, $orderLog);
    }
    
    public function createOrderLogsRequest(OrderEntity $order, StoreOwnerBranchEntity $branch = null): OrderLogsResponse
    {
       $request = new OrderLogsCreateRequest();
 
       $request->setOrderId($order);
       $request->setStoreOwnerProfile($order->getStoreOwner());
       $request->setOrderState($order->getState());
       $request->setCaptainProfile($order->getCaptainId());
       if($branch) {
         $request->setStoreOwnerBranch($branch);
       }
       return $this->createOrderLogs($request);
    }

    public function getOrderLogsByOrderId($orderId): ?array
    {
      $orderLogs = $this->orderLogsManager->getOrderLogsByOrderId($orderId);
      
       foreach($orderLogs as $orderLog) {
         $response[] = $this->autoMapping->map("array", OrderLogsByOrderIdResponse::class, $orderLog);            
      }

      return $response;
    }

}
