<?php

namespace App\Controller\Supplier;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\User\UserRegisterRequest;
use App\Service\Supplier\SupplierProfileService;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

/**
 * @Route("v1/supplier/")
 */
class SupplierProfileController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private SupplierProfileService $supplierProfileService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, SupplierProfileService $supplierService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->supplierProfileService = $supplierService;
    }

    /**
     * Register a new supplier.
     * @Route("registersupplier", name="registerSupplier", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Supplier")
     *
     * @OA\RequestBody(
     *      description="Register a new supplier request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userId"),
     *          @OA\Property(type="string", property="password"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new suppliers' roles and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="array", property="roles",
     *                      @OA\Items(example="user")),
     *                  @OA\Property(type="object", property="createDate"),
     *                  @OA\Property(type="string", property="found")
     *          )
     *      )
     * )
     */
    public function registerSupplier(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserRegisterRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->supplierProfileService->registerSupplier($request);

        if (isset($response->found)) {
            return $this->response($response, self::ERROR_USER_FOUND);
        }

        return $this->response($response, self::CREATE);
    }
}
