<?php

namespace App\Message\EPaymentFromStore;

class EPaymentFromStoreLogCreateMessage
{
    private int $createdByUserId;

    /**
     * @var int|null
     */
    private $ePaymentFromStoreId;

    // the int value refers to the resulting action of the payment
    private int $action;

    /**
     * @var string|null
     */
    private $details;

    /**
     * @var int|null
     */
    private $storeOwnerProfileId;

    /**
     * @var int|null
     */
    private $adminProfileId;


//    public function __construct(int $createdByUserId, ?int $ePaymentFromStoreId, int $action, ?string $details, ?int $storeOwnerProfileId, ?int $adminProfileId)
//    {
//        $this->createdByUserId = $createdByUserId;
//        $this->ePaymentFromStoreId = $ePaymentFromStoreId;
//        $this->action = $action;
//        $this->details = $details;
//        $this->storeOwnerProfileId = $storeOwnerProfileId;
//        $this->adminProfileId = $adminProfileId;
//    }

    public static function create(int $createdByUserId, int $action, ?int $storeOwnerProfileId = null, ?int $ePaymentFromStoreId = null, ?int $adminProfileId = null, ?string $details = null): self
    {
        $ePaymentFromStoreLogCreateMessage = new EPaymentFromStoreLogCreateMessage();

        $ePaymentFromStoreLogCreateMessage->ePaymentFromStoreId = $ePaymentFromStoreId;
        $ePaymentFromStoreLogCreateMessage->action = $action;
        $ePaymentFromStoreLogCreateMessage->details = $details;
        $ePaymentFromStoreLogCreateMessage->createdByUserId = $createdByUserId;
        $ePaymentFromStoreLogCreateMessage->storeOwnerProfileId = $storeOwnerProfileId;
        $ePaymentFromStoreLogCreateMessage->adminProfileId = $adminProfileId;

        return $ePaymentFromStoreLogCreateMessage;
    }

    public function getEPaymentFromStoreId(): ?int
    {
        return $this->ePaymentFromStoreId;
    }

    public function getAction(): int
    {
        return $this->action;
    }

    public function getDetails(): ?string
    {
        return $this->details;
    }

    public function getCreatedByUserId(): int
    {
        return $this->createdByUserId;
    }

    public function getStoreOwnerProfileId(): ?int
    {
        return $this->storeOwnerProfileId;
    }

    public function getAdminProfileId(): ?int
    {
        return $this->adminProfileId;
    }
}
