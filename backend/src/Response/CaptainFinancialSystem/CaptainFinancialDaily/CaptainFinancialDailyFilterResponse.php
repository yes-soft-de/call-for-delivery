<?php

namespace App\Response\CaptainFinancialSystem\CaptainFinancialDaily;

use DateTime;
use OpenApi\Annotations as OA;

class CaptainFinancialDailyFilterResponse
{
    public int $id;

    public float $amount;

    // captain financial due which he/she had received before.
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

    // *** Captain Payment related info *** //
    /**
     * @OA\Property(type="array", property="captainPayments",
     *     @OA\Items(type="object"))
     */
    public $captainPayments = [];

//    /**
//     * @var int|null
//     */
//    public $paymentId;
//
//    /**
//     * @var float|null
//     */
//    public $paymentAmount;
//
//    /**
//     * @var DateTime|null
//     */
//    public $paymentCreatedAt;
//
//    /**
//     * @var string|null
//     */
//    public $paymentNote;
    // *** End of Captain Payment related info *** //
}
