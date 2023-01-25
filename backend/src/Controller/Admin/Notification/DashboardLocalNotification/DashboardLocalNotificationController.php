<?php

namespace App\Controller\Admin\Notification\DashboardLocalNotification;

use App\Controller\BaseController;
use App\Service\Notification\DashboardLocalNotification\DashboardLocalNotificationGetService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

/**
 * Fetch Dashboard Local Notification.
 * @Route("v1/admin/dashboardlocalnotification/")
 */
class DashboardLocalNotificationController extends BaseController
{
    public function __construct(
        private DashboardLocalNotificationGetService $dashboardLocalNotificationGetService
    )
    {
    }

    /**
     * admin: get all dashboard local notifications.
     * @Route("dashboardlocalnotification", name="getAllDashboardLocalNotifications", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Dashboard Local Notification")
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
     *                      ref=@Model(type="App\Response\Notification\DashboardLocalNotification\DashboardLocalNotificationGetResponse")
     *              )
     *          )
     *       )
     *    )
     *
     * @Security(name="Bearer")
     */
    public function getAllDashboardLocalNotification(): JsonResponse
    {
        $result = $this->dashboardLocalNotificationGetService->getAllDashboardLocalNotification();

        return $this->response($result, self::FETCH);
    }
}
