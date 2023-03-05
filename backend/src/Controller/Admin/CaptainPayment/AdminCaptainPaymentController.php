<?php

namespace App\Controller\Admin\CaptainPayment;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Constant\CaptainPayment\PaymentToCaptain\CaptainPaymentResultConstant;
use App\Controller\BaseController;
use App\Request\Admin\CaptainPayment\AdminCaptainPaymentCreateRequest;
use App\Request\Admin\CaptainPayment\PaymentToCaptain\CaptainPaymentAmountAndNoteUpdateByAdminRequest;
use App\Request\Admin\CaptainPayment\PaymentToCaptain\CaptainPaymentDeleteByAdminRequest;
use App\Request\Admin\CaptainPayment\PaymentToCaptain\CaptainPaymentForCaptainFinancialDailyCreateByAdminRequest;
use App\Service\Admin\CaptainPayment\AdminCaptainPaymentService;
use Nelmio\ApiDocBundle\Annotation\Model;
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
 * Create and fetch Payments to captain.
 * @Route("v1/admin/captainpayment/")
 */
class AdminCaptainPaymentController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private AdminCaptainPaymentService $adminCaptainPaymentService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin:Create new Payment to captain
     * @Route("captainpayment", name="createCaptainPayment", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Payment")
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
     *            @OA\Property(type="string", property="captainFinancialDuesId"),
     *            @OA\Property(type="string", property="status"),
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
    public function createCaptainPayment(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCaptainPaymentCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainPaymentService->createCaptainPayment($request);
        
        if($result === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_PROFILE_NOT_EXIST);
        }

        return $this->response($result, self::CREATE);
    }

    /**
     * admin:delete Payment to captain
     * @Route("captainpayment/{id}", name="deleteCaptainPayment", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param $id
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Payment")
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
    public function deleteCaptainPayment($id): JsonResponse
    {
        $result = $this->adminCaptainPaymentService->deleteCaptainPayment($id);
       
        if ($result === PaymentConstant::PAYMENT_NOT_EXISTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::PAYMENT_NOT_EXIST);

        } elseif ($result === CaptainPaymentResultConstant::CAPTAIN_PAYMENT_LINKED_TO_CAPTAIN_FINANCIAL_DAILY_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::PAYMENT_TO_CAPTAIN_LINKED_WITH_CAPTAIN_FINANCIAL_DAILY_CONST);
        }

        return $this->response($result, self::DELETE);
    }

    /**
     * admin:Get all payments which paid to a specific captain by admin.
     * @Route("captainpayments/{captainId}", name="getAllCaptainPayments", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $captainId
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Payment")
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
    public function getAllCaptainPayments(int $captainId): JsonResponse
    {
        $result = $this->adminCaptainPaymentService->getAllCaptainPayments($captainId);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: create payment for captain financial daily
     * @Route("captainpaymentforcaptainfinancialdaily", name="createCaptainPaymentForCaptainFinancialDailyByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Payment")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create a new payment for captain financial daily request",
     *      @OA\JsonContent(
     *          @OA\Property(type="number", property="amount"),
     *          @OA\Property(type="string", property="note"),
     *          @OA\Property(type="integer", property="captainFinancialDailyEntity", description="captain financial daily id")
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
     *              ref=@Model(type="App\Response\Admin\CaptainPayment\PaymentToCaptain\CaptainPaymentForCaptainFinancialDailyCreateByAdminResponse")
     *          )
     *      )
     * )
     *
     * @OA\Response(
     *      response="200",
     *      description="Return error.",
     *      @OA\JsonContent(
     *           oneOf={
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9650"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9651"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createCaptainPaymentForCaptainFinancialDailyAmount(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainPaymentForCaptainFinancialDailyCreateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainPaymentService->createCaptainPaymentForCaptainFinancialDailyAmount($request);

        if ($result === CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST);

        } elseif ($result === CaptainPaymentResultConstant::CAPTAIN_PAYMENT_CREATE_FOR_CAPTAIN_FINANCIAL_DAILY_ERROR_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_FINANCIAL_DAILY_CREATE_ERROR_CONST);
        }

        return $this->response($result, self::CREATE);
    }

    /**
     * admin: Delete payment to captain linked with captain financial daily
     * @Route("captainpaymentforcaptainfinancialdaily", name="deleteCaptainPaymentLinkedWithCaptainFinancialDaily", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Payment")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="delete payment to captain by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id")
     *      )
     * )
     *
     * @OA\Response(
     *      response=401,
     *      description="Returns deleted payment info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="number", property="amount"),
     *              @OA\Property(type="object", property="createdAt")
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="200",
     *      description="Return error.",
     *      @OA\JsonContent(
     *           oneOf={
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9501"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9503"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteCaptainPaymentRelatedToCaptainFinancialDailyAmount(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainPaymentDeleteByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainPaymentService->deleteCaptainPaymentRelatedToCaptainFinancialDailyAmount($request);

        if ($result === CaptainPaymentResultConstant::CAPTAIN_PAYMENT_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::PAYMENT_NOT_EXIST);

        } elseif ($result === CaptainPaymentResultConstant::CAPTAIN_PAYMENT_LINKED_TO_CAPTAIN_FINANCIAL_DUE_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::PAYMENT_TO_CAPTAIN_LINKED_WITH_CAPTAIN_FINANCIAL_DUE_CONST);
        }

        return $this->response($result, self::DELETE);
    }

    /**
     * admin: Update specific payment to captain
     * @Route("updatecaptainpaymentbyadmin", name="updatePaymentToCaptainByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Payment")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update payment to captain by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="number", property="amount"),
     *          @OA\Property(type="string", property="note")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns updated payment info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\CaptainPayment\PaymentToCaptain\CaptainPaymentAmountAndNoteUpdateByAdminResponse")
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="200",
     *      description="Return error.",
     *      @OA\JsonContent(
     *           oneOf={
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9501"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateCaptainPaymentAmountAndNoteByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainPaymentAmountAndNoteUpdateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainPaymentService->updateCaptainPaymentAmountAndNoteByAdmin($request);

        if ($result === CaptainPaymentResultConstant::CAPTAIN_PAYMENT_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::PAYMENT_NOT_EXIST);
        }

        return $this->response($result, self::UPDATE);
    }
}
