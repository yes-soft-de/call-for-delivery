<?php

namespace App\Controller\Notification;

use App\AutoMapping;
use App\Constant\User\UserRoleConstant;
use App\Request\Notification\NotificationFirebaseBySuperAdminCreateRequest;
use App\Service\Notification\NotificationFirebaseService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use OpenApi\Annotations as OA;
use Symfony\Component\Routing\Annotation\Route;
use App\Controller\BaseController;
use App\Request\Notification\NotificationFirebaseByUserIdRequest;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use App\Request\Notification\NotificationFirebaseFromAdminRequest;
use App\Constant\Notification\NotificationTokenConstant;

/**
 * firebase Notification.
 * @Route("v1/notificationfirbase/")
 */
class NotificationFirebaseController extends BaseController
{
    private AutoMapping $autoMapping;
    private NotificationFirebaseService $notificationFirebaseService;
    private ValidatorInterface $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, NotificationFirebaseService $notificationFirebaseService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->notificationFirebaseService = $notificationFirebaseService;
        $this->validator = $validator;
    }

    /**
     * notification new chat (between users) or (to admin).
     * @Route("notificationnewchatbyuserid", name="notificationNewChatByOtherUserID", methods={"POST"})
     * @IsGranted("ROLE_USER") 
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
     *              @OA\Property(type="string", property="roomId")
     *        )
     * )
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

        $request = $this->autoMapping->map(stdClass::class,NotificationFirebaseByUserIdRequest::class,(object)$data);

        $request->setUserID($this->getUserId());
       
        if( $this->isGranted('ROLE_CAPTAIN') ) {
            $userType = NotificationTokenConstant::APP_TYPE_STORE;
            $sendByUser = NotificationTokenConstant::APP_TYPE_CAPTAIN;
         }
       
        if( $this->isGranted('ROLE_OWNER') ) {
            $userType = NotificationTokenConstant::APP_TYPE_CAPTAIN;
            $sendByUser = NotificationTokenConstant::APP_TYPE_STORE;
         }

        if ($this->isGranted(UserRoleConstant::ROLE_SUPPLIER)) {
            $userType = NotificationTokenConstant::APP_TYPE_SUPPLIER;
        }

        $response = $this->notificationFirebaseService->notificationNewChatByUserID($request, $userType, $sendByUser);

        return $this->response($response, self::CREATE);
    }

    /**
     * notification new chat (to users) from (admin).
     * @Route("notificationnewchatfromadmin", name="notificationNewChatFromAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN") 
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Notification Firebase")
     *
     *
     *  @OA\RequestBody (
     *        description="notification new chat by other userID",
     *        @OA\JsonContent(
     *              @OA\Property(type="integer", property="otherUserID"),
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
    public function notificationNewChatFromAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, NotificationFirebaseFromAdminRequest::class,(object)$data);
       
        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->notificationFirebaseService->notificationNewChatFromAdmin($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * When you turn this router, a notification should be shown to the captains
     * @Route("notificationtocaptainsfortest", name="notificationToCaptainsForTest", methods={"POST"})
     * @return JsonResponse
     */
    public function notificationToCaptainsForTest(): JsonResponse
    {
        $response = $this->notificationFirebaseService->notificationToCaptains(2);

        return $this->response($response, self::CREATE);
    }

    /**
     * super admin: send firebase notification to user/all captains/all store owners, with customized title and message.
     * @Route("firebasenotificationbysuperadmin", name="sendFirebaseNotificationBySuperAdmin", methods={"POST"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Notification Firebase")
     *
     * @OA\RequestBody (
     *     description="send firebase notification request by super admin",
     *     @OA\JsonContent(
     *         @OA\Property(type="integer", property="otherUserId"),
     *         @OA\Property(type="integer", property="appType"),
     *         @OA\Property(type="string", property="title"),
     *         @OA\Property(type="string", property="messageBody")
     *     )
     * )
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
    public function sendNotificationBySuperAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, NotificationFirebaseBySuperAdminCreateRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->notificationFirebaseService->sendNotificationBySuperAdmin($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * user: delete firebase notification token by user when sign out
     * @Route("firebasenotificationtoken", name="deleteFirebaseNotificationTokenByUser", methods={"DELETE"})
     * @IsGranted("ROLE_USER")
     * @return JsonResponse
     *
     * @OA\Tag(name="Notification Firebase")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=401,
     *      description="Returns deleted token info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Notification\NotificationFirebaseTokenDeleteResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteTokenByUserId(): JsonResponse
    {
        $response = $this->notificationFirebaseService->deleteTokenByUserId($this->getUserId());

        return $this->response($response, self::DELETE);
    }
}
