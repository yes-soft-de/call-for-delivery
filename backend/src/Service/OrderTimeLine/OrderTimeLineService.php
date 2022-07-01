<?php

namespace App\Service\OrderTimeLine;

use App\AutoMapping;
use App\Manager\OrderTimeLine\OrderTimeLineManager;
use App\Request\OrderTimeLine\OrderLogsCreateRequest;
use App\Entity\OrderTimeLineEntity;
use App\Entity\OrderEntity;
use App\Response\OrderTimeLine\OrderLogsResponse;
use App\Response\OrderTimeLine\OrderLogsByOrderIdResponse;
use App\Service\StoreOwnerBranch\StoreOwnerBranchService;
use App\Entity\StoreOwnerBranchEntity;
use App\Constant\Order\OrderStateConstant;
use App\Response\OrderTimeLine\OrderLogTimeLineResponse;
use App\Service\DateFactory\DateFactoryService;

class OrderTimeLineService
{
    private AutoMapping $autoMapping;
    private OrderTimeLineManager $orderTimeLineManager;
    private StoreOwnerBranchService $storeOwnerBranchService;
    private DateFactoryService $dateFactoryService;

    public function __construct(AutoMapping $autoMapping, OrderTimeLineManager $orderTimeLineManager, StoreOwnerBranchService $storeOwnerBranchService, DateFactoryService $dateFactoryService)
    {
       $this->autoMapping = $autoMapping;
       $this->orderTimeLineManager = $orderTimeLineManager;
       $this->storeOwnerBranchService = $storeOwnerBranchService;
       $this->dateFactoryService = $dateFactoryService;
    }

    public function createOrderLogs(OrderLogsCreateRequest $request): OrderLogsResponse
    {
       $orderLog = $this->orderTimeLineManager->createOrderLogs($request);
    
       return $this->autoMapping->map(OrderTimeLineEntity::class, OrderLogsResponse::class, $orderLog);
    }
    
    public function createOrderLogsRequest(OrderEntity $order, StoreOwnerBranchEntity $branch = null): OrderLogsResponse
    {
       $request = new OrderLogsCreateRequest();
 
       $request->setOrderId($order);
       $request->setStoreOwnerProfile($order->getStoreOwner());
       $request->setOrderState($order->getState());
       $request->setCaptainProfile($order->getCaptainId());
       $request->setIsCaptainArrived($order->getIsCaptainArrived());
       if($branch) {
         $request->setStoreOwnerBranch($branch);
       }
       
       return $this->createOrderLogs($request);
    }

    public function getOrderLogsByOrderId($orderId): ?array
    {
      $orderLogs = $this->orderTimeLineManager->getOrderTimeLineByOrderId($orderId);
  
      $orderLogs = $this->removeDuplicated($orderLogs);
  
      $currentStage = $this->orderTimeLineManager->getCurrentStage($orderId);
   
      return $this->getOrderLogsTimeLine($orderLogs, $currentStage);
    }
    
    public function getOrderLogsTimeLine(array $orderLogs , array $currentStage): ?array
    {
        $response = [];
        $createDate = "";
        $orderReceivedDate = "";

        foreach ($orderLogs as $orderLog) {

            if($orderLog['orderState'] === OrderStateConstant::ORDER_STATE_PENDING) {
               $createDate = $orderLog['createdAt'];
            }

            if($orderLog['orderState'] === OrderStateConstant::ORDER_STATE_ON_WAY) {
               $orderReceivedDate = $orderLog['createdAt'];
            }

            if($createDate && $currentStage) {
                $state['completionTime'] =   $this->dateFactoryService->subtractTwoDates($createDate, $currentStage['createdAt']);
            }

            if ($orderReceivedDate && $currentStage['createdAt']) {
                    $state['deliveredTime'] =  $this->dateFactoryService->subtractTwoDates($orderReceivedDate, $currentStage['createdAt']);   
            }
        }

        if($currentStage) {
            $state['currentStage'] = $currentStage['orderState'];

            $orderStatus = $this->autoMapping->map('array', OrderLogTimeLineResponse::class, $state);

            $response['orderState'] = $orderStatus ;
            $response['logs'] = $orderLogs ;
        }

        return  $response;
    }

    public function getOrderLogsByOrderIdForAdmin($orderId): ?array
    {
      $orderLogs = $this->orderTimeLineManager->getOrderTimeLineByOrderId($orderId);
     
      $currentStage = $this->orderTimeLineManager->getCurrentStage($orderId);
   
      return $this->getOrderLogsTimeLine($orderLogs, $currentStage);
    }

//this remove item duplicated
    public function removeDuplicated(array $array): ?array
    {
        $temp = array_unique(array_column($array, 'orderState'));

        $logs = array_intersect_key($array, $temp);

        return array_values($logs);
    }
}