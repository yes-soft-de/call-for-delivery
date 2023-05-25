<?php

namespace App\Controller\Security;

use App\Constant\Main\MainErrorConstant;
use App\Constant\Notification\NotificationTokenConstant;
use App\Controller\BaseController;
use App\Service\Security\UserSecurityService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("v1/user/security/")
 */
class UserSecurityController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private UserSecurityService $userSecurityService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * user: logout
     * @Route("logout", name="logout", methods={"GET"})
     *
     * @OA\Tag(name="User Security")
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
     *      description="Returns deleted token info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Security\UserLogoutResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function logout(): JsonResponse
    {
        $response = $this->userSecurityService->logout($this->getUserId());

        if ($response === NotificationTokenConstant::TOKEN_NOT_FOUND) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::NOTIFICATION_FIREBASE_TOKEN_NOT_FOUND_CONST);
        }

        return $this->response($response, self::FETCH);
    }
}
