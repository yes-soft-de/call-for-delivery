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
     *        )
     *     )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function canCreateOrder(): JsonResponse
    {
        $result = $this->subscriptionService->canCreateOrder($this->getUserId());

        return $this->response($result, self::FETCH);
    }
}
