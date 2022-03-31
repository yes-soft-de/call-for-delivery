<?php

namespace App\Response\OrderLogs;

class OrderLogTimeLineResponse
{
    public string $completionTime;

    public string $currentStage;
    
    public string $deliveredTime;

    public int $id;

    public object $createdAt;

    public string $orderState;
}
