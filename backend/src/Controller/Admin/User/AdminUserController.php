<?php

namespace App\Controller\Admin\User;

use App\AutoMapping;
use App\Constant\Admin\User\AdminUserConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Controller\BaseController;
use App\Request\Admin\User\UserIdUpdateRequest;
use App\Service\Admin\User\AdminUserService;
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
 * @Route("v1/admin/user/")
 */
class AdminUserController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminUserService $adminUserService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminUserService $adminUserService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminUserService = $adminUserService;
    }

    /**
     * super admin: update userId of a specific user
     * @Route("updateuserid", name="updateUserIdBySuperAdmin", methods={"PUT"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="User")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update userId request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="currentUserId"),
     *          @OA\Property(type="string", property="newUserId"),
     *          @OA\Property(type="string", property="password")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the user's profile info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="204"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\User\UserGetForAdminResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns admin profile does not exist response",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9006"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data", example="wrongPassword")
     *      )
     * )
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns admin profile does not exist response",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9005"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data", example="not created user")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateUserIdBySuperAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserIdUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminUserService->updateUserIdBySuperAdmin($request);

        if ($response === AdminUserConstant::WRONG_PASSWORD) {
            return $this->response($response, self::ERROR_WRONG_PASSWORDS);

        } elseif ($response === UserReturnResultConstant::USER_IS_NOT_CREATED_RESULT) {
            return $this->response($response, self::ERROR_USER_NOT_FOUND);
        }

        return $this->response($response, self::UPDATE);
    }
}
