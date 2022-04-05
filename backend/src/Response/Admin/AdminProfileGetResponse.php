<?php

namespace App\Response\Admin;

class AdminProfileGetResponse
{
    /**
     * @var int|null
     */
    public $id;

    /**
     * @var string|null
     */
    public $name;

    /**
     * @var string|null
     */
    public $phone;

    /**
     * @var array|null
     */
    public $createdAt;

    /**
     * @var array|null
     */
    public $updatedAt;

    /**
     * @var array|null
     */
    public $images;

    /**
     * @var bool|null
     */
    public $status;
}