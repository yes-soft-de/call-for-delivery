<?php

namespace App\Controller\Admin\CaptainPayment;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Admin\CaptainPayment\AdminCaptainPaymentToCompanyForOrderCashCreateRequest;
use App\Service\Admin\CaptainPayment\AdminCaptainPaymentToCompanyService;
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
use App\Constant\Captain\CaptainConstant;
use App\Constant\Main\MainErrorConstant;
use App\Constant\Payment\PaymentConstant;

/**
 * Create and fetch Payments from captain.
 * @Route("v1/admin/captainpaymenttocompany/")
 */
class AdminCaptainPaymentToCompanyController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminCaptainPaymentToCompanyService $adminCaptainPaymentToCompanyService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminCaptainPaymentToCompanyService $adminCaptainPaymentToCompanyService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminCaptainPaymentToCompanyService = $adminCaptainPaymentToCompanyService;
    }

    /**
     * admin:Create new Payment from captain for order cash
     * @Route("captainpaymenttocompany", name="createCaptainPaymentToCompany", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Payment To Company")
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
     *          @OA\Property(type="integer", property="captain"),
     *          @OA\Property(type="string", property="note"),
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
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
     *            @OA\Property(type="object", property="createdAt"),
     *            @OA\Property(type="string", property="note"),
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
     *          @OA\Property(type="string", property="status_code", description="9101"),
     *          @OA\Property(type="string", property="msg", description="captain profile not exist! Error."),
     *      )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function createCaptainPaymentToCompany(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCaptainPaymentToCompanyForOrderCashCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainPaymentToCompanyService->createCaptainPaymentToCompany($request);
        
        if($result === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_PROFILE_NOT_EXIST);
        }

        return $this->response($result, self::CREATE);
    }

    /**
     * admin:delete Payment to captain
     * @Route("captainpaymenttocompnay/{id}", name="deleteCaptainPaymentToCompany", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Payment To Company")
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
     *            @OA\Property(type="object", property="createdAt"),
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
    public function deleteCaptainPaymentToCompany($id): JsonResponse
    {
        $result = $this->adminCaptainPaymentToCompanyService->deleteCaptainPaymentToCompany($id);
       
        if($result === PaymentConstant::PAYMENT_NOT_EXISTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::PAYMENT_NOT_EXIST);
        }

        return $this->response($result, self::DELETE);
    }

    /**
     * admin:Get all payments.
     * @Route("captainpaymentstocompany/{captainId}", name="getAllCaptainPaymentsToCompany", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Payment To Company")
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
     *              @OA\Property(type="integer", property="captainId"),
     *              @OA\Property(type="string", property="captainName"),
     *              @OA\Property(type="string", property="note"),
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllCaptainPaymentsToCompany(int $captainId): JsonResponse
    {
        $result = $this->adminCaptainPaymentToCompanyService->getAllCaptainPaymentsToCompany($captainId);

        return $this->response($result, self::FETCH);
    }
}
