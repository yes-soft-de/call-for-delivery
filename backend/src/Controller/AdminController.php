<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\UserRegisterRequest;
use App\Service\AdminService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class AdminController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $adminService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminService $adminService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminService = $adminService;
    }

    /**
     * Create new admin.
     * @Route("createadmin", name="createAdmin", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     */
    public function adminRegister(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserRegisterRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminService->adminRegister($request);
        if (isset($response->found)) {
            return $this->response($response, self::ERROR_USER_FOUND);
        }
        return $this->response($response, self::CREATE);
    }
}
