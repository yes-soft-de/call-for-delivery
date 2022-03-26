<?php

namespace App\Response\Admin\AdminProfile;

use App\Entity\UserEntity;
use DateTime;

class AdminProfileGetForSuperAdminResponse
{
    public int $id;

    /**
     * @var UserEntity|array
     */
    public $user;

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
