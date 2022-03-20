<?php

namespace App\Controller\ChatRoom;

use App\Controller\BaseController;
use App\Service\ChatRoom\OrderChatRoomService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

/**
 * fetch chat room between store and captains before order accepted.
 * @Route("v1/orderchatroom/")
 */
class OrderChatRoomController extends BaseController
{
    private OrderChatRoomService $chatRoomService;

    public function __construct(SerializerInterface $serializer, OrderChatRoomService $orderChatRoomService)
    {
        parent::__construct($serializer);
        $this->orderChatRoomService = $orderChatRoomService;
    }

    /**
     * store:fetch order chat rooms for store before order accepted
     * @Route("orderchatroomsforstorebeforeorderaccepted", name="getOrderChatRoomsForStoreBeforeOrderAccepted", methods={"GET"})
     * @return JsonResponse
     * @IsGranted("ROLE_OWNER")
     * @OA\Tag(name="Order Chat Room")
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
     *      description="Returns order chat rooms info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="captainName"),
     *                  @OA\Property(type="string", property="usedAs"),
     *                  @OA\Property(type="object", property="images"),
     *                  @OA\Property(type="string", property="roomId"),
     *                  @OA\Property(type="integer", property="orderId"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getOrderChatRoomsForStoreBeforeOrderAccepted(): JsonResponse
    {
        $result = $this->orderChatRoomService->getOrderChatRoomsForStoreBeforeOrderAccepted($this->getUserId());

        return $this->response($result, self::FETCH);
    }
}
