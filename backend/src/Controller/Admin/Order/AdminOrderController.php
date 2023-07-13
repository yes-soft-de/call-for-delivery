<?php

namespace App\Controller\Admin\Order;

use App\AutoMapping;
use App\Constant\GeoDistance\GeoDistanceResultConstant;
use App\Constant\Main\MainErrorConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Controller\BaseController;
use App\Request\Admin\Order\CaptainNotArrivedOrderFilterByAdminRequest;
use App\Request\Admin\Order\FilterDifferentlyAnsweredCashOrdersByAdminRequest;
use App\Request\Admin\Order\NormalOrderCancelByAdminRequest;
use App\Request\Admin\Order\OrderCreateByAdminRequest;
use App\Request\Admin\Order\OrderDifferentDestinationFilterByAdminRequest;
use App\Request\Admin\Order\OrderFilterByAdminRequest;
use App\Request\Admin\Order\OrderHasPayConflictAnswersUpdateByAdminRequest;
use App\Request\Admin\Order\OrderRecycleOrCancelByAdminRequest;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceAdditionByAdminRequest;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceUpdateByAddAdditionalDistanceByAdminRequest;
use App\Request\Admin\Order\RePendingAcceptedOrderByAdminRequest;
use App\Request\Admin\Order\SubOrderCreateByAdminRequest;
use App\Service\Admin\Order\AdminOrderService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use OpenApi\Annotations as OA;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use App\Request\Admin\Order\UpdateOrderByAdminRequest;
use App\Request\Admin\Order\OrderAssignToCaptainByAdminRequest;
use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\Order\OrderStateConstant;
use App\Request\Admin\Order\OrderStateUpdateByAdminRequest;
use App\Constant\Captain\CaptainConstant;
use App\Request\Admin\Order\OrderCaptainFilterByAdminRequest;
use App\Request\Admin\Order\FilterOrdersPaidOrNotPaidByAdminRequest;
use App\Request\Admin\Subscription\AdminCalculateCostDeliveryOrderRequest;
use App\Request\Admin\Order\FilterOrdersWhoseHasNotDistanceHasCalculatedRequest;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceByAdminRequest;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceAndDestinationByAdminRequest;
use App\Request\Admin\Order\OrderUpdateIsCashPaymentConfirmedByStoreByAdminRequest;

/**
 * @Route("v1/admin/order/")
 */
