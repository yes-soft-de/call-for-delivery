<?php

namespace App\Controller\Admin\StoreOwnerSubscription;

use App\Controller\BaseController;
use App\Service\Admin\StoreOwnerSubscription\AdminStoreSubscriptionService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Security;
use Nelmio\ApiDocBundle\Annotation\Model;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use App\Request\Admin\Subscription\AdminCreateStoreSubscriptionRequest;
use App\Constant\Main\MainErrorConstant;
use App\AutoMapping;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use stdClass;
use App\Constant\StoreOwner\StoreProfileConstant;

/**
 * @Route("v1/admin/subscription/")
 */
class AdminStoreSubscriptionController extends BaseController
{
    private AdminStoreSubscriptionService $adminStoreSubscriptionService;
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
   
    public function __construct( SerializerInterface $serializer, AdminStoreSubscriptionService $adminStoreSubscriptionService, AutoMapping $autoMapping, ValidatorInterface  $validator)
    {
        parent::__construct($serializer);
       
        $this->adminStoreSubscriptionService = $adminStoreSubscriptionService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }

    /**
     * admin:get subscriptions with payments.
     * @Route("subscriptionswithpayment/{storeId}", name="getSubscriptionsWithPaymentsForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $storeId
     * @return JsonResponse
     *
     * @OA\Tag(name="Subscription")
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
     *      description="Returns subscriptions with payments",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *             ref=@Model(type="App\Response\Admin\StoreOwnerSubscription\AdminStoreSubscriptionResponse"),
     *      )
     *    )
     *  )
     *
     * @Security(name="Bearer")
     */
    public function getSubscriptionsWithPaymentsSpecificStore(int $storeId): JsonResponse
    {
        $result = $this->adminStoreSubscriptionService->getSubscriptionsWithPaymentsSpecificStore($storeId);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: delete all future subscriptions of a store
     * @Route("deleteallfuturesubscriptionsbyadmin/{storeOwnerId}", name="deleteAllFutureSubscriptionsOfStoreByAdmin", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $storeOwnerId
     * @return JsonResponse
     *
     * @OA\Tag(name="Subscription")
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
     *      description="Returns deleted future subscriptions info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *             ref=@Model(type="App\Response\Admin\StoreOwnerSubscription\StoreFutureSubscriptionGetForAdminResponse"),
     *      )
     *    )
     *  )
     *
     * @Security(name="Bearer")
     */
    public function deleteAllStoreFutureSubscriptionsByStoreOwnerId(int $storeOwnerId): JsonResponse
    {
        $result = $this->adminStoreSubscriptionService->deleteAllStoreFutureSubscriptionsByStoreOwnerId($storeOwnerId);

        return $this->response($result, self::DELETE);
    }

    /**
     * admin: create subscription
     * @Route("createsubscription", name="createSubscriptionByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Subscription")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create subscription",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="storeProfileId"),
     *              @OA\Property(type="integer", property="packageId"),
     *              @OA\Property(type="string", property="note"),
     *      )
     *    )
     *  )
     *
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns subscription",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *             @OA\Property(type="integer", property="id")
     *      )
     *    )
     *  )
     * 
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return error.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9351 or 9157"),
     *          @OA\Property(type="string", property="msg", description="package not exist or store owner profile not exist!"),
     *        )
     *     )
     * 
     * @Security(name="Bearer")
     */
    public function createSubscription(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCreateStoreSubscriptionRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStoreSubscriptionService->createSubscription($request);

        if($result === StoreProfileConstant::STORE_NOT_FOUND){
            return $this->response(MainErrorConstant::ERROR_MSG, self::STORE_OWNER_PROFILE_NOT_EXIST);
        }

        if(isset($result->packageState)){

            return $this->response(MainErrorConstant::ERROR_MSG, self::PACKAGE_NOT_EXIST);
        }

        return $this->response($result, self::CREATE);
    }
}
