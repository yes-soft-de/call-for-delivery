<?php

namespace App\Controller\Admin\StoreOwnerSubscription;

use App\Constant\Subscription\SubscriptionDetailsConstant;
use App\Controller\BaseController;
use App\Request\Admin\Subscription\AdminCreateStoreSubscriptionRequest;
use App\Request\Admin\Subscription\AdminExtraSubscriptionForDayRequest;
use App\Request\Admin\Subscription\CreateNewStoreSubscriptionWithSamePackageByAdminRequest;
use App\Request\Admin\Subscription\StoreSubscription\StoreSubscriptionRemainingCarsUpdateByAdminRequest;
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
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Subscription\SubscriptionConstant;

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
     *              @OA\Property(type="array", property="oldSubscriptions",
     *                  @OA\Items(
     *                      ref=@Model(type="App\Response\Admin\StoreOwnerSubscription\AdminStoreSubscriptionResponse")
     *                  )
     *              ),
     *              @OA\Property(type="array", property="currentAndFutureSubscriptions",
     *                  @OA\Items(
     *                      ref=@Model(type="App\Response\Admin\StoreOwnerSubscription\AdminStoreSubscriptionResponse")
     *                  )
     *              )
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
     *          @OA\Property(type="integer", property="storeProfileId"),
     *          @OA\Property(type="integer", property="packageId"),
     *          @OA\Property(type="string", property="note"),
     *      )
     * )
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

    
    /**
     * admin: extra Subscription For Day By Admin
     * @Route("extrasubscriptionforday", name="extraSubscriptionForDayByAdmin", methods={"POST"})
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
     *      description="create extra Subscription",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="storeProfileId"),
     *      )
     * )
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
     *          @OA\Property(type="string", property="status_code", description="9351 or 9157 or 9305 or 9303 or 9302"),
     *          @OA\Property(type="string", property="msg", description="package not exist or store owner profile not exist! or This subscription was previously extended, cannot be extended again or You have subscribed or You do not have a subscription"),
     *        )
     *     )
     * 
     * @Security(name="Bearer")
     */
    public function extraSubscriptionForDayByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminExtraSubscriptionForDayRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStoreSubscriptionService->extraSubscriptionForDayByAdmin($request);
     
        if($result === StoreProfileConstant::STORE_NOT_FOUND){
            return $this->response(MainErrorConstant::ERROR_MSG, self::STORE_OWNER_PROFILE_NOT_EXIST);
        }
        
        if (isset($result->state)) {
            if($result->state === SubscriptionConstant::NOT_POSSIBLE) {
          
                return $this->response(MainErrorConstant::ERROR_MSG, self::NOT_POSSIBLE);
            }
    
            if($result->state === SubscriptionConstant::YOU_HAVE_SUBSCRIBED) {
              
                return $this->response(MainErrorConstant::ERROR_MSG, self::YOU_HAVE_SUBSCRIBED);
            }
    
            if($result->state === SubscriptionConstant::YOU_DO_NOT_HAVE_SUBSCRIBED) {
              
                return $this->response(MainErrorConstant::ERROR_MSG, self::SUBSCRIPTION_UNSUBSCRIBED);
            }
        }
        
        if(isset($result->packageState)){

            return $this->response(MainErrorConstant::ERROR_MSG, self::PACKAGE_NOT_EXIST);
        }

        return $this->response($result, self::CREATE);
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
     *            ref=@Model(type="App\Response\Admin\StoreOwnerSubscription\AdminDeleteSubscriptionResponse")
     *          )
     *      )
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

    /**
     * admin: re-new current subscription by admin
     * @Route("renewcurrentsubscriptionbyadmin", name="reNewCurrentSubscriptionByAdmin", methods={"POST"})
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
     *      description="re-new current subscription by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="storeProfileId"),
     *          @OA\Property(type="string", property="note")
     *      )
     * )
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
     *      response=200,
     *      description="Return error.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9157"),
     *                          @OA\Property(type="string", property="msg", description="store owner profile not exist! Error.")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9302"),
     *                          @OA\Property(type="string", property="msg", description="You do not have a subscription Error.")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9351"),
     *                          @OA\Property(type="string", property="msg", description="package not exist Error.")
     *                   )
     *              }
     *      )
     *
     * )
     *
     * @Security(name="Bearer")
     */
    public function createNewSubscriptionForSamePackageByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CreateNewStoreSubscriptionWithSamePackageByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStoreSubscriptionService->createNewSubscriptionForSamePackageByAdmin($request);

        if ($result === StoreProfileConstant::STORE_NOT_FOUND) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::STORE_OWNER_PROFILE_NOT_EXIST);
        }

        if ($result === SubscriptionConstant::YOU_DO_NOT_HAVE_SUBSCRIBED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUBSCRIPTION_UNSUBSCRIBED);
        }

        if (isset($result->packageState)) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::PACKAGE_NOT_EXIST);
        }

        return $this->response($result, self::CREATE);
    }

    /**
     * admin: update remaining cars of a store subscription
     * @Route("subscriptionremainingcars", name="updateStoreSubscriptionRemainingCarsByAdmin", methods={"PUT"})
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
     *      description="update remaining cars of store subscription",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id", description="subscription id"),
     *          @OA\Property(type="integer", property="factor", description="the amount that will be add/subtract to/from remainingCars"),
     *          @OA\Property(type="string", property="operationType", example="'addition' or 'subtraction'"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns subscription",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *             ref=@Model(type="App\Response\Admin\StoreOwnerSubscription\SubscriptionRemainingCarsUpdateByAdminResponse")
     *      )
     *    )
     *  )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9310"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9311"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9312"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9313"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9314"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9308"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     *
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateStoreSubscriptionRemainingCarsByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreSubscriptionRemainingCarsUpdateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStoreSubscriptionService->updateStoreSubscriptionRemainingCarsByAdmin($request);

        if ($result === SubscriptionDetailsConstant::SUBSCRIPTION_DETAILS_NOT_FOUND) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUBSCRIPTION_DETAILS_NOT_FOUND);

        } elseif ($result === SubscriptionConstant::SUBSCRIPTION_DATE_IS_FINISHED_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUBSCRIPTION_DATE_IS_FINISHED);

        } elseif (SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_IS_FINISHED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUBSCRIPTION_REMAINING_ORDERS_IS_FINISHED);

        } elseif ($result === SubscriptionDetailsConstant::SUBSCRIPTION_REMAINING_ORDERS_OUT_OF_LIMITS_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUBSCRIPTION_REMAINING_ORDERS_IS_OUT_OF_LIMITS);

        } elseif ($result === SubscriptionDetailsConstant::REMAINING_CARS_CAN_NOT_BE_UPDATED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUBSCRIPTION_REMAINING_CARS_NOT_ALLOWED_UPDATE);

        } elseif ($result === SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUBSCRIPTION_NOT_FOUND);
        }

        return $this->response($result, self::UPDATE);
    }
}
