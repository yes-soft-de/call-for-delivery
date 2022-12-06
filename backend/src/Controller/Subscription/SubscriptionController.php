<?php

namespace App\Controller\Subscription;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Subscription\SubscriptionCreateRequest;
use App\Service\Subscription\SubscriptionService;
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
use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Main\MainErrorConstant;
use Nelmio\ApiDocBundle\Annotation\Model;
use App\Request\Subscription\SubscriptionUpdateByAdminRequest;

/**
 * @Route("v1/subscription/")
 */
class SubscriptionController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private SubscriptionService $subscriptionService;
   
    public function __construct( SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface  $validator, SubscriptionService $subscriptionService)
    {
        parent::__construct($serializer);
       
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->subscriptionService = $subscriptionService;
    }

    /**
     * store: create a subscription.
     * @Route("subscription", name="createSubscription", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="new subscription",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="package", description="package id ,required"),
     *          @OA\Property(type="string", property="note"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns new subscription",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="object", property="startDate"),
     *            @OA\Property(type="object", property="endDate"),
     *            @OA\Property(type="string", property="status"),
     *            @OA\Property(type="string", property="note"),
     *      )
     *   )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function createSubscription(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SubscriptionCreateRequest::class, (object)$data);

        $request->setStoreOwner($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->subscriptionService->createSubscription($request);
        if(isset($result->packageState)){

            return $this->response($result, self::PACKAGE_NOT_EXIST);
        }

        return $this->response($result, self::CREATE);
    }

    /**
     * store:get subscriptions to the store owner with the identification of the current subscription.
     * @Route("subscriptionsforstoreowner", name="getSubscriptionsForStoreOwner", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="Returns subscriptions",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *            @OA\Items(
     *                @OA\Property(type="integer", property="id"),
     *                @OA\Property(type="string", property="packageName"),
     *                @OA\Property(type="object", property="startDate"),
     *                @OA\Property(type="object", property="endDate"),
     *                @OA\Property(type="string", property="status"),
     *                @OA\Property(type="string", property="note"),
     *                @OA\Property(type="string", property="isCurrent"),
     *            )
     *        )
     *     )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getSubscriptionForStoreOwner(): JsonResponse
    {
        $result = $this->subscriptionService->getSubscriptionsForStoreOwner($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * store: Get store balance details for the current package.
     * @Route("packagebalance", name="packageBalanceForOwner",methods={"GET"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="Returns package balance",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                @OA\Property(type="integer", property="id"),
     *                @OA\Property(type="integer", property="packageID"),
     *                @OA\Property(type="string", property="packageName"),
     *                @OA\Property(type="integer", property="remainingOrders"),
     *                @OA\Property(type="integer", property="remainingCars"),
     *                @OA\Property(type="object", property="status"),
     *                @OA\Property(type="object", property="startDate"),
     *                @OA\Property(type="integer", property="endDate"),
     *                @OA\Property(type="integer", property="packageCarCount"),
     *                @OA\Property(type="integer", property="packageOrderCount"),
     *        )
     *     )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return error.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9302"),
     *          @OA\Property(type="string", property="msg", description="You do not have a subscription Successfully."),
     *          @OA\Property(type="object", property="Data",
     *                ref=@Model(type="App\Response\Subscription\RemainingOrdersResponse")
     *        )
     *     )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function packageBalance(): JsonResponse
    {
        $result = $this->subscriptionService->packageBalance($this->getUserId());
       
        if( $result->status === SubscriptionConstant::UNSUBSCRIBED ) {

            return $this->response($result, self::SUBSCRIPTION_UNSUBSCRIBED);
        }

        return $this->response($result, self::FETCH);
    }

    /**
     * store: Check the store subscription, and is it possible to create an order .
     * @Route("cancreateorder", name="canCreateOrder",methods={"GET"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="Returns subscription status",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                @OA\Property(type="string", property="canCreateOrder"),
     *                @OA\Property(type="string", property="subscriptionStatus"),
     *                @OA\Property(type="number", property="percentageOfOrdersConsumed"),
     *        )
     *     )
     * )
     * 
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return error.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9151"),
     *          @OA\Property(type="string", property="msg", description="error store inactive Error."),
     *        )
     *     )
     * 
     * @Security(name="Bearer")
     */
    public function canCreateOrder(): JsonResponse
    {
        $result = $this->subscriptionService->canCreateOrder($this->getUserId());
       
        if ($result === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
      
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_STORE_INACTIVE);
        }

        return $this->response($result, self::FETCH);
    }

    /**
     * store: Create Subscription For One Day.
     * @Route("extrasubscriptionforday", name="CreateSubscriptionForOneDay", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
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
     *      response=201,
     *      description="Returns new subscription",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="object", property="startDate"),
     *            @OA\Property(type="object", property="endDate"),
     *            @OA\Property(type="string", property="status"),
     *            @OA\Property(type="string", property="note"),
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns new subscription",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9303 or 9304 or 9305"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="string", property="state"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function subscriptionForOneDay(): JsonResponse
    {
        $result = $this->subscriptionService->subscriptionForOneDay($this->getUserId());
     
        if (isset($result->state)) {
            if($result->state === SubscriptionConstant::NOT_POSSIBLE) {
          
                return $this->response($result, self::NOT_POSSIBLE);
            }
    
            if($result->state === SubscriptionConstant::YOU_HAVE_SUBSCRIBED) {
              
                return $this->response($result, self::YOU_HAVE_SUBSCRIBED);
            }
    
            if($result->state === SubscriptionConstant::YOU_DO_NOT_HAVE_SUBSCRIBED) {
              
                return $this->response($result, self::SUBSCRIPTION_UNSUBSCRIBED);
            }
        }
        
        if(isset($result->packageState)){

            return $this->response($result, self::PACKAGE_NOT_EXIST);
        }
        
        return $this->response($result, self::CREATE);
    }
    
    /**
     * store:get subscriptions with payments.
     * @Route("subscriptionswithpayment", name="getSubscriptionsWithPayments", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
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
     *             ref=@Model(type="App\Response\Subscription\StoreSubscriptionResponse")
     *      )
     *    )
     *  ) 
     *
     * @Security(name="Bearer")
     */
    public function getSubscriptionsWithPayments(): JsonResponse
    {
        $result = $this->subscriptionService->getSubscriptionsWithPayments($this->getUserId());

        return $this->response($result, self::FETCH);
    }
    
    /**
     * admin: update current subscription of a store to a new one
     * @Route("subscriptionbyadmin", name="updateSubscriptionByAdmin", methods={"PUT"})
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
     *      description="update current subscription's package by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id", description="current subscription id"),
     *          @OA\Property(type="integer", property="package", description="package id")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns succeded updating message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data", example="ok")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateSubscription(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SubscriptionUpdateByAdminRequest::class, (object)$data);

        $result = $this->subscriptionService->updateSubscription($request);

        return $this->response($result, self::UPDATE);
    }
}
