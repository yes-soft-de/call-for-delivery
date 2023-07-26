<?php

namespace App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDue;

use OpenApi\Annotations as OA;

class CaptainFinancialDueSumFilterByAdminResponse
{
    public float $financialDueAmount;

    public int $captainProfileId;

    public string $captainName;

    public float $toBePaid = 0.0;

    /**
     * @OA\Property(type="array", property="image",
     *     @OA\Items(type="string"))
     */
    public $image;
}
