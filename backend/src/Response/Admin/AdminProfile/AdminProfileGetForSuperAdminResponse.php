<?php

namespace App\Response\Admin\AdminProfile;

use DateTime;

class AdminProfileGetForSuperAdminResponse
{
    public int $id;

    public string $name;

    /**
     * @var string|null
     */
    public $phone;

    public datetime $createdAt;

    public datetime $updatedAt;

    /**
     * @var array|null
     */
    public $image;

    public bool $state;
}
