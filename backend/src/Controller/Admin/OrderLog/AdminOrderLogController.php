<?php

namespace App\Controller\Admin\OrderLog;

use App\Controller\BaseController;
use App\Service\Admin\OrderLog\AdminOrderLogService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("v1/admin/orderlog/")
 */
class AdminOrderLogController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AdminOrderLogService $adminOrderLogService)
    {
        parent::__construct($serializer);
    }

    /**
     * admin: get order logs by order id for admin
     * @Route("orderlogsbyorderidforadmin/{orderId}/{timeZone}", name="fetchOrderLogsByOrderIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $orderId
     * @param string|null $timeZone
     * @return JsonResponse
     *
     * @OA\Tag(name="Order Log")
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
     *      description="Returns orders' logs",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\OrderLog\OrderLogByOrderIdGetForAdminResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterStoreOrdersByAdmin(int $orderId, ?string $timeZone = null): JsonResponse
    {
        $result = $this->adminOrderLogService->getOrderLogsByOrderIdForAdmin($orderId, $timeZone);

        return $this->response($result, self::FETCH);
    }
}
