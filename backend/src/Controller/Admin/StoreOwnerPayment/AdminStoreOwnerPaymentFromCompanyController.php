<?php

namespace App\Controller\Admin\StoreOwnerPayment;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentFromCompanyForOrderCashCreateRequest;
use App\Service\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentFromCompanyService;
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
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Main\MainErrorConstant;
use App\Constant\Payment\PaymentConstant;
use App\Constant\Order\OrderAmountCashConstant;

/**
 * Create and fetch Payments from company.
 * @Route("v1/admin/storeownerpaymentfromcompany/")
 */
class AdminStoreOwnerPaymentFromCompanyController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private AdminStoreOwnerPaymentFromCompanyService $adminStoreOwnerPaymentFromCompanyService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin: Create new payment from company to store
     * @Route("storeownerpaymentfromcompany", name="createStoreOwnerPaymentFromCompany", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Payment From Company")
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
     *          @OA\Property(type="number", property="amount"),
     *          @OA\Property(type="integer", property="store"),
     *          @OA\Property(type="string", property="note"),
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
     *            @OA\Property(type="number", property="amount"),
     *            @OA\Property(type="object", property="date"),
     *            @OA\Property(type="string", property="note"),
     *            @OA\Property(type="string", property="fromDate"),
     *            @OA\Property(type="string", property="toDate"),
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return erorr.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9157"),
     *          @OA\Property(type="string", property="msg", description="store owner profile not exist! Error."),
     *      )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function createStoreOwnerPaymentFromCompany(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminStoreOwnerPaymentFromCompanyForOrderCashCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStoreOwnerPaymentFromCompanyService->createStoreOwnerPaymentFromCompany($request);
        
        if($result === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::STORE_OWNER_PROFILE_NOT_EXIST);
        }

        if($result === OrderAmountCashConstant::NOT_ORDER_CASH) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_NOT_ORDER_CASH);
        }

        return $this->response($result, self::CREATE);
    }

    /**
     * admin:delete Payment From Company
     * @Route("storeownerpaymentfromcompany/{id}", name="deleteStoreOwnerPaymentFromCompany", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param $id
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
     *      response=401,
     *      description="Returns new payment",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="number", property="amount"),
     *            @OA\Property(type="object", property="date"),
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return erorr.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9501"),
     *          @OA\Property(type="string", property="msg", description="payment not exist!"),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteStoreOwnerPaymentFromCompany($id): JsonResponse
    {
        $result = $this->adminStoreOwnerPaymentFromCompanyService->deleteStoreOwnerPaymentFromCompany($id);
       
        if($result === PaymentConstant::PAYMENT_NOT_EXISTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::PAYMENT_NOT_EXIST);
        }

        return $this->response($result, self::DELETE);
    }

    /**
     * admin:Get all payments.
     * @Route("storepaymentsfromcompany/{storeId}", name="getAllStorePaymentsFromCompany", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $storeId
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Payment From Company")
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
     *              @OA\Property(type="number", property="amount"),
     *              @OA\Property(type="object", property="createdAt"),
     *              @OA\Property(type="integer", property="storeId"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="string", property="note"),
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllStorePaymentsFromCompany(int $storeId): JsonResponse
    {
        $result = $this->adminStoreOwnerPaymentFromCompanyService->getAllStorePaymentsFromCompany($storeId);

        return $this->response($result, self::FETCH);
    }
}
