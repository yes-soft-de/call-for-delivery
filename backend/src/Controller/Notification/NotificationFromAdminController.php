<?php

namespace App\Controller\Notification;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Service\Notification\NotificationFromAdminService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use OpenApi\Annotations as OA;
use App\Constant\Notification\NotificationConstant;

/**
 * fetch Notification from admin.
 * @Route("v1/notificationfromadmin/")
 */
class NotificationFromAdminController extends BaseController
{
    private NotificationFromAdminService $notificationFromAdminService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, NotificationFromAdminService $notificationFromAdminService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->notificationFromAdminService = $notificationFromAdminService;
    }

    /**
     * store: Get notifications from admin.
     * @Route("notificationsfromadminforstore", name="getAllNotificationsFromAdminForStore", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     *
     * @OA\Tag(name="Notification FROM ADMIN")
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
     *                      @OA\Property(type="object", property="createdAt"),
     *              )
     *          )
     *       )
     *    )
     *
     * @Security(name="Bearer")
     */
    public function getAllNotificationsFromAdminForStore(): JsonResponse
    {
        $result = $this->notificationFromAdminService->getAllNotificationsFromAdmin($this->getUserId(), NotificationConstant::APP_TYPE_STORE);

        return $this->response($result, self::FETCH);
    }
    
    /**
     * captain: Get notifications from admin.
     * @Route("notificationsfromadminforcaptain", name="getAllNotificationsFromAdminForCaptain", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Notification FROM ADMIN")
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
     *                      @OA\Property(type="object", property="createdAt"),
     *              )
     *          )
     *       )
     *    )
     *
     * @Security(name="Bearer")
     */
    public function getAllNotificationsFromAdminForCaptain(): JsonResponse
    {
        $result = $this->notificationFromAdminService->getAllNotificationsFromAdmin($this->getUserId(), NotificationConstant::APP_TYPE_CAPTAIN);

        return $this->response($result, self::FETCH);
    }

    /**
     * supplier: Get all notifications from admin.
     * @Route("notificationsfromadminforsupplier", name="getAllNotificationsFromAdminForSupplier", methods={"GET"})
     * @IsGranted("ROLE_SUPPLIER")
     * @return JsonResponse
     *
     * @OA\Tag(name="Notification FROM ADMIN")
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
     *                      @OA\Property(type="object", property="createdAt"),
     *              )
     *          )
     *       )
     *    )
     *
     * @Security(name="Bearer")
     */
    public function getAllNotificationsFromAdminForSupplier(): JsonResponse
    {
        $result = $this->notificationFromAdminService->getAllNotificationsFromAdmin($this->getUserId(), NotificationConstant::APP_TYPE_SUPPLIER);

        return $this->response($result, self::FETCH);
    }
}
