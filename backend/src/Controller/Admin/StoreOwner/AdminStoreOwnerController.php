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

    /**
     * admin: Fetch store owner profiles by status.
     * @Route("storeownerprofilesbystatusforadmin/{storeOwnerProfileStatus}", name="fetchStoreOwnerProfileByStatusForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param string $storeOwnerProfileStatus
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
     *      description="Returns store owners' profiles which corresponding with the passed status",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="integer", property="storeOwnerId"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="object", property="images",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="string", property="roomID"),
     *              @OA\Property(type="string", property="city"),
     *              @OA\Property(type="integer", property="storeCategoryId"),
     *              @OA\Property(type="string", property="employeeCount"),
     *              @OA\Property(type="object", property="openingTime"),
     *              @OA\Property(type="object", property="closingTime"),
     *              @OA\Property(type="string", property="status"),
     *              @OA\Property(type="string", property="commission"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOwnersProfilesByStatusForAdmin(string $storeOwnerProfileStatus): JsonResponse
    {
        $response = $this->adminStoreOwnerService->getStoreOwnersProfilesByStatusForAdmin($storeOwnerProfileStatus);

        return $this->response($response, self::FETCH);
    }
}
