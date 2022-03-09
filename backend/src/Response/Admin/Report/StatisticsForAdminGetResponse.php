<?php

namespace App\Response\Admin\Report;

class StatisticsForAdminGetResponse
{
    public int $activeStoresCount;

    public int $inactiveStoresCount;

    public int $ongoingOrdersCount;

    public int $allOrdersCount;
}
