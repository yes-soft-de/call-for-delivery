<?php

namespace App\Response\ChatRoom;

class ChatRoomsStoreResponse
{
    /**
     * @var int|null
     */
    public $userId;

    /**
     * @var int|null $storeOwnerProfileId
     */
    public $storeOwnerProfileId;

    /**
     * @var string|null $storeOwnerName
     */
    public $storeOwnerName;

    /**
     * @var string|null $images
     */
    public $images;

    /**
     * @var string|null $roomId
     */
    public $roomId;
}
