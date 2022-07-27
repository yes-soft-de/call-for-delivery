<?php

namespace App\Response\Admin\OrderLog;


class OrderLogByOrderIdGetForAdminResponse
{
    public int $id;

    public int $type;

    public int $action;

    public int $state;

    public \DateTime $createdAt;

    /**
     * @var string|int
     */
    public $createdBy;

    public int $createdByUserType;

    /**
     * @var bool|null
     */
    public $isCaptainArrivedConfirmation;

    public int $storeOwnerBranchId;

    public int $storeOwnerProfileId;

    /**
     * @var null|int
     */
    public $captainProfileId;

    /**
     * @var null|int
     */
    public $supplierProfileId;

    /**
     * @var null|int
     */
    public $isHide;

    /**
     * @var bool|int
     */
    public $orderIsMain;

    /**
     * @var int|null
     */
    public $primaryOrderId;
}
