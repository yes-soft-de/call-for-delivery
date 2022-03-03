<?php

namespace App\Controller\ChatRoom;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\ChatRoom\ChatRoomCreateRequest;
use App\Service\ChatRoom\ChatRoomService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Security;

/**
 * Create chat room.
 * @Route("v1/chatroom/")
 */
class ChatRoomController extends BaseController
{
    public function __construct(SerializerInterface $serializer, private AutoMapping $autoMapping, private ValidatorInterface $validator, private ChatRoomService $chatRoomService)
    {
        parent::__construct($serializer);
    }
}
