<?php

namespace App\Controller\Notification;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Service\Notification\NotificationLocalService;
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
 * Create and fetch order.
 * @Route("v1/notificationlocal/")
 */
class NotificationLocalController extends BaseController
{
    private $notificationLocalService;

    public function __construct(SerializerInterface $serializer, NotificationLocalService $notificationLocalService)
    {
        parent::__construct($serializer);
        $this->notificationLocalService = $notificationLocalService;
    }
    
    /**
     * Get local notifications.
     * @Route("notificationsLocal", name="getLocalNotifications", methods={"GET"})
     * 
     * @OA\Tag(name="Local Notification")
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
     *      description="Returns Local Notifications For Store",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *             @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="title"),
     *                  @OA\Property(type="object", property="message",
     *                      @OA\Property(type="string", property="text"),
     *                      @OA\Property(type="integer", property="orderId"),
     *                  ),
     *              ),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getLocalNotifications(): JsonResponse
    {
        $result = $this->notificationLocalService->getLocalNotifications($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * Delete local notifications.
     * @Route("notificationLocal/{id}", name="deleteLocalNotification", methods={"DELETE"})
     * 
     * @OA\Tag(name="Local Notification")
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
     *      description="Returns Local Notification",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *             @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="title"),
     *                  @OA\Property(type="object", property="message",
     *                      @OA\Property(type="string", property="text"),
     *                      @OA\Property(type="integer", property="orderId"),
     *                  ),
     *              ),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteLocalNotification($id): JsonResponse
    {
        $result = $this->notificationLocalService->deleteLocalNotification($id);

        return $this->response($result, self::DELETE);
    }
}
