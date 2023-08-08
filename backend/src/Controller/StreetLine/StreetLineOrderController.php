<?php

namespace App\Controller\StreetLine;

use App\AutoMapping;
use App\Constant\ExternallyDeliveredOrder\ExternallyDeliveredOrderConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\StreetLine\StreetLineOrderStatusUpdateRequest;
use App\Service\StreetLine\StreetLineOrderService;
use Nelmio\ApiDocBundle\Annotation\Model;
use OpenApi\Annotations as OA;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * StreetLine is an external delivery company
 * Updating orders status by StreetLine
 *
 * @Route("v1/streetline/order/")
 */
class StreetLineOrderController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private StreetLineOrderService $streetLineOrderService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * StreetLine webhook: update order status by StreetLine
     * @Route("streetlineorderstatus", name="updateOrderStatusByStreetLine", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="StreetLine Externally Delivered Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update external order status request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status"),
     *          @OA\Property(type="integer", property="id")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns updated order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\StreetLine\StreetLineOrderStatusUpdateResponse")
     *          )
     *      )
     * )
     */
    public function updateStreetLineOrderStatus(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StreetLineOrderStatusUpdateRequest::class, (object)$data);

        $result = $this->streetLineOrderService->updateStreetLineOrderStatus($request);

        if ($result === ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::EXTERNAL_ORDER_NOT_FOUND_CONST);
        }

        return $this->response($result, self::UPDATE);
    }
}
