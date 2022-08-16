<?php

namespace App\Response\ChatRoom;

use OpenApi\Annotations as OA;

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
     * @OA\Property(type="array", property="images",
     *     @OA\Items(type="object"))
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
     * @var int|null $captainId
     */
    public $captainId;
}
