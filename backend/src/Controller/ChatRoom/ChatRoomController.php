<?php

namespace App\Controller\ChatRoom;

use App\Controller\BaseController;
use App\Service\ChatRoom\ChatRoomService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

/**
 * fetch chat room between admin and user.
 * @Route("v1/chatroom/")
 */
class ChatRoomController extends BaseController
{
    private ChatRoomService $chatRoomService;

    public function __construct(SerializerInterface $serializer, ChatRoomService $chatRoomService)
    {
        parent::__construct($serializer);
        $this->chatRoomService = $chatRoomService;
    }

    /**
     * store and captain :fetch chat room for user
     * @Route("chatroom", name="getChatRoom", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Chat Room")
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
     *      description="Returns chat room info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="userId"),
     *                  @OA\Property(type="integer", property="usedAs", description="equal zero mean chat room between admin and store"),
     *                  @OA\Property(type="string", property="roomId")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getChatRoom(): JsonResponse
    {
        $result = $this->chatRoomService->getChatRoom($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: get chat rooms with stores
     * @Route("chatroomswithstores", name="getChatRoomsWithStores", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Chat Room")
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
     *      description="Returns chat rooms info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *             @OA\Items(
     *                  @OA\Property(type="integer", property="storeOwnerProfileId"),
     *                  @OA\Property(type="integer", property="storeOwnerName"),
     *                  @OA\Property(type="string", property="roomId"),
     *                  @OA\Property(type="object", property="images",
     *                    @OA\Property(type="string", property="imageURL"),
     *                    @OA\Property(type="string", property="image"),
     *                    @OA\Property(type="string", property="baseURL")
     *                 ),
     *              ),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getChatRoomsWithStores(): JsonResponse
    {
        $result = $this->chatRoomService->getChatRoomsWithStores();

        return $this->response($result, self::FETCH);
    }
}
