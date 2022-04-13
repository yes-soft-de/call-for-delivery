<?php

namespace App\Controller\Notification;

use App\AutoMapping;
use App\Constant\User\UserRoleConstant;
use App\Service\Notification\NotificationTokensService;
use Nelmio\ApiDocBundle\Annotation\Security;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Symfony\Component\Routing\Annotation\Route;
use App\Controller\BaseController;
use App\Request\Notification\NotificationTokensCreateRequest;
use App\Constant\Notification\NotificationTokenConstant;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Symfony\Component\HttpFoundation\Response;

/**
 * firebase Notification.
 * @Route("v1/notificationtoken/")
 */
class NotificationTokensController extends BaseController
{
    private AutoMapping $autoMapping;
    private NotificationTokensService $notificationTokensService;
    private ValidatorInterface $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, NotificationTokensService $notificationTokensService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->notificationTokensService = $notificationTokensService;
        $this->validator = $validator;
    }

    /**
     * create token.
     * @Route("notificationtoken", name="createNotificationToken", methods={"POST"})
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
       
        if( $this->isGranted('ROLE_CAPTAIN') ) {
            $request->setAppType(NotificationTokenConstant::APP_TYPE_CAPTAIN);
         }
        if( $this->isGranted('ROLE_OWNER') ) {
            $request->setAppType(NotificationTokenConstant::APP_TYPE_STORE);
         }
        if( $this->isGranted('ROLE_ADMIN') ) {
            $request->setAppType(NotificationTokenConstant::APP_TYPE_ADMIN);
         }

        if ($this->isGranted(UserRoleConstant::ROLE_SUPPLIER)) {
            $request->setAppType(NotificationTokenConstant::APP_TYPE_SUPPLIER);
        }
 
         $violations = $this->validator->validate($request);
         if (\count($violations) > 0) {
             $violationsString = (string) $violations;
 
             return new JsonResponse($violationsString, Response::HTTP_OK);
         }

        $response = $this->notificationTokensService->createNotificationToken($request);
   
        return $this->response($response, self::CREATE);
    }
}
