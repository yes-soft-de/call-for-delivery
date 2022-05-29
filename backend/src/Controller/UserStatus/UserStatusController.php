<?php

namespace App\Controller\UserStatus;

use App\AutoMapping;
use App\Constant\Main\MainErrorConstant;
use App\Constant\UserStatus\UserStatusConstant;
use App\Controller\BaseController;
use App\Request\UserStatus\UserStatusUpdateRequest;
use App\Service\UserStatus\UserStatusService;
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
 * @Route("v1/userstatus/")
 */
class UserStatusController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private UserStatusService $userStatusService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, UserStatusService $userStatusService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->userStatusService = $userStatusService;
    }

    /**
     * Update user status by user
     * @Route("userstatus", name="updateUserStatusByUser", methods={"PUT"})
     * @IsGranted("ROLE_USER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="User Status")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update user status request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the new status",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\UserStatus\UserStatusUpdateResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns wrong user status error",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9012"),
     *          @OA\Property(type="string", property="msg")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateUserStatus(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserStatusUpdateRequest::class, (object)$data);

        $request->setId($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->userStatusService->updateUserStatus($request);

        if ($response === UserStatusConstant::WRONG_USER_STATUS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_USER_WRONG_STATUS);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * Activate all users by super admin
     * @Route("activateallusersbysuperadmin", name="updateAllUserStatusBySuperAdmin", methods={"PUT"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="User Status")
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
     *      description="Returns the new status",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\UserStatus\UserStatusUpdateResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function activateAllUsersBySuperAdmin(): JsonResponse
    {
        $response = $this->userStatusService->activateAllUsersBySuperAdmin();

        return $this->response($response, self::UPDATE);
    }
}
