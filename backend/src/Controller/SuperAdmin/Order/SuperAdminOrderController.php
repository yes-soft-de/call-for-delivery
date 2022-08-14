<?php

namespace App\Controller\SuperAdmin\Order;

use App\Controller\BaseController;
use App\Service\SuperAdmin\Order\SuperAdminOrderService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("v1/superadmin/order/")
 */
class SuperAdminOrderController extends BaseController
{
    private SuperAdminOrderService $superAdminOrderService;

    public function __construct(SerializerInterface $serializer, SuperAdminOrderService $superAdminOrderService)
    {
        parent::__construct($serializer);
        $this->superAdminOrderService = $superAdminOrderService;
    }

    /**
     * Super admin: update isCaptainPaidToProvider for all delivered orders by super admin.
     * @Route("iscaptainpaidtoproviderbysuperadmin", name="updateIsCaptainPaidToProviderBySuperAdmin", methods={"PUT"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Super Admin")
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the updated orders' info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\SuperAdmin\Order\IsCaptainPaidToProviderUpdateBySuperAdminResponse")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateIsCaptainPaidToProviderForAllDeliveredOrdersBySuperAdmin(): JsonResponse
    {
        $response = $this->superAdminOrderService->updateIsCaptainPaidToProviderForAllDeliveredOrdersBySuperAdmin();

        return $this->response($response, self::UPDATE);
    }
}
