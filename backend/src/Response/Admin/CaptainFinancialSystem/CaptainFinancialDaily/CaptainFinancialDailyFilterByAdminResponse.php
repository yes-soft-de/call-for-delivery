<?php

namespace App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDaily;

use DateTime;
use OpenApi\Annotations as OA;

class CaptainFinancialDailyFilterByAdminResponse
{
    public int $id;

    public int $captainProfileId;

    public string $captainName;

    public float $amount;

    public float $alreadyHadAmount;

    public int $financialSystemType;

    /**
     * @var int|null
     */
    public $financialSystemPlan;

    public int $isPaid;

    public bool $withBonus;

    public float $bonus;

    public DateTime $createdAt;

    public DateTime $updatedAt;

    /**
     * @OA\Property(type="array", property="captainPayments",
     *     @OA\Items(type="object"))
     */
    public $captainPayments = [];
}
