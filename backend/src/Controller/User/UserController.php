<?php

namespace App\Controller\User;

use App\Constant\User\UserTypeConstant;
use App\Controller\BaseController;
use App\Service\User\UserService;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
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
    private UserService $userService;
   
    public function __construct(SerializerInterface $serializer, UserService $userService)
    {
        parent::__construct($serializer);
        $this->userService = $userService;     
    }

    /**
     * Check user type.
     * @Route("checkUserType/{userType}", name="checkUserTypeByUserRami", methods={"POST"})
     * @param string $userType
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
     *          @OA\Property(type="string", property="Data")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function checkUserType(string $userType): JsonResponse
    {
        $response = $this->userService->checkUserType($userType, $this->getUserId());

        if ($response === UserTypeConstant::USER_TYPE_MATCHED) {
            $response = "yes is"." ".$userType;
            return $this->response($response, self::CREATE);
//            return new JsonResponse(["status_code" => "201",
//                    "msg" => "created  Successfully.",
//                    "Data" => $response
//                ]
//                , Response::HTTP_OK);
        }

//        if ($response === "no") {
        $response = "no not a"." ".$userType;

        return $this->response($response, self::ERROR_USER_CHECK);
//        return new JsonResponse(["status_code" => "9000",
//                "msg" => "error user check Successfully.",
//                "Data" => $response
//            ]
//            , Response::HTTP_OK);
//        }
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
