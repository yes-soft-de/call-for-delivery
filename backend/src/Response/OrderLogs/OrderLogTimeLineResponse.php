<?php

namespace App\Response\OrderLogs;

class OrderLogTimeLineResponse
{
    public $completionTime;

    public $currentStage;
    
    public $deliveredTime;

    public int $id;

    public object $createdAt;

    public string $orderState;
}
