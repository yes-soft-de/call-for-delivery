<?php

namespace App\Controller\Subscription;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Subscription\SubscriptionCreateRequest;
use App\Request\Subscription\SubscriptionNextRequest;
use App\Request\Subscription\SubscriptionUpdateStateRequest;
use App\Service\Subscription\SubscriptionService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\Validator\Constraints\Json;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Security;

/**
 * @Route("v1/subscription/")
 */
class SubscriptionController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $subscriptionService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping,
     ValidatorInterface $validator, SubscriptionService $subscriptionService)
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
     * @Route("nextsubscription", name="nextSubscription", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     */
    public function nextSubscription(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SubscriptionNextRequest::class, (object)$data);

        $request->setOwnerID($this->getUserId());

        // $violations = $this->validator->validate($request);

        // if (\count($violations) > 0) {
        //     $violationsString = (string) $violations;

        //     return new JsonResponse($violationsString, Response::HTTP_OK);
        // }

        $result = $this->subscriptionService->nextSubscription($request);

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
        $result = $this->subscriptionService->getSubscriptionForStoreOwner($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("subscriptionUpdateState", name="SubscriptionUpdateState", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     */
    public function subscriptionUpdateState(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, SubscriptionUpdateStateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->subscriptionService->subscriptionUpdateState($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("getSubscriptionsPending", name="getSubscriptionsPending", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getSubscriptionsPending()
    {
        $result = $this->subscriptionService->getSubscriptionsPending();

        return $this->response($result, self::FETCH);
    }
    
    /**
     * @Route("getSubscriptionById/{id}", name="getSubscriptionById", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     */
    public function getSubscriptionById($id)
    {
        $result = $this->subscriptionService->getSubscriptionById($id);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/dashboardContracts/{year}/{month}", name="dashboardContracts",methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param                                     Request $request
     * @return                                    JsonResponse
     */
    public function dashboardContracts($year, $month)
    {
        $result = $this->subscriptionService->dashboardContracts($year, $month);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/packagebalance", name="packageBalanceForOwner",methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     */
    public function packageBalance(): JsonResponse
    {
        $result = $this->subscriptionService->packagebalance($this->getUserId());

        return $this->response($result, self::FETCH);
    }
}
