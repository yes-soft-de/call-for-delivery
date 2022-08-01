<?php

namespace App\Controller\Admin\StoreOwnerSubscription;

use App\AutoMapping;
use App\Constant\CaptainOfferConstant\CaptainOfferConstant;
use App\Constant\Main\MainErrorConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Subscription\SubscriptionCaptainOffer;
use App\Constant\Subscription\SubscriptionConstant;
use App\Controller\BaseController;
use App\Request\Admin\Subscription\AdminCaptainOfferSubscriptionCreateRequest;
use App\Request\Admin\Subscription\CaptainOfferSubscriptionDeleteByAdminRequest;
use App\Service\Admin\StoreOwnerSubscription\AdminCaptainOfferSubscriptionService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

/**
 * @Route("v1/admin/subscriptioncaptainoffer/")
 */
class AdminCaptainOfferSubscriptionController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminCaptainOfferSubscriptionService $adminCaptainOfferSubscriptionService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminCaptainOfferSubscriptionService $adminCaptainOfferSubscriptionService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminCaptainOfferSubscriptionService = $adminCaptainOfferSubscriptionService;
    }

    /**
     * Admin: Create Captain Offer Subscription for store by admin.
     * @Route("subscribe", name="createCaptainOfferSubscriptionByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Subscription Captain Offer")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create new captain offer subscription by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="captainOffer"),
     *          @OA\Property(type="integer", property="storeOwner")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns new captain offer subscription",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\StoreOwnerSubscription\AdminCaptainOfferSubscriptionCreateResponse")
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createCaptainOfferSubscriptionByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCaptainOfferSubscriptionCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainOfferSubscriptionService->createCaptainOfferSubscriptionByAdmin($request);

        if ($result === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::STORE_OWNER_PROFILE_NOT_EXIST);
        }

        if ($result === CaptainOfferConstant::CAPTAIN_OFFER_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_OFFER_NOT_EXIST);
        }

        if (isset($result->subscriptionState)) {
            if ($result->subscriptionState === SubscriptionConstant::SUBSCRIPTION_NOT_FOUND) {
                return $this->response($result, self::ERROR_SUBSCRIPTION_CAN_NOT_CREATE_OFFER);
            }

            if ($result->subscriptionState === SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_CAN_NOT_SUBSCRIPTION) {
                return $this->response($result, self::ERROR_YOU_HAVE_SUBSCRIPTION_);
            }
        }

        return $this->response($result, self::CREATE);
    }

    /**
     * Admin: delete captain offer subscription by admin depending on store subscription id.
     * @Route("deletesubscription", name="deleteCaptainOfferSubscriptionByAdmin", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Subscription Captain Offer")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="delete captain offer subscription by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="storeSubscriptionId"),
     *          @OA\Property(type="integer", property="deleteEvenItIsBeingUsed", description="1 refers to YES, 0 refers to NO")
     *      )
     * )
     *
     * @OA\Response(
     *      response=401,
     *      description="Returns new captain offer subscription",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\StoreOwnerSubscription\AdminCaptainOfferSubscriptionCreateResponse")
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteCaptainOfferSubscriptionByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainOfferSubscriptionDeleteByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainOfferSubscriptionService->deleteCaptainOfferSubscriptionByAdmin($request);

        if ($result === SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_INACTIVE) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUBSCRIBE_CAPTAIN_OFFER_INACTIVE);
        }

        if ($result === SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_EXPIRED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_OFFER_SUBSCRIPTION_EXPIRED);
        }

        if ($result === SubscriptionCaptainOffer::CAPTAIN_OFFER_CARS_HAVE_BEING_USED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_OFFER_CARS_HAVE_BEING_USED);
        }

        if ($result === SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_OFFER_SUBSCRIPTION_NOT_EXIST);
        }

        if ($result === SubscriptionConstant::SUBSCRIPTION_NOT_FOUND) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUBSCRIPTION_NOT_FOUND);
        }

        if ($result === SubscriptionConstant::OLD_STORE_SUBSCRIPTION) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::OLD_STORE_SUBSCRIPTION);
        }

        if ($result === SubscriptionCaptainOffer::CAPTAIN_OFFER_SUBSCRIPTION_DELETE_PROBLEM) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_OFFER_SUBSCRIPTION_DELETE_PROBLEM);
        }

        return $this->response($result, self::DELETE);
    }
}
