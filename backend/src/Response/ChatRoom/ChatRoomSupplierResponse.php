<?php

namespace App\Response\ChatRoom;

class ChatRoomSupplierResponse
{
    /**
     * @var int|null
     */
    public $userId;

    public int $supplierProfileId;

    public string $supplierName;

    /**
     * @var string|null $images
     */
    public $images;

    public string $roomId;
}
