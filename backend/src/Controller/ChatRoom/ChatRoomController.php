<?php

namespace App\Controller\ChatRoom;

use App\Controller\BaseController;
use App\Service\ChatRoom\ChatRoomService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Model;
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
     *                  ref=@Model(type="App\Response\ChatRoom\ChatRoomsStoreResponse")
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

    /**
     * admin: get chat rooms with captains
     * @Route("chatroomswithcaptains", name="getChatRoomsWithCaptains", methods={"GET"})
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
     *                  ref=@Model(type="App\Response\ChatRoom\ChatRoomCaptainResponse")
     *              ),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getChatRoomsWithCaptains(): JsonResponse
    {
        $result = $this->chatRoomService->getChatRoomsWithCaptains();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: get chat rooms with suppliers
     * @Route("chatroomswithsuppliers", name="getChatRoomsWithSuppliers", methods={"GET"})
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
     *                  ref=@Model(type="App\Response\ChatRoom\ChatRoomSupplierResponse")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getChatRoomsWithSuppliers(): JsonResponse
    {
        $result = $this->chatRoomService->getChatRoomsWithSuppliers();

        return $this->response($result, self::FETCH);
    }
}
