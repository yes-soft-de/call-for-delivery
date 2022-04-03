<?php

namespace App\Controller\Notification;

use App\AutoMapping;
use App\Service\Notification\NotificationTokensService;
use Nelmio\ApiDocBundle\Annotation\Security;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use OpenApi\Annotations as OA;
use Symfony\Component\Routing\Annotation\Route;
use App\Controller\BaseController;
use App\Request\Notification\NotificationTokensCreateRequest;

/**
 * firebase Notification.
 * @Route("v1/notificationtoken/")
 */
class NotificationTokensController extends BaseController
{
    private $autoMapping;
    private $notificationTokensService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, NotificationTokensService $notificationTokensService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->notificationTokensService = $notificationTokensService;
    }

    /**
     * create token.
     * @Route("notificationtoken", name="createNotificationToken", methods={"POST"})
     * @IsGranted("ROLE_USER") 
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Notification Token")
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
     *              @OA\Property(type="string", property="appType", description="store =1, captain=2, all=3"),
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
     *               @OA\Property(type="object", property="appType"),
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createNotificationToken(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,NotificationTokensCreateRequest::class,(object)$data);
        $request->setUserId($this->getUserId());

        $response = $this->notificationTokensService->createNotificationToken($request);
   
        return $this->response($response, self::CREATE);
    }
}
