<?php

namespace App\Manager\Order;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Repository\OrderEntityRepository;
use App\Request\Order\OrderCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\NonUniqueResultException;

class OrderManager
{
    public function __construct(private AutoMapping $autoMapping, private EntityManagerInterface $entityManager, private OrderEntityRepository $orderRepository)
    {
    }

}
