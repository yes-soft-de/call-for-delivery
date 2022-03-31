<?php

namespace App\Request\Admin\AdminProfile;

class FilterAdminProfilesRequest
{
    /**
     * @var string|null
     */
    private $name;

    /**
     * @var string|null
     */
    private $phone;

    /**
     * @var bool|null
     */
    private $status;

    public function getName(): ?string
    {
        return $this->name;
    }

    /**
     * @return string|null
     */
    public function getPhone(): ?string
    {
        return $this->phone;
    }

    /**
     * @return bool|null
     */
    public function getStatus(): ?bool
    {
        return $this->status;
    }
}
