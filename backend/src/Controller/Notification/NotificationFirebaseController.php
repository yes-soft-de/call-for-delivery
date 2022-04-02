<?php

namespace App\Controller\Notification;

use App\AutoMapping;
use App\Service\Notification\NotificationFirebaseService;
use Nelmio\ApiDocBundle\Annotation\Security;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use OpenApi\Annotations as OA;
use Symfony\Component\Routing\Annotation\Route;
use App\Controller\BaseController;
use App\Request\Notification\NotificationFirebaseTokenCreateRequest;

/**
 * firebase Notification.
 * @Route("v1/notificationfirbase/")
 */
class NotificationFirebaseController extends BaseController
{
    private $autoMapping;
    private $notificationFirebaseService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, NotificationFirebaseService $notificationFirebaseService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->notificationFirebaseService = $notificationFirebaseService;
    }

    /**
     * create token.
     * @Route("notificationfirebasetoken", name="createNotificationFirebaseToken", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Notification Firebase")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     *  @OA\RequestBody (
     *        description="create token",
     *        @OA\JsonContent(
     *              @OA\Property(type="string", property="token"),
     *               ),
     *         ),
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns object",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               @OA\Property(type="integer", property="id"),
     *               @OA\Property(type="string", property="token"),
     *               @OA\Property(type="object", property="createdAt"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createNotificationFirebaseToken(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,NotificationFirebaseTokenCreateRequest::class,(object)$data);
        $request->setUserId($this->getUserId());

        $response = $this->notificationFirebaseService->createNotificationFirebaseToken($request);
   
        return $this->response($response, self::CREATE);
    }


    /**
     * notification new chat.
     * @Route("/notificationnewchatanonymous", name="notificationNewChatAnonymous", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Notification Firebase")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     *  @OA\RequestBody (
     *        description="notification new chat",
     *        @OA\JsonContent(
     *              @OA\Property(type="string", property="anonymousChatID"),
     *               ),
     *         ),
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns object",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items()
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function notificationNewChatAnonymous(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,NotificationNewChatAnonymousRequest::class,(object)$data);

        $response = $this->notificationService->notificationNewChatAnonymous($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * notification new chat by other UserID.
     * @Route("/notificationnewchatbyuserid", name="notificationnewchatByOtherUserID", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Notification Firebase")
     *
     *
     *  @OA\RequestBody (
     *        description="notification new chat by other userID",
     *        @OA\JsonContent(
     *              @OA\Property(type="integer", property="otherUserID", description="if null send new msg notification to admins"),
     *              @OA\Property(type="string", property="chatRoomID", description="if the client is anonymous you must send your support roomID"),
     *               ),
     *         ),
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns object",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items()
     *          )
     *      )
     * )
     */
    public function notificationNewChatByUserID(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,NotificationTokenByUserIDRequest::class,(object)$data);

        if( $this->isGranted('ROLE_CLIENT') ) {
           $request->setUserID($this->getUserId());
        }

        $response = $this->notificationService->notificationNewChatByUserID($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/notificationtocaptainsfortest", name="notificationToCaptainsForTest", methods={"POST"})
     * @return JsonResponse
     */
    public function notificationToCaptainsForTest(Request $request): JsonResponse
    {
        $response = $this->notificationService->notificationToCaptains($request);

        return $this->response($response, self::CREATE);
    }
}
