<?php

namespace App\Controller\Mrsool;

use App\AutoMapping;
use App\Constant\ExternallyDeliveredOrder\ExternallyDeliveredOrderConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\Mrsool\MrsoolOrderStatusUpdateRequest;
use App\Service\Mrsool\MrsoolOrderService;
use Nelmio\ApiDocBundle\Annotation\Model;
use OpenApi\Annotations as OA;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("v1/mrsool/order/")
 */
class MrsoolOrderController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private MrsoolOrderService $mrsoolOrderService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * MRSOOL:
     * @Route("mrsoolorderstatus", name="updateOrderStatusByMrsool", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Mrsool Externally Delivered Order")
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
     *          @OA\Property(type="string", property="state"),
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
     *              ref=@Model(type="App\Response\Mrsool\MrsoolOrderStatusUpdateResponse")
     *          )
     *      )
     * )
     */
    public function updateMrsoolOrderStatus(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, MrsoolOrderStatusUpdateRequest::class, (object)$data);

        $result = $this->mrsoolOrderService->updateMrsoolOrderStatus($request);

        if ($result === ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::EXTERNAL_ORDER_NOT_FOUND_CONST);
        }

        return $this->response($result, self::UPDATE);
    }
}
