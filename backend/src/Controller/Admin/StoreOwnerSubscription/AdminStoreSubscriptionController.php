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
use App\Request\Admin\Subscription\AdminDeleteSubscriptionRequest;
use stdClass;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use App\Constant\Payment\PaymentConstant;
use App\Constant\Main\MainErrorConstant;
use App\AutoMapping;

/**
 * @Route("v1/admin/subscription/")
 */
class AdminStoreSubscriptionController extends BaseController
{
    private AdminStoreSubscriptionService $adminStoreSubscriptionService;
    private ValidatorInterface $validator;
    private AutoMapping $autoMapping;
   
    public function __construct( SerializerInterface $serializer, AdminStoreSubscriptionService $adminStoreSubscriptionService, ValidatorInterface $validator, AutoMapping $autoMapping)
    {
        parent::__construct($serializer);
       
        $this->adminStoreSubscriptionService = $adminStoreSubscriptionService;
        $this->validator = $validator;
        $this->autoMapping = $autoMapping;
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
     * admin: delete subscription with payments
     * @Route("deletesubscriptionbyadmin", name="deleteSubscriptionByAdmin", methods={"POST"})
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
     *      description="delete subscription with payments",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="integer", property="deletePayment"),
     *      )
     * )
     * 
     * @OA\Response(
     *      response=401,
     *      description="Returns deleted subscription info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *             ref=@Model(type="App\Response\Admin\StoreOwnerSubscription\StoreFutureSubscriptionGetForAdminResponse"),
     *      )
     *    )
     *  )
     * 
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return erorr.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9307"),
     *          @OA\Property(type="string", property="msg", description="there are payment related with subscription"),
     *      )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function deleteSubscriptionByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminDeleteSubscriptionRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStoreSubscriptionService->deleteSubscriptionByAdmin($request);

        if($result === PaymentConstant::THERE_ARE_PAYMENT_RELATED_WITH_SUBSCRIPTION) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_THERE_ARE_PAYMENT_RELATED_WITH_SUBSCRIPTION);
        }

        return $this->response($result, self::DELETE);
    }
}
