<?php

namespace App\Response\BidOrder;

use DateTime;

class BidOrderCreateResponse
{
    /**
     * @var int|null
     */
    public $id;

    /**
     * @var string|null
     */
    public $title;

    /**
     * @var string|null
     */
    public $description;

    /**
     * @var DateTime|null
     */
    public $createdAt;

    /**
     * @var DateTime|null
     */
    public $updatedAt;
}
