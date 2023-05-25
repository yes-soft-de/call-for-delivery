<?php

namespace App\Controller\Security;

use App\Controller\BaseController;
use App\Service\Security\UserSecurityService;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

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
     *      response=401,
     *      description="Returns deleted token info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function logout()
    {

    }
}
