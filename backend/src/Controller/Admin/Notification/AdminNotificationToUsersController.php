<?php

namespace App\Controller\Admin\Notification;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Admin\Notification\AdminNotificationCreateRequest;
use App\Request\Admin\Notification\AdminNotificationUpdateRequest;
use App\Service\Admin\Notification\AdminNotificationToUsersService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use OpenApi\Annotations as OA;

/**
 * Create and fetch Notification from admin to users.
 * @Route("v1/admin/notification/")
 */
class AdminNotificationToUsersController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminNotificationToUsersService $adminNotificationToUsersService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminNotificationToUsersService $adminNotificationToUsersService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminNotificationToUsersService = $adminNotificationToUsersService;
    }

    /**
     * admin: Create Admin Notification To Apps
     * @Route("notificationtoapp", name="createAdminNotificationToApp", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin Notification ")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="new notification",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="title"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="appType", description="stores or captains or all"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns new notification",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="string", property="title"),
     *            @OA\Property(type="string", property="msg"),
     *            @OA\Property(type="string", property="appType"),
     *            @OA\Property(type="integer", property="userId"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createAdminNotificationToUsers(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminNotificationCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);

        }
        
        $result = $this->adminNotificationToUsersService->createAdminNotificationToUsers($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin: Update Admin Notification
     * @Route("adminnotification", name="updateAdminNotification", methods={"Put"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin Notification")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update notification",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="title"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="appType"),
     *          @OA\Property(type="integer", property="userId"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns notification",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="string", property="title"),
     *            @OA\Property(type="string", property="msg"),
     *            @OA\Property(type="string", property="appType"),
     *            @OA\Property(type="integer", property="userId"),
     *      ),
     *   ),
     * )
     *
     * or
     * 
     * @OA\Response(
     *      response="default",
     *      description="Returns notification",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9401"),
     *          @OA\Property(type="string", property="msg", description="notification not exist Successfully."),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="state"),
     *      ),
     *   ),
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateAdminNotification(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, AdminNotificationUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminNotificationToUsersService->updateAdminNotification($request);

        if(isset($result->state)) {
         
            return $this->response($result, self::NOTIFICATION_NOT_FOUND);
        } 

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: delete Admin Notification
     * @Route("adminnotification/{id}", name="deleteAdminNotification", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param $id
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin Notification")
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
     *      description="Returns notification",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="string", property="title"),
     *            @OA\Property(type="string", property="msg"),
     *            @OA\Property(type="string", property="appType"),
     *            @OA\Property(type="integer", property="userId"),
     *      ),
     *   ),
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns notification",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9401"),
     *          @OA\Property(type="string", property="msg", description="notification not exist Successfully."),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="state"),
     *      ),
     *   ),
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteAdminNotification($id): JsonResponse
    {
        $result = $this->adminNotificationToUsersService->deleteAdminNotification($id);

        if(isset($result->state)) {
         
            return $this->response($result, self::NOTIFICATION_NOT_FOUND);
        } 

        return $this->response($result, self::DELETE);
    }

    /**
     * admin: get notifications.
     * @Route("adminnotifications", name="getAllNotificationsForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin Notification")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns notifications ",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *                  @OA\Items(
     *                      @OA\Property(type="integer", property="id"),
     *                      @OA\Property(type="string", property="title"),
     *                      @OA\Property(type="string", property="msg"),
     *                      @OA\Property(type="string", property="appType"),
     *                      @OA\Property(type="integer", property="userId"),
     *              )
     *          )
     *       )
     *    )
     *
     * @Security(name="Bearer")
     */
    public function getAllNotificationsForAdmin(): JsonResponse
    {
        $result = $this->adminNotificationToUsersService->getAllNotificationsForAdmin();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: get notification by id.
     * @Route("adminnotification/{id}", name="getNotificationByIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $id
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin Notification")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns notification ",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                      @OA\Property(type="integer", property="id"),
     *                      @OA\Property(type="string", property="title"),
     *                      @OA\Property(type="string", property="msg"),
     *                      @OA\Property(type="string", property="appType"),
     *                      @OA\Property(type="integer", property="userId"),
     *          )
     *       )
     *    )
     *
     * @Security(name="Bearer")
     */
    public function getNotificationByIdForAdmin($id): JsonResponse
    {
        $result = $this->adminNotificationToUsersService->getNotificationByIdForAdmin($id);

        return $this->response($result, self::FETCH);
    }
}
