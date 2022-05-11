<?php

namespace App\Controller\ResetPassword;

use App\AutoMapping;
use App\Constant\Main\MainErrorConstant;
use App\Constant\ResetPassword\ResetPasswordResultConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Controller\BaseController;
use App\Request\ResetPassword\ResetPasswordOrderCreateRequest;
use App\Request\ResetPassword\VerifyResetPasswordCodeRequest;
use App\Request\User\UserPasswordUpdateRequest;
use App\Service\ResetPassword\ResetPasswordOrderService;
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
 * @Route("v1/resetpassword/")
 */
class ResetPasswordOrderController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private ResetPasswordOrderService $resetPasswordOrderService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, ResetPasswordOrderService $resetPasswordOrderService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->resetPasswordOrderService = $resetPasswordOrderService;
    }

    /**
     * @Route("resetpasswordorder", name="createResetPasswordOrderByUser", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Reset Password Order")
     *
     * @OA\RequestBody(
     *      description="Create new reset password order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userId"),
     *          @OA\Property(type="string", property="role", example="ROLE_CAPTAIN")
     *      )
     * )
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns the creation date of the reset password order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example=""),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  ref=@Model(type="App\Response\ResetPassword\ResetPasswordOrderGetResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns user not found message and status code",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9005"),
     *          @OA\Property(type="string", property="msg")
     *      )
     * )
     */
    public function createResetPasswordOrder(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ResetPasswordOrderCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->resetPasswordOrderService->createResetPasswordOrder($request);

        if ($result->status === UserReturnResultConstant::USER_NOT_FOUND_RESULT) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_USER_NOT_FOUND);
        }

        return $this->response($result, self::CREATE);
    }

    /**
     * check if sent code is a valid one or not
     * @Route("verifyresetpasswordcode", name="verifyResetPasswordCodeByUser", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Reset Password Order")
     *
     * @OA\RequestBody(
     *      description="verify reset password code by user request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="code"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the result of the verification process",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="200, or 9152, or 9153"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  ref=@Model(type="App\Response\ResetPassword\ResetPasswordOrderGetResponse")
     *          )
     *      )
     * )
     */
    public function verifyResetPasswordCode(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, VerifyResetPasswordCodeRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->resetPasswordOrderService->verifyResetPasswordCode($request);

        if ($result->status === ResetPasswordResultConstant::INVALID_RESET_PASSWORD_CODE) {
            return $this->response($result, self::CODE_DATE_IS_NOT_VALID);

        } elseif ($result->status === ResetPasswordResultConstant::NO_RESET_PASSWORD_CODE_IS_EXIST) {
            return $this->response($result, self::INCORRECT_ENTERED_DATA);
        }

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("updatepassword", name="updateUserPassword", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Reset Password Order")
     *
     * @OA\RequestBody(
     *      description="update old password request fields",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userId"),
     *          @OA\Property(type="string", property="password")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the info of the updated user",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example=""),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  ref=@Model(type="App\Response\User\UserRegisterResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns user not found error",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9005"),
     *          @OA\Property(type="string", property="msg")
     *      )
     * )
     */
    public function updateUserPassword(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserPasswordUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->resetPasswordOrderService->updateUserPassword($request);

        if ($result === UserReturnResultConstant::USER_NOT_FOUND_RESULT) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_USER_NOT_FOUND);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * super admin: get all reset password orders by super admin
     * @Route("resetpasswordordersbysuperadmin", name="getAllResetPasswordOrdersBySuperAdmin", methods={"GET"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Reset Password Order")
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
     *      description="Returns the info of all reset password orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  ref=@Model(type="App\Response\Admin\ResetPassword\ResetPasswordOrderGetForSuperAdminResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllResetPasswordOrdersBySuperAdmin(): JsonResponse
    {
        $result = $this->resetPasswordOrderService->getAllResetPasswordOrdersBySuperAdmin();

        return $this->response($result, self::FETCH);
    }
}
