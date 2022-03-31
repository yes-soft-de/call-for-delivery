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
use App\Constant\Order\OrderStateConstant;
use App\Response\OrderLogs\OrderLogTimeLineResponse;
use App\Service\DateFactory\DateFactoryService;

class OrderLogsService
{
    private AutoMapping $autoMapping;
    private OrderLogsManager $orderLogsManager;
    private StoreOwnerBranchService $storeOwnerBranchService;
    private DateFactoryService $dateFactoryService;

    public function __construct(AutoMapping $autoMapping, OrderLogsManager $orderLogsManager, StoreOwnerBranchService $storeOwnerBranchService, DateFactoryService $dateFactoryService)
    {
       $this->autoMapping = $autoMapping;
       $this->orderLogsManager = $orderLogsManager;
       $this->storeOwnerBranchService = $storeOwnerBranchService;
       $this->dateFactoryService = $dateFactoryService;
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
     
      $currentStage = $this->orderLogsManager->getCurrentStageDate($orderId);
   
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
}