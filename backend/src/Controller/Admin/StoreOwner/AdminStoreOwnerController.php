<?php

namespace App\Controller\Admin\StoreOwner;

use App\Controller\BaseController;
use App\Service\Admin\StoreOwner\AdminStoreOwnerService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("v1/admin/storeowner/")
 */
class AdminStoreOwnerController extends BaseController
{
    private AdminStoreOwnerService $adminStoreOwnerService;

    public function __construct(SerializerInterface $serializer, AdminStoreOwnerService $adminStoreOwnerService)
    {
        parent::__construct($serializer);
        $this->adminStoreOwnerService = $adminStoreOwnerService;
    }

    /**
     * admin: fetch store owner profiles by id.
     * @Route("storeownerprofilebyidforadmin/{storeOwnerProfileId}", name="fetchStoreOwnerProfileByIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $storeOwnerProfileId
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin Store Owner")
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
     *      description="Returns store owner profile which corresponding with the passed id",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\StoreOwner\StoreOwnerProfileByIdGetByAdminResponse")
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOwnerProfileByIdForAdmin(int $storeOwnerProfileId): JsonResponse
    {
        $response = $this->adminStoreOwnerService->getStoreOwnerProfileByIdForAdmin($storeOwnerProfileId);

        return $this->response($response, self::FETCH);
    }
}
