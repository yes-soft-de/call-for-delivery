<?php

namespace App\Service\OrderLogs;

use App\AutoMapping;
use App\Manager\OrderLogs\OrderLogsManager;
use App\Request\OrderLogs\OrderLogsCreateRequest;
use App\Entity\OrderLogsEntity;
use App\Entity\OrderEntity;
use App\Response\OrderLogs\OrderLogsResponse;
use App\Response\OrderLogs\OrderLogsByOrderIdResponse;

class OrderLogsService
{
    private AutoMapping $autoMapping;
    private OrderLogsManager $orderLogsManager;

    public function __construct(AutoMapping $autoMapping, OrderLogsManager $orderLogsManager)
    {
       $this->autoMapping = $autoMapping;
       $this->orderLogsManager = $orderLogsManager;
    }

    public function createOrderLogs(OrderLogsCreateRequest $request): OrderLogsResponse
    {
       $orderLog = $this->orderLogsManager->createOrderLogs($request);
    
       return $this->autoMapping->map(OrderLogsEntity::class, OrderLogsResponse::class, $orderLog);
    }
    
    public function createOrderLogsRequest(OrderEntity $order): OrderLogsResponse
    {
       $request = new OrderLogsCreateRequest();
   
       $request->setOrderId($order);
       $request->setStoreOwnerProfile($order->getStoreOwner());
       $request->setOrderState($order->getState());
       $request->setStoreOwnerBranch($order->storeOrderDetails->getBranch());
       $request->setCaptainProfile($order->getCaptainId());

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