class AdminOrderController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private AdminOrderService $adminOrderService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin: filter orders by admin
     * @Route("filterordersbyadmin", name="filterOrdersByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Post a request with filtering orders options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="state"),
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="integer", property="storeOwnerProfileId"),
     *          @OA\Property(type="integer", property="chosenDistanceIndicator", description="1 refers to use Kilometer,
     *              2 refers to use storeBranchToClientDistance"),
     *          @OA\Property(type="number", property="kilometer", description="if there is value, send it as float, not string"),
     *          @OA\Property(type="number", property="storeBranchToClientDistance"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh"),
     *          @OA\Property(type="integer", property="orderId"),
     *          @OA\Property(type="boolean", property="externalOrder"),
     *          @OA\Property(type="integer", property="externalCompanyId"),
     *          @OA\Property(type="integer", property="storeBranchId")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns orders that accomodate with the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\Order\OrderGetForAdminResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterStoreOrdersByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderFilterByAdminRequest::class, (object)$data);

        $result = $this->adminOrderService->filterStoreOrdersByAdmin($request, $this->getUserId());//dd($result);

        return new JsonResponse(["status_code" => '200',
            "msg" => 'fetched' . " " . "Successfully.",
            "Data" => $result
        ], 200, [
            ['Access-Control-Allow-Headers', 'X-Header-One,X-Header-Two'],
            ['Access-Control-Allow-Origin', '*'],
            ['Access-Control-Allow-Methods', 'PUT']
        ]);

        //return $this->response($result, self::FETCH);
    }

    /**
     * admin: get specific order by id
     * @Route("orderbyidforadmin/{id}/{timeZone}", name="getSpecificOrderByIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $id
     * @param string|null $timeZone
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
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
     *      description="Returns order information",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="objecy", property="Data",
     *              ref=@Model(type="App\Response\Admin\Order\OrderByIdGetForAdminResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getSpecificOrderByIdForAdmin(int $id, ?string $timeZone = null): JsonResponse
    {
        $result = $this->adminOrderService->getSpecificOrderByIdForAdmin($id, $timeZone);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: filter orders that have captain not arrived record in order log
     * @Route("filtercaptainnotarrivedorders", name="filterCaptainNotArrivedOrdersByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Post a request with filtering orders options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns orders that accomodate with the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\Order\CaptainNotArrivedOrderFilterResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterCaptainNotArrivedOrdersByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainNotArrivedOrderFilterByAdminRequest::class, (object)$data);

        $result = $this->adminOrderService->filterCaptainNotArrivedOrdersByAdmin($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: filter bid orders by admin
     * @Route("filterbidordersbyadmin", name="filterBidOrdersByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Post a request with filtering orders options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="state"),
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="integer", property="storeOwnerProfileId"),
     *          @OA\Property(type="boolean", property="openToPriceOffer")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns orders that accomodate with the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\Order\BidOrderGetForAdminResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterStoreBidOrdersByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderFilterByAdminRequest::class, (object)$data);

        $result = $this->adminOrderService->filterStoreBidOrdersByAdmin($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: get specific bid order by id
     * @Route("bidorderbyidforadmin/{id}", name="getSpecificBidOrderByIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $id
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
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
     *      description="Returns order information",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="objecy", property="Data",
     *              ref=@Model(type="App\Response\Admin\Order\BidOrderGetForAdminResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getSpecificBidOrderByIdForAdmin(int $id): JsonResponse
    {
        $result = $this->adminOrderService->getSpecificBidOrderByIdForAdmin($id);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Get pending, hidden, and not delivered orders for admin.
     * @Route("orderpending/{externalOrder}/{externalCompanyId}/{timeZone}", name="getPendingOrdersForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $externalOrder
     * @param int $externalCompanyId
     * @param string|null $timeZone
     * @return JsonResponse
     * *
     * @OA\Tag(name="Order")
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
     *      description="Return pending orders.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="array", property="pendingOrders",
     *                  @OA\Items(
     *                      ref=@Model(type="App\Response\Admin\Order\OrderPendingResponse")
     *                  )
     *              ),
     *              @OA\Property(type="array", property="hiddenOrders",
     *                  @OA\Items(
     *                      ref=@Model(type="App\Response\Admin\Order\OrderPendingResponse")
     *                  )
     *              ),
     *              @OA\Property(type="array", property="notDeliveredOrdersOrders",
     *                  @OA\Items(
     *                      ref=@Model(type="App\Response\Admin\Order\OrderPendingResponse")
     *                  )
     *              ),
     *              @OA\Property(type="integer", property="pendingOrdersCount"),
     *              @OA\Property(type="integer", property="hiddenOrdersCount"),
     *              @OA\Property(type="integer", property="notDeliveredOrdersCount"),
     *              @OA\Property(type="integer", property="totalOrderCount")
     *           )
     *        )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getPendingOrdersForAdmin(int $externalOrder = 0, int $externalCompanyId = 0, ?string $timeZone = null): JsonResponse
    {
        $response = $this->adminOrderService->getPendingOrdersForAdmin($this->getUserId(), $externalOrder, $externalCompanyId);
        
        return $this->response($response, self::FETCH);
    }

    /**
     * Return accepted order to pending status by admin
     * @Route("rependingacceptedorder", name="rependingAcceptedOrderByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="accepted order to pending status by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="orderId")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the order info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Order\OrderStateUpdateByAdminResponse")
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9207"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9214"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9218"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function rePendingAcceptedOrderByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, RePendingAcceptedOrderByAdminRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminOrderService->rePendingAcceptedOrderByAdmin($request, $this->getUserId());

        if ($result === OrderResultConstant::ORDER_ACCEPTED_BY_CAPTAIN) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_ALREADY_ACCEPTED_BY_CAPTAIN);
        }

        if ($result === OrderResultConstant::ORDER_RETURNING_TO_PENDING_HAS_PROBLEM) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_IN_RETURNING_ORDER_TO_PENDING_STATUS);
        }

        if ($result === OrderResultConstant::ORDER_IS_HIDDEN_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_HIDE);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("updateordertohidden/{id}", name="updateOrderToHidden", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $id
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the order info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="int", property="id"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateOrderToHidden(int $id): JsonResponse
    {
        $result = $this->adminOrderService->updateOrderToHidden($id, $this->getUserId());

        if ($result === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::NOTFOUND);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * Admin: order update by admin. 
     * @Route("orderupdatebyadmin", name="orderUpdateByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="order update request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="integer", property="branch"),
     *          @OA\Property(type="number", property="orderCost"),
     *          @OA\Property(type="string", property="payment"),
     *          @OA\Property(type="string", property="note"),
     *          @OA\Property(type="string", property="deliveryDate"),
     *          @OA\Property(type="object", property="destination"),
     *          @OA\Property(type="string", property="recipientName"),
     *          @OA\Property(type="string", property="images"),
     *          @OA\Property(type="string", property="recipientPhone"),
     *          @OA\Property(type="string", property="detail"),
     *          @OA\Property(type="boolean", property="orderIsMain"),
     *          @OA\Property(type="number", property="deliveryCost"),
     *          @OA\Property(type="integer", property="costType",
     *              description="186 refers delivery cost only. 187 referes delivery cost besides order cost")
     *      )
     * )
     * 
     * @OA\Response(
     *      response=204,
     *      description="Returns the order info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Order\OrderUpdateByAdminResponse")
     *      )
     *   )
     * )
     * 
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return erorr.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9216 or 9217"),
     *          @OA\Property(type="string", property="msg", description="errorMsg"),
     *      )
     * )
     * 
     * @Security(name="Bearer") 
     */
    public function orderUpdateByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, UpdateOrderByAdminRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminOrderService->orderUpdateByAdmin($request, $this->getUserId());

        // if ($result === OrderResultConstant::ERROR_UPDATE_BRANCH) {
        //     return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_UPDATE_BRANCH);
        // }

        // if ($result === OrderResultConstant::ERROR_UPDATE_CAPTAIN_ONGOING) {
        //     return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_UPDATE_CAPTAIN_ONGOING);
        // }

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: Create new order by admin
     * @Route("createorder", name="createOrderByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create a new order by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="storeOwner", description="The id of the store owner profile"),
     *          @OA\Property(type="string", property="payment"),
     *          @OA\Property(type="number", property="orderCost"),
     *          @OA\Property(type="string", property="note"),
     *          @OA\Property(type="string", property="deliveryDate"),
     *          @OA\Property(type="object", property="destination"),
     *          @OA\Property(type="string", property="recipientName"),
     *          @OA\Property(type="string", property="images"),
     *          @OA\Property(type="string", property="recipientPhone"),
     *          @OA\Property(type="string", property="detail"),
     *          @OA\Property(type="integer", property="branch"),
     *          @OA\Property(type="boolean", property="orderIsMain"),
     *          @OA\Property(type="number", property="deliveryCost"),
     *          @OA\Property(type="integer", property="costType",
     *              description="186 refers delivery cost only. 187 referes delivery cost besides order cost")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns new order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               ref=@Model(type="App\Response\Admin\Order\OrderCreateByAdminResponse")
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9151"),
     *                          @OA\Property(type="string", property="msg", description="error store inactive Error.")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9204"),
     *                          @OA\Property(type="string", property="msg", description="error Successfully."),
     *                          @OA\Property(type="object", property="Data",
     *                              ref=@Model(type="App\Response\Subscription\CanCreateOrderResponse")
     *                          )
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9157"),
     *                          @OA\Property(type="string", property="msg", description="store owner profile not exist! Error.")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9162"),
     *                          @OA\Property(type="string", property="msg", description="store branch is not exist Error.")
     *                   )
     *              }
     *      )
     *
     * )
     *
     * @Security(name="Bearer")
     */
    public function createOrderByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderCreateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminOrderService->createOrderByAdmin($request, $this->getUserId());

        if ($result === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::STORE_OWNER_PROFILE_NOT_EXIST);
        }

        if ($result === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_STORE_INACTIVE);
        }

        if (isset($result->canCreateOrder)) {
            return $this->response($result, self::ERROR_ORDER_CAN_NOT_CREATE);
        }

        if ($result === StoreOwnerBranch::BRANCH_NOT_FOUND) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::STORE_BRANCH_NOT_EXIST);
        }

        return $this->response($result, self::CREATE);
    }

     /**
     * admin: Assign a order to a captain.
     * @Route("assignordertocaptain", name="assignOrderToCaptain", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody (
     *        description="Assign a order to a captain",
     *        @OA\JsonContent(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="integer", property="orderId"),
     *         ),
     *      ),
     *
     * @OA\Response(
     *      response=204,
     *      description="Return order.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9207"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9306"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9101"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9218"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function assignOrderToCaptain(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderAssignToCaptainByAdminRequest::class, (object) $data);
            
        $violations = $this->validator->validate($request);
       
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
         }

        $response = $this->adminOrderService->assignOrderToCaptain($request, $this->getUserId());

        if($response === OrderStateConstant::ORDER_STATE_PENDING_INT) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_ALREADY_ACCEPTED_BY_CAPTAIN);
        }

        if ($response === SubscriptionConstant::CARS_FINISHED_INT) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAN_NOT_ACCEPTED_ORDER);
        }

        if ($response === CaptainConstant::CAPTAIN_NOT_FOUND) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_PROFILE_NOT_EXIST);
        }

        if ($response === OrderResultConstant::ORDER_IS_HIDDEN_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_HIDE);
        }

        // if ($response === OrderResultConstant::CAPTAIN_RECEIVED_ORDER_FOR_THIS_STORE_INT_FOR_ADMIN) {
        //     return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_RECEIVED_ORDER_FOR_THIS_STORE);
        // }

        return $this->response($response, self::UPDATE);
    }

//    /**
//     * to be replaced by normalordercancelbyadmin when the new api works correctly
//     * admin: cancel normal order by admin
//     * @Route("ordercancelbyadmin/{id}", name="orderCancelByAdmin", methods={"PUT"})
//     * @IsGranted("ROLE_ADMIN")
//     * @param int $id
//     * @return JsonResponse
//     *
//     * @OA\Tag(name="Order")
//     *
//     * @OA\Parameter(
//     *      name="token",
//     *      in="header",
//     *      description="token to be passed as a header",
//     *      required=true
//     * )
//     *
//     * @OA\Response(
//     *      response=204,
//     *      description="Return updated order info",
//     *      @OA\JsonContent(
//     *          @OA\Property(type="string", property="status_code"),
//     *          @OA\Property(type="string", property="msg"),
//     *          @OA\Property(type="object", property="Data",
//     *                  ref=@Model(type="App\Response\Admin\Order\OrderCancelByAdminResponse")
//     *          )
//     *      )
//     * )
//     *
//     * or
//     *
//     * @OA\Response(
//     *      response=200,
//     *      description="Return error according to situation.",
//     *      @OA\JsonContent(
//     *          oneOf={
//     *                   @OA\Schema(type="object",
//     *                          @OA\Property(type="string", property="status_code", description="9213"),
//     *                          @OA\Property(type="string", property="msg")
//     *                   ),
//     *                   @OA\Schema(type="object",
//     *                          @OA\Property(type="string", property="status_code", description="9215"),
//     *                          @OA\Property(type="string", property="msg")
//     *                   ),
//     *                   @OA\Schema(type="object",
//     *                          @OA\Property(type="string", property="status_code", description="9203"),
//     *                          @OA\Property(type="string", property="msg")
//     *                   ),
//     *                   @OA\Schema(type="object",
//     *                          @OA\Property(type="string", property="status_code", description="9205"),
//     *                          @OA\Property(type="string", property="msg")
//     *                   )
//     *              }
//     *      )
//     *
//     * )
//     *
//     * @Security(name="Bearer")
//     */
//    public function orderCancelByAdmin(int $id): JsonResponse
//    {
//        $response = $this->adminOrderService->cancelOrderByAdmin($id, $this->getUserId());
//
//        if ($response === OrderResultConstant::ORDER_TYPE_BID) {
//            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_WRONG_ORDER_TYPE);
//
//        } elseif ($response === OrderResultConstant::ORDER_UPDATE_PROBLEM) {
//            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_UPDATE);
//
//        } elseif ($response === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
//            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_NOT_FOUND);
//
//        } elseif ($response === OrderResultConstant::ORDER_ALREADY_BEING_CANCELLED) {
//            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_CANCEL);
//        }
//
//        // elseif ($response === OrderResultConstant::ORDER_ALREADY_IS_BEING_ACCEPTED) {
//        // return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_REMOVE_CAPTAIN_RECEIVE);
//        // }
//
//        return $this->response($response, self::UPDATE);
//    }

    /**
     * Admin: update order state by admin. 
     * @Route("orderstateupdatebyadmin", name="updateOrderStateByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update order state",
     *      @OA\JsonContent(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="state", description="on way to pick order or in store or ongoing or delivered"),
     *              @OA\Property(type="number", property="kilometer"),
     *              @OA\Property(type="number", property="captainOrderCost"),
     *              @OA\Property(type="string", property="noteCaptainOrderCost"),
     *              @OA\Property(type="integer", property="paidToProvider"),
     *      )
     * )
     * 
     * @OA\Response(
     *      response=204,
     *      description="Returns the order info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               ref=@Model(type="App\Response\Admin\Order\OrderStateUpdateByAdminResponse")
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error according to situation.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9219"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9218"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9224"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     *
     * )
     * 
     * @Security(name="Bearer") 
     */
    public function updateOrderStateByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, OrderStateUpdateByAdminRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminOrderService->updateOrderStateByAdmin($request, $this->getUserId());

        if ($result === OrderResultConstant::ORDER_IS_BEING_DELIVERED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_ALREADY_DELIVERED);

        } elseif ($result === OrderResultConstant::ORDER_IS_HIDDEN_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_HIDE);

        } elseif ($result === OrderResultConstant::ORDER_CANCEL_NOT_ALLOWED_DUE_TO_WRONG_API) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_CANCEL_NOT_ALLOWED_DUE_TO_WRONG_API);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: filter captain orders by admin
     * @Route("filtercaptainordersbyadmin", name="filterCaptainOrdersByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Post a request with filtering orders options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="integer", property="captainId", description="the id of captain profile"),
     *          @OA\Property(type="string", property="state"),
     *          @OA\Property(type="string", property="payment"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns orders that accommodate with the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="number", property="totalCashOrdersCost"),
     *              @OA\Property(type="number", property="countOrders"),
     *              @OA\Property(type="array", property="orders",
     *                  @OA\Items(
     *                      ref=@Model(type="App\Response\Admin\Order\OrderGetForAdminResponse")
     *                  )
     *              )
     *      )
     *      )
     *   )
     *
     * @Security(name="Bearer")
     */
    public function filterCaptainOrdersByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderCaptainFilterByAdminRequest::class, (object)$data);

        $result = $this->adminOrderService->filterCaptainOrdersByAdmin($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: filter orders in which the store's answer differs from that of the captain (paid or not paid)
     * @Route("filterorders", name="filterOrdersPaidOrNotPaidByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Post a request with filtering orders options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns orders that accomodate with the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\Order\FilterOrdersPaidOrNotPaidByAdminResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterOrdersPaidOrNotPaidByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, FilterOrdersPaidOrNotPaidByAdminRequest::class, (object)$data);

        $result = $this->adminOrderService->filterOrdersPaidOrNotPaidByAdmin($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Calculate the cost delivery the order for admin.
     * @Route("calculatecostdeliveryorderforadmin", name="calculateCostDeliveryOrderForAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Store Branch To Client Distance",
     *      @OA\JsonContent(
     *          @OA\Property(type="number", property="storeBranchToClientDistance"),
     *          @OA\Property(type="number", property="storeOwnerProfileId"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Store Branch To Client Distance",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="number", property="orderDeliveryCost"),
     *            @OA\Property(type="number", property="extraDistance"),
     *            @OA\Property(type="number", property="extraOrderDeliveryCost"),
     *            @OA\Property(type="number", property="total"),
     *      )
     *   )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function calculateCostDeliveryOrder(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCalculateCostDeliveryOrderRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminOrderService->calculateCostDeliveryOrder($request);
    
        return $this->response($result, self::FETCH);
    }

    /**
     * admin: filter orders which distance hadn't been calculated
     * @Route("filterorderswhosehasnotdistancehascalculated", name="filterOrdersWhoseHasNotDistanceHasCalculated", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Post a request with filtering orders options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns orders with the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="array", property="orderWithOutDistance",
     *                  @OA\Items()
     *              ),
     *              @OA\Property(type="array", property="orders",
     *                  @OA\Items()
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterOrdersWhoseHasNotDistanceHasCalculated(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, FilterOrdersWhoseHasNotDistanceHasCalculatedRequest::class, (object)$data);

        $result = $this->adminOrderService->filterOrdersWhoseHasNotDistanceHasCalculated($request);

        return $this->response($result, self::FETCH);
    }
    
    /**
     * Admin: update storeBranchToClientDistance by admin. 
     * @Route("updatestorebranchtoclientdistancebyadmin", name="updateStoreBranchToClientDistanceByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update storeBranchToClientDistance by admin",
     *      @OA\JsonContent(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="storeBranchToClientDistance"),
     *      )
     * )
     * 
     * @OA\Response(
     *      response=204,
     *      description="Returns the order info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               ref=@Model(type="App\Response\Admin\Order\OrderStateUpdateByAdminResponse")
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer") 
     */
    public function updateStoreBranchToClientDistanceByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, OrderStoreBranchToClientDistanceByAdminRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminOrderService->updateStoreBranchToClientDistanceByAdmin($request, $this->getUserId());

        return $this->response($result, self::UPDATE);
    }

    /**
     * Admin: Create new sub order by admin
     * @Route("createsuborderbyadmin", name="createSubOrderByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="new sub order create request by admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="payment"),
     *          @OA\Property(type="number", property="orderCost"),
     *          @OA\Property(type="string", property="note"),
     *          @OA\Property(type="string", property="deliveryDate"),
     *          @OA\Property(type="object", property="destination"),
     *          @OA\Property(type="string", property="recipientName"),
     *          @OA\Property(type="string", property="images"),
     *          @OA\Property(type="string", property="recipientPhone"),
     *          @OA\Property(type="string", property="detail"),
     *          @OA\Property(type="integer", property="branch"),
     *          @OA\Property(type="integer", property="primaryOrder"),
     *          @OA\Property(type="string", property="filePdf"),
     *          @OA\Property(type="number", property="storeBranchToClientDistance"),
     *          @OA\Property(type="number", property="deliveryCost"),
     *          @OA\Property(type="integer", property="costType",
     *              description="186 refers delivery cost only. 187 referes delivery cost besides order cost")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns new order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               ref=@Model(type="App\Response\Admin\Order\OrderCreateByAdminResponse")
     *      )
     *   )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error according to situation.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9157"),
     *                          @OA\Property(type="string", property="msg", description="store owner profile not exist!")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9162"),
     *                          @OA\Property(type="string", property="msg", description="store branch is not exist!")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9209"),
     *                          @OA\Property(type="string", property="msg", description="can not create sub order,the orders finished !")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9208"),
     *                          @OA\Property(type="string", property="msg", description="can not create sub order,the primary order is delivered!")
     *                   )
     *              }
     *      )
     *
     * )
     *
     * @Security(name="Bearer")
     */
    public function createSubOrderByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SubOrderCreateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminOrderService->createSubOrderByAdmin($request, $this->getUserId());

        if ($result === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::STORE_OWNER_PROFILE_NOT_EXIST);
        }

        if ($result === StoreOwnerBranch::BRANCH_NOT_FOUND) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::STORE_BRANCH_NOT_EXIST);
        }

        if ($result === SubscriptionConstant::CAN_NOT_CREATE_SUB_ORDER) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_SUB_ORDER_CAN_NOT_CREATE_ORDER_FINISHED);
        }

        if ($result === OrderStateConstant::ORDER_STATE_DELIVERED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_SUB_ORDER_CAN_NOT_CREATE);
        }

        return $this->response($result, self::CREATE);
    }

     /**
     * admin: filter Orders not answered by the store (paid or not paid)
     * @Route("filterordersnotansweredbystore", name="filterOrdersNotAnsweredByTheStore", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Post a request with filtering orders options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
      *         @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns orders that accomodate with the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\Order\FilterOrdersPaidOrNotPaidByAdminResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterOrdersNotAnsweredByTheStore(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, FilterOrdersPaidOrNotPaidByAdminRequest::class, (object)$data);

        $result = $this->adminOrderService->filterOrdersNotAnsweredByTheStore($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: filter cash orders which have different answers for cash payment
     * @Route("filterdifferentansweredcashorders", name="filterCashOrdersWhichHaveDifferentAnswersByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Post a request with filtering orders options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="integer", property="storeProfileId"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns orders that accomodate with the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\Order\FilterDifferentlyAnsweredCashOrdersByAdminResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterDifferentAnsweredCashOrdersByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, FilterDifferentlyAnsweredCashOrdersByAdminRequest::class, (object)$data);

        $result = $this->adminOrderService->filterDifferentAnsweredCashOrdersByAdmin($request);

        return $this->response($result, self::FETCH);
    }
    
    /**
     * Admin: update storeBranchToClientDistance and destination by admin. 
     * @Route("updatestorebranchtoclientdistanceanddestinationbyadmin", name="updateStoreBranchToClientDistanceAndDestinationByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update storeBranchToClientDistance and destination by admin",
     *      @OA\JsonContent(
     *              @OA\Property(type="integer", property="orderId"),
     *              @OA\Property(type="number", property="storeBranchToClientDistance"),
     *              @OA\Property(type="array", property="destination",
     *                  @OA\Items(),
     *              )
     *          )
     *      )
     * @OA\Response(
     *      response=204,
     *      description="Returns the order info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Order\OrderStoreToBranchDistanceAndDestinationUpdateByAdminResponse")
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer") 
     */
    public function updateStoreBranchToClientDistanceAndDestinationByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, OrderStoreBranchToClientDistanceAndDestinationByAdminRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminOrderService->updateStoreBranchToClientDistanceAndDestinationByAdmin($request, $this->getUserId());

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: resolves the order/s which has/have conflicted answers
     *
     * @Route("resolveconflictedanswersbyadmin", name="resolveConflictedAnswersForSpecificOrdersByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update hasPayConflictAnswers of spceific orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="integer", property="orderId"),
     *          @OA\Property(type="integer", property="correctAnswer", required={"true"},
     *                          example="3: captains answer is correct. 4: store's answer is correct")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns updated orders that accomodate with the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\Order\OrderHasPayConflictAnswersUpdateByAdminResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function resolveOrderHasPayConflictAnswersByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderHasPayConflictAnswersUpdateByAdminRequest::class, (object)$data);

        $result = $this->adminOrderService->resolveOrderHasPayConflictAnswersByAdmin($request, $this->getUserId());

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: admin confirmation, on behalf of store, whether payment has been made by the captain or not.
     * @Route("confirmcashpaymentbystorebyadmin", name="updateIsCashPaymentConfirmedByStoreByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody (
     *        description="Update isCashPaymentConfirmedByStore of an order by admin request",
     *        @OA\JsonContent(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="integer", property="isCashPaymentConfirmedByStore")
     *         )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Return isCashPaymentConfirmedByStore new value.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Order\OrderUpdateIsCashPaymentConfirmedByStoreForAdminResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateIsCashPaymentConfirmedByStoreByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateIsCashPaymentConfirmedByStoreByAdminRequest::class, (object) $data);
            
        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminOrderService->updateIsCashPaymentConfirmedByStoreByAdmin($request, $this->getUserId());

        return $this->response($response, self::UPDATE);
    }

    /**
     * Admin: update storeBranchToClientDistance via adding distance to it by new location.
     * @Route("addstorebranchtoclientdistanceviadestinationbyadmin", name="updateStoreBranchToClientDistanceAndDestinationViaLocationByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update storeBranchToClientDistance and destination by admin",
     *      @OA\JsonContent(
     *              @OA\Property(type="integer", property="orderId"),
     *              @OA\Property(type="array", property="destination",
     *                  @OA\Items(
     *                      @OA\Property(type="number", property="lat"),
     *                      @OA\Property(type="number", property="lon")
     *                  )
     *              ),
     *              @OA\Property(type="string", property="storeBranchToClientDistanceAdditionExplanation")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the order info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Order\OrderDestinationUpdateByAdminResponse")
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9213"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9205"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9372"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function addDistanceToStoreBranchToClientDistanceViaLocationByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, OrderStoreBranchToClientDistanceAdditionByAdminRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminOrderService->addDistanceToStoreBranchToClientDistanceViaLocationByAdmin($request, $this->getUserId());

        if ($result === OrderResultConstant::ORDER_TYPE_BID) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_WRONG_ORDER_TYPE);

        } elseif ($result === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_NOT_FOUND);

        } elseif ($result === GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_CAN_NOT_CALCULATE_DISTANCE);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * Admin: update storeBranchToClientDistance via adding additional distance to it directly.
     * @Route("additionaldistancetostorebranchtoclientdistancebyadmin", name="updateStoreBranchToClientDistanceViaAdditionalDistanceByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update storeBranchToClientDistance and destination by admin",
     *      @OA\JsonContent(
     *              @OA\Property(type="integer", property="orderId"),
     *              @OA\Property(type="number", property="additionalDistance"),
     *              @OA\Property(type="string", property="storeBranchToClientDistanceAdditionExplanation")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the order info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Order\OrderStoreBranchToClientDistanceUpdateByAdminResponse")
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function addAdditionalDistanceToStoreBranchToClientDistanceByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, OrderStoreBranchToClientDistanceUpdateByAddAdditionalDistanceByAdminRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminOrderService->addAdditionalDistanceToStoreBranchToClientDistanceByAdmin($request, $this->getUserId());

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: Recycling or cancel the order by admin
     * @Route("recyclingorcancelorderbyadmin", name="recyclingOrCancelOrderByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="recycling Or Cancel Order",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="payment"),
     *          @OA\Property(type="number", property="orderCost"),
     *          @OA\Property(type="string", property="note"),
     *          @OA\Property(type="string", property="deliveryDate"),
     *          @OA\Property(type="object", property="destination"),
     *          @OA\Property(type="string", property="recipientName"),
     *          @OA\Property(type="string", property="images"),
     *          @OA\Property(type="string", property="recipientPhone"),
     *          @OA\Property(type="string", property="detail"),
     *          @OA\Property(type="integer", property="branch"),
     *          @OA\Property(type="integer", property="cancel", description="1 for cancel"),
     *          @OA\Property(type="number", property="deliveryCost"),
     *          @OA\Property(type="integer", property="costType",
     *              description="186 refers delivery cost only. 187 referes delivery cost besides order cost")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               ref=@Model(type="App\Response\Admin\Order\OrderRecycleByAdminResponse")
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="200",
     *      description="Return error.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9204"),
     *              @OA\Property(type="string", property="msg"),
     *              @OA\Property(type="object", property="Data",
     *                  ref=@Model(type="App\Response\Subscription\CanCreateOrderResponse"),
     *        )
     *     )
     *  )
     *
     * @Security(name="Bearer")
     */
    public function recycleOrCancelOrderByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderRecycleOrCancelByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminOrderService->recycleOrCancelOrderByAdmin($request, $this->getUserId());

        if (isset($result->canCreateOrder)) {
            return $this->response($result, self::ERROR_ORDER_CAN_NOT_CREATE);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: get delivered orders during current active financial cycle by captain profile id
     * @Route("fetchorderscurrentfinancialcycleforadmin/{captainProfileId}", name="fetchOrdersOfCurrentFinancialCycleByCaptainProfileIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $captainProfileId
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
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
     *      description="Returns orders that accomodate with the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\Order\OrderCurrentFinancialCycleByCaptainProfileIdForAdminGetResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getOrdersByCaptainProfileIdAndCaptainFinancialCycle(int $captainProfileId): JsonResponse
    {
        $result = $this->adminOrderService->getOrdersByCaptainProfileIdAndCaptainFinancialCycle($captainProfileId);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: filter orders which have different destinations that had been updated by captains
     * @Route("filterdifferentdestinationsorders", name="filterDifferentDestinationOrdersByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Post a request with filtering orders options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns orders that have different destination which updated by captain",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\Order\OrderDifferentDestinationFilterByAdminResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterDifferentDestinationOrdersByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderDifferentDestinationFilterByAdminRequest::class, (object)$data);

        $result = $this->adminOrderService->filterDifferentDestinationOrdersByAdmin($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: cancel normal order by admin (2nd version)
     * @Route("normalordercancelbyadmin", name="normalOrderCancelByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Post a request with cancelling order options",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="boolean", property="cutOrderFromStoreSubscription"),
     *          @OA\Property(type="boolean", property="addHalfOrderValueToCaptainFinancialDue")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Return updated order info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  ref=@Model(type="App\Response\Admin\Order\OrderCancelByAdminResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error according to situation.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9213"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9215"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9203"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9205"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     *
     * )
     *
     * @Security(name="Bearer")
     */
    public function normalOrderCancelByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, NormalOrderCancelByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminOrderService->cancelNormalOrderByAdmin($request, $this->getUserId());

        if ($response === OrderResultConstant::ORDER_TYPE_BID) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_WRONG_ORDER_TYPE);

        } elseif ($response === OrderResultConstant::ORDER_UPDATE_PROBLEM) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_UPDATE);

        } elseif ($response === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_NOT_FOUND);

        } elseif ($response === OrderResultConstant::ORDER_ALREADY_BEING_CANCELLED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_CANCEL);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * admin: filter externally delivered orders by admin
     * @Route("filterexternallydeliveredordersbyadmin", name="filterExternallyDeliveredOrdersByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Post a request with filtering orders options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="state"),
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="integer", property="storeOwnerProfileId"),
     *          @OA\Property(type="integer", property="chosenDistanceIndicator", description="1 refers to use Kilometer,
     *              2 refers to use storeBranchToClientDistance"),
     *          @OA\Property(type="number", property="kilometer", description="if there is value, send it as float, not string"),
     *          @OA\Property(type="number", property="storeBranchToClientDistance"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh"),
     *          @OA\Property(type="integer", property="orderId"),
     *          @OA\Property(type="integer", property="externalCompanyId"),
     *          @OA\Property(type="integer", property="storeBranchId")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns orders that accomodate with the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\Order\OrderPendingResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterExternalOrdersByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderFilterByAdminRequest::class, (object)$data);

        $result = $this->adminOrderService->filterExternallyDeliveredOrdersByAdmin($request, $this->getUserId());

        return $this->response($result, self::FETCH);
    }
}
