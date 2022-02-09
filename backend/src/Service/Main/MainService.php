<?php

namespace App\Service\Main;

use App\AutoMapping;
use App\Request\Main\CheckBackendHeathRequest;
use App\Response\Main\BackendHealthCheckGetResponse;
use App\Service\User\UserService;

class MainService
{
    private $autoMapping;
    private $userService;

    public function __construct(AutoMapping $autoMapping, UserService $userService)
    {
        $this->autoMapping = $autoMapping;
        $this->userService = $userService;
    }

    public function checkBackendHealth($userId)
    {
        $response = [];

        $userRole = $this->userService->getUserRoleByUserId($userId);

        if ($userRole) {
            $response['userRole'] = $userRole['roles'];
        }

        $response['result'] = 'Heart is beating';

        return $this->autoMapping->map('array', BackendHealthCheckGetResponse::class, $response);
    }
}
