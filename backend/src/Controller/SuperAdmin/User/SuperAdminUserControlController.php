<?php

namespace App\Controller\SuperAdmin\User;

use App\Controller\BaseController;
use App\Service\SuperAdmin\User\SuperAdminUserControlService;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("v1/superadmin/")
 */
class SuperAdminUserControlController extends BaseController
{
    private SuperAdminUserControlService $superAdminUserControlService;

    public function __construct(SerializerInterface $serializer, SuperAdminUserControlService $superAdminStoreOwnerProfileService)
    {
        parent::__construct($serializer);
        $this->superAdminUserControlService = $superAdminStoreOwnerProfileService;
    }

    /**
     * Super admin: update createdAt of all store owners, captains, and users by super admin.
     * @Route("updatecreatedat", name="updateCreatedAtBySuperAdmin", methods={"PUT"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Super Admin")
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new suppliers' roles and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="array", property="storeOwners",
     *                  @OA\Items()
     *              ),
     *              @OA\Property(type="array", property="captains",
     *                  @OA\Items()
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateCreatedAtForAllStoreOwnersAndCaptainsBySuperAdmin(): JsonResponse
    {
        $response = $this->superAdminUserControlService->updateCreatedAtForAllStoreOwnersAndCaptainsBySuperAdmin();

        return $this->response($response, self::UPDATE);
    }
}
