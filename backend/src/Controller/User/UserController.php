<?php

namespace App\Controller\User;

use App\Controller\BaseController;
use App\Service\User\UserService;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;

/**
 * @Route("v1/user/")
 */
class UserController extends BaseController
{
    private $userService;
   
    public function __construct(SerializerInterface $serializer, UserService $userService)
    {
        parent::__construct($serializer);
        $this->userService = $userService;     
    }

    /**
     * Check user type. This isn't used anymore.
     * @Route("checkUserType/{userType}", name="checkUserType", methods={"POST"})
     * @param $userType
     * @return JsonResponse
     *
     * @OA\Tag(name="Check User")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Parameter(
     *      name="userType",
     *      in="path",
     *      description="ROLE_CLIENT or ROLE_CAPTAIN or ROLE_OWNER"
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Return String",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data"),
     *      )
     * )
     * @Security(name="Bearer")
     */
    public function checkUserType($userType): JsonResponse
    {
        $response = $this->userService->checkUserType($userType,$this->getUserId());
        if($response === "yes") {
            $response ="yes is"." ".$userType;
            return $this->response($response, self::CREATE); 
        }

        if($response === "no") {
            $response ="no not a"." ".$userType;
            return $this->response($response, self::ERROR_USER_CHECK); 
        }
    }

    /**
     * Update verification status of all users by super admin
     * @Route("verifyallusersbysuperadmin", name="updateVerificationStatusForAllUsersBySuperAdmin", methods={"PUT"})
     * @IsGranted("ROLE_SUPER_ADMIN")
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
     * @OA\Response(
     *      response=201,
     *      description="Return String",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\User\FilterUserResponse")
     *              )
     *          ),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function verifyAllUsers(): JsonResponse
    {
        $response = $this->userService->verifyAllUsers();

        return $this->response($response, self::UPDATE);
    }
}
