<?php

namespace App\Request\User;

class UserRegisterRequest
{
    private $userId;

    private $roles = [];

    private $password;

    private $userName;

    public function getUserId()
    {
        return $this->userId;
    }

    public function setUserId($userId)
    {
        $this->userId = $userId;
    }

    public function getRoles()
    {
        return $this->roles;
    }

    public function setRoles(array $roles)
    {
        $this->roles = $roles;
    }

    public function getPassword()
    {
        return $this->password;
    }

    public function setPassword($password)
    {
        $this->password = $password;
    }

    public function getUserName()
    {
        return $this->userName;
    }
 
    public function setUserName($userName)
    {
        $this->userName = $userName;
    }
}
