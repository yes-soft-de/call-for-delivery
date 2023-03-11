<?php

namespace App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDaily;

use OpenApi\Annotations as OA;

class CaptainFinancialDailySumFilterByAdminResponse
{
    public int $id;

    /**
     * @var int|null
     */
    public $captainProfileId;

    /**
     * @var string|null
     */
    public $captainName;

    /**
     * @OA\Property(type="array", property="image",
     *     @OA\Items(type="object"))
     */
    public $image;

    public float $amountSum;

    public float $toBePaid;
}
