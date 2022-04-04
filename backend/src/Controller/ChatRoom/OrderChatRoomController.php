<?php

namespace App\Controller\ChatRoom;
use App\AutoMapping;
use App\Controller\BaseController;
use App\Service\ChatRoom\OrderChatRoomService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use App\Request\ChatRoom\OrderChatRoomRequest;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use stdClass;

/**
 * fetch chat room between store and captains before order accepted.
 * @Route("v1/orderchatroom/")
 */
class OrderChatRoomController extends BaseController
{
    private OrderChatRoomService $orderChatRoomService;
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;

    public function __construct(SerializerInterface $serializer, OrderChatRoomService $orderChatRoomService, AutoMapping $autoMapping, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->orderChatRoomService = $orderChatRoomService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
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
     *                  @OA\Property(type="integer", property="captainId"),
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

    /**
     * captain: Create new order chat room before order accepted.
     * @Route("createneworderchatroom", name="createNewOrderChatRoom", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     * @IsGranted("ROLE_CAPTAIN")
     *
     * @OA\Tag(name="Order Chat Room")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     * 
     * @OA\RequestBody(
     *      description="Create new order chat room",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="orderId"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new roomId",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="string", property="roomId"),
     *                  @OA\Property(type="object", property="createdAt"),
     *          )
     *      )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function createNewOrderChatRoom(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        
        $request = $this->autoMapping->map(stdClass::class, OrderChatRoomRequest::class, (object)$data);
        $request->setUserId($this->getUserId());
        $violations = $this->validator->validate($request);
        if(\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->orderChatRoomService->createNewOrderChatRoom($request);

        return $this->response($response, self::CREATE);
    }
}
