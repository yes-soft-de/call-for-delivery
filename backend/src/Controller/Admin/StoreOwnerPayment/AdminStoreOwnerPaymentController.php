<?php

namespace App\Controller\Admin\StoreOwnerPayment;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentCreateRequest;
use App\Request\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentUpdateRequest;
use App\Service\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use OpenApi\Annotations as OA;

/**
 * Create and fetch Payments from store.
 * @Route("v1/admin/storeownerpayment/")
 */
class AdminStoreOwnerPaymentController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminStoreOwnerPaymentService $adminStoreOwnerPaymentService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminStoreOwnerPaymentService $adminStoreOwnerPaymentService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminStoreOwnerPaymentService = $adminStoreOwnerPaymentService;
    }

    /**
     * admin:Create new Payment from store
     * @Route("storeownerpayment", name="createStoreOwnerPayment", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Payment")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="new payment",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="amount"),
     *          @OA\Property(type="number", property="store"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns new payment",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="string", property="amount"),
     *            @OA\Property(type="string", property="date"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createStoreOwnerPayment(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminStoreOwnerPaymentCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStoreOwnerPaymentService->createStoreOwnerPayment($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin:Create new Payment from store
     * @Route("storeownerpayment", name="updateStoreOwnerPayment", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Payment")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="new payment",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="amount"),
     *          @OA\Property(type="number", property="store"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns new payment",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="string", property="amount"),
     *            @OA\Property(type="string", property="date"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateStoreOwnerPayment(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminStoreOwnerPaymentUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStoreOwnerPaymentService->updateStoreOwnerPayment($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin:Get all payments.
     * @Route("storepayments/{storeId}", name="getAllStorePayments", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Payment")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns payments",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *           @OA\Items(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="amount"),
     *              @OA\Property(type="number", property="date"),
     *              @OA\Property(type="string", property="store"),
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllStorePayments($storeId): JsonResponse
    {
        $result = $this->adminStoreOwnerPaymentService->getAllStorePayments($storeId);

        return $this->response($result, self::FETCH);
    }
}
