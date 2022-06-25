<?php

namespace App\Response\Admin\Captain;

class ReadyCaptainsAndCountOfTheirCurrentOrdersResponse
{
    public int $id;

    public int $captainId;

    public string $captainName;

    public array $images;

    public int $countOngoingOrders;

}
