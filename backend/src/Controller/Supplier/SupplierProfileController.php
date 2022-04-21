<?php

namespace App\Controller\Supplier;

use App\AutoMapping;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Controller\BaseController;
use App\Request\Supplier\SupplierProfileUpdateRequest;
use App\Request\User\UserRegisterRequest;
use App\Service\Supplier\SupplierProfileService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
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

    /**
     * Supplier: update supplier profile.
     * @Route("supplierprofile", name="updateSupplierProfileBySignedInSupplie", methods={"PUT"})
     * @IsGranted("ROLE_SUPPLIER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Supplier")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Register a new supplier request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="supplierName"),
     *          @OA\Property(type="string", property="phone"),
     *          @OA\Property(type="array", property="images",
     *              @OA\Items(
     *                  @OA\Property(type="string", property="image")
     *              )
     *          ),
     *          @OA\Property(type="integer", property="supplierCategory"),
     *          @OA\Property(type="object", property="location"),
     *          @OA\Property(type="string", property="bankName"),
     *          @OA\Property(type="string", property="bankAccountNumber"),
     *          @OA\Property(type="string", property="stcPay")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the supplier profile info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="supplierName"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="object", property="createdAt")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns supplier profile not exist message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9551"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data", example="supplier profile not exist!")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateSupplierProfile(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SupplierProfileUpdateRequest::class, (object)$data);

        $request->setUser($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->supplierProfileService->updateSupplierProfile($request);

        if ($response === SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST) {
            return $this->response($response, self::SUPPLIER_PROFILE_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * Supplier: get supplier profile.
     * @Route("supplierprofile", name="fetchSupplierProfileBySignedInSupplie", methods={"GET"})
     * @IsGranted("ROLE_SUPPLIER")
     * @return JsonResponse
     *
     * @OA\Tag(name="Supplier")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the supplier profile info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Supplier\SupplierProfileGetResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getSupplierProfileByUserId(): JsonResponse
    {
        $response = $this->supplierProfileService->getSupplierProfileByUserId($this->getUserId());

        return $this->response($response, self::FETCH);
    }
}
