<?php

namespace App\Controller\ChatRoom;

use App\Controller\BaseController;
use App\Service\ChatRoom\ChatRoomService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Security;

/**
 * fetch chat room.
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
      * fetch chat room for user
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
     *                  @OA\Property(type="integer", property="usedAs", description="equal zero mean chat room between admin and user"),
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
}
