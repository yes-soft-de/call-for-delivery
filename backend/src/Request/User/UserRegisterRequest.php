<?php

namespace App\Request\User;

class UserRegisterRequest
{
    private $userID;

    private $roles = [];

    private $password;

    private $userName;

    public function getUserID()
    {
        return $this->userID;
    }

    public function setUserID($userID)
    {
        $this->userID = $userID;
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
