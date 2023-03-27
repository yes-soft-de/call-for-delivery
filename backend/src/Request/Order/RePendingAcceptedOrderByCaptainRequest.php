<?php

namespace App\Request\Order;

class RePendingAcceptedOrderByCaptainRequest
{
    /**
     * order id
     *
     * @var int
     */
    private int $id;

    public function getId(): int
    {
        return $this->id;
    }
}
