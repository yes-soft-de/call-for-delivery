<?php

namespace App\Service\Order;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Manager\Order\OrderManager;
use App\Request\Order\OrderCreateRequest;
use App\Response\Order\OrderResponse;
use Doctrine\ORM\NonUniqueResultException;

class OrderService
{
    public function __construct(private AutoMapping $autoMapping, private OrderManager $orderManager)
    {
    }

}
