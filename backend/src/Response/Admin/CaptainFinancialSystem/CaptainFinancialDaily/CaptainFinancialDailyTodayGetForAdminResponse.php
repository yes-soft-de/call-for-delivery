<?php

namespace App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDaily;

use DateTime;
use OpenApi\Annotations as OA;

class CaptainFinancialDailyTodayGetForAdminResponse
{
    /**
     * Captain Profile Id
     */
    public int $id;

    public string $captainName;

    /**
     * @OA\Property(type="array", property="image",
     *     @OA\Items(type="object"))
     */
    public $image;

    /**
     * @var int|null
     */
    public $captainFinancialDailyId;

    public float $amount = 0.0;

    public float $alreadyHadAmount = 0.0;

    public int $financialSystemType = 0;

    /**
     * @var int|null
     */
    public $financialSystemPlan;

    public int $isPaid = 176;

    public bool $withBonus = false;

    public float $bonus = 0.0;

    /**
     * @var DateTime|null
     */
    public $captainFinancialDailyUpdatedAt;
}
