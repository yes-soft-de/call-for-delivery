<?php

namespace App\Response\ChatRoom;

class OrderChatRoomsStoreResponse
{
    
    /**
     * @var int $id
     */
    public $id;
    
    /**
     * @var string|null $captainName
     */
    public $captainName;

    /**
     * @var string|null $usedAs
     */
    public $usedAs;

    /**
     * @var array|null $images
     */
    public $images;

    /**
     * @var string|null $roomId
     */
    public $roomId;

    /**
     * @var int|null $orderId
     */
    public $orderId;

    /**
     * @var int|null $orderId
     */
    public $captainId;
}
