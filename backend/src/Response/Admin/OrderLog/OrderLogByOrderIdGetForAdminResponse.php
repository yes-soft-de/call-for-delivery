<?php

namespace App\Response\Admin\OrderLog;

use OpenApi\Annotations as OA;

class OrderLogByOrderIdGetForAdminResponse
{
    public int $id;

    public int $type;

    public int $action;

    public int $state;

    public \DateTime $createdAt;

    public string|int $createdBy;

    public int $createdByUserType;

    public ?bool $isCaptainArrivedConfirmation;

    public int $storeOwnerBranchId;

    public int $storeOwnerProfileId;

    public ?int $captainProfileId;

    public ?int $supplierProfileId;

    public ?int $isHide;

    public int|bool $orderIsMain;

    public ?int $primaryOrderId;

    /**
     * @OA\Property(type="array", property="images",
     *     @OA\Items(type="object"))
     */
    public $images;

    public string $userJobDescription;
}
