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

/**
 * @Route("v1/admin/subscription/")
 */
class AdminStoreSubscriptionController extends BaseController
{
    private AdminStoreSubscriptionService $adminStoreSubscriptionService;
   
    public function __construct( SerializerInterface $serializer, AdminStoreSubscriptionService $adminStoreSubscriptionService)
    {
        parent::__construct($serializer);
       
        $this->adminStoreSubscriptionService = $adminStoreSubscriptionService;
    }

    /**
     * admin:get subscriptions with payments.
     * @Route("subscriptionswithpayment/{storeId}", name="getSubscriptionsWithPaymentsForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
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
     *             ref=@Model(type="App\Service\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentService")
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
}
