<?php

namespace App\Controller\Notification;

use App\AutoMapping;
use App\Service\Notification\NotificationFirebaseService;
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

        $request = $this->autoMapping->map(stdClass::class,NotificationFirebaseByUserIdRequest::class,(object)$data);

        $request->setUserID($this->getUserId());
       
        if( $this->isGranted('ROLE_CAPTAIN') ) {
            $userType = NotificationTokenConstant::APP_TYPE_STORE;
         }
       
        if( $this->isGranted('ROLE_OWNER') ) {
            $userType = NotificationTokenConstant::APP_TYPE_CAPTAIN;
         }

        $response = $this->notificationFirebaseService->notificationNewChatByUserID($request, $userType);

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
}
