<?php

namespace App\Service\OrderTimeLine;

use App\AutoMapping;
use App\Constant\OrderTimeLine\OrderTimeLineResultConstant;
use App\Manager\OrderTimeLine\OrderTimeLineManager;
use App\Request\OrderTimeLine\OrderLogsCreateRequest;
use App\Entity\OrderTimeLineEntity;
use App\Entity\OrderEntity;
use App\Response\OrderTimeLine\OrderLogsResponse;
use App\Entity\StoreOwnerBranchEntity;
use App\Constant\Order\OrderStateConstant;
use App\Response\OrderTimeLine\OrderLogTimeLineResponse;
use App\Response\OrderTimeLine\OrderTimelineCaptainProfileUpdateResponse;
use App\Service\DateFactory\DateFactoryService;

class OrderTimeLineService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private OrderTimeLineManager $orderTimeLineManager,
        private DateFactoryService $dateFactoryService)
    {
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
       $request->setPaidToProvider($order->getPaidToProvider());
       $request->setIsCashPaymentConfirmedByStore($order->getIsCashPaymentConfirmedByStore());

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

        $orderLogs = $this->removeDuplicated($orderLogs);

        $currentStage = $this->orderTimeLineManager->getCurrentStage($orderId);
   
      return $this->getOrderLogsTimeLine($orderLogs, $currentStage);
    }

    /**
     * this remove item duplicated
     */
    public function removeDuplicated(array $array): ?array
    {
        $temp = array_unique(array_column($array, 'orderState'));

        $logs = array_intersect_key($array, $temp);

        return array_values($logs);
    }

    /**
     * Update captainProfile field to null for each order timeline record related to specific captain
     */
    public function updateOrderTimelineCaptainProfileToNullByCaptainUserId(int $captainUserId): array|int
    {
        $orderTimelineUpdateResult = $this->orderTimeLineManager->updateOrderTimelineCaptainProfileToNullByCaptainUserId($captainUserId);

        if ($orderTimelineUpdateResult === OrderTimeLineResultConstant::ORDER_TIMELINE_NOT_EXIST_CONST) {
            return OrderTimeLineResultConstant::ORDER_TIMELINE_NOT_EXIST_CONST;
        }

        $response = [];

        foreach ($orderTimelineUpdateResult as $orderTimelineEntity) {
            $response[] = $this->autoMapping->map(OrderTimeLineEntity::class, OrderTimelineCaptainProfileUpdateResponse::class,
                $orderTimelineEntity);
        }

        return $response;
    }
}
