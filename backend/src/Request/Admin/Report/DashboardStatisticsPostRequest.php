<?php

namespace App\Request\Admin\Report;

class DashboardStatisticsPostRequest
{
    /**
     * @var null|string
     */
    private $customizedTimezone;

    public function getCustomizedTimezone(): ?string
    {
        return $this->customizedTimezone;
    }
}
