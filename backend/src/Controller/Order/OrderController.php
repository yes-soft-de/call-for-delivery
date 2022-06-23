<?php

namespace App\Controller\Order;

use App\AutoMapping;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Controller\BaseController;
use App\Request\Order\BidOrderFilterBySupplierRequest;
use App\Request\Order\BidDetailsCreateRequest;
use App\Request\Order\OrderFilterByCaptainRequest;
use App\Request\Order\OrderFilterRequest;
use App\Request\Order\OrderCreateRequest;
use App\Request\Order\OrderUpdateByCaptainRequest;
use App\Service\Order\OrderService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use App\Constant\Main\MainErrorConstant;
use App\Constant\Subscription\SubscriptionConstant;
use App\Request\Order\OrderUpdateCaptainOrderCostRequest;
use App\Request\Order\OrderUpdateCaptainArrivedRequest;
use App\Constant\Order\OrderResultConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Request\Order\SubOrderCreateRequest;
use App\Constant\Order\OrderStateConstant;
use App\Request\Order\RecyclingOrCancelOrderRequest;
use App\Constant\Captain\CaptainConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Request\Order\UpdateOrderRequest;
use App\Constant\Order\OrderIsHideConstant;


/**
 * Create and fetch order.
 * @Route("v1/order/")
 */
class OrderController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private OrderService $orderService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, OrderService $orderService)
    {
        parent::__construct($serializer);
       $this->autoMapping = $autoMapping;
       $this->validator = $validator;
       $this->orderService = $orderService;

    }
    
    /**
     * store:Create new order by store
     * @Route("create", name="createOrder", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="new order",
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
     *          @OA\Property(type="boolean", property="orderIsMain"),
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
     *               @OA\Property(type="integer", property="id"),
     *               @OA\Property(type="string", property="payment"),
     *               @OA\Property(type="number", property="orderCost"),
     *               @OA\Property(type="string", property="note"),
     *               @OA\Property(type="object", property="deliveryDate"),
     *               @OA\Property(type="string", property="state"),
     *               @OA\Property(type="integer", property="orderType"),
     *      )
     *   )
     * )
     * 
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return error.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9151 or 9204"),
     *          @OA\Property(type="string", property="msg", description="error store inactive Error."),
     *        )
     *     )
     *
     * @Security(name="Bearer")
     */
    public function createOrder(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderCreateRequest::class, (object)$data);

        $request->setStoreOwner($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->orderService->createOrder($request);
      
        if ($result === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
      
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_STORE_INACTIVE);
        }

        if (isset($result->canCreateOrder)) {
      
            return $this->response($result, self::ERROR_ORDER_CAN_NOT_CREATE);
        }
        
        return $this->response($result, self::CREATE);
    }
    
    /**
     * store:Get store orders
     * @Route("storeorders", name="getStoreOrders", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
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
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="string", property="note"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="state"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="integer", property="storeOrderDetailsId"),
     *                  @OA\Property(type="object", property="destination"),
     *                  @OA\Property(type="string", property="recipientPhone"),
     *                  @OA\Property(type="string", property="detail"),
     *                  @OA\Property(type="integer", property="storeOwnerBranchId"),
     *                  @OA\Property(type="string", property="branchName"),
     *                  @OA\Property(type="boolean", property="orderIsMain"),
     *          )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOrders(): JsonResponse
    {
        $result = $this->orderService->getStoreOrders($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * store:Get specific order for store
     * @Route("storeorder/{id}", name="getSpecificOrderForStore", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @param $id
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
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="string", property="note"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="state"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="integer", property="storeOrderDetailsId"),
     *                  @OA\Property(type="object", property="destination"),
     *                  @OA\Property(type="string", property="recipientPhone"),
     *                  @OA\Property(type="string", property="detail"),
     *                  @OA\Property(type="integer", property="storeOwnerBranchId"),
     *                  @OA\Property(type="string", property="branchName"),
     *                  @OA\Property(type="string", property="roomId"),
     *                  @OA\Property(type="boolean", property="isCaptainArrived"),
     *                  @OA\Property(type="object", property="dateCaptainArrived"),
     *                  @OA\Property(type="string", property="branchPhone"),
     *                  @OA\Property(type="boolean", property="orderIsMain"),
     *                  @OA\Property(type="object", property="images",
     *                          @OA\Property(type="string", property="imageURL"),
     *                          @OA\Property(type="string", property="image"),
     *                          @OA\Property(type="string", property="baseURL"),
     *                      ),
     *              ),
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getSpecificOrderForStore($id): JsonResponse
    {
        $result = $this->orderService->getSpecificOrderForStore($id);

        return $this->response($result, self::FETCH);
    }

    /**
     * store: filter orders
     * @Route("filterorders", name="filterOrdersByStoreOwner", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
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
     *          @OA\Property(type="string", property="toDate")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="string", property="note"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="object", property="createdAt"),
     *                  @OA\Property(type="string", property="state"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="integer", property="storeOrderDetailsId"),
     *                  @OA\Property(type="object", property="destination"),
     *                  @OA\Property(type="string", property="recipientName"),
     *                  @OA\Property(type="string", property="recipientPhone"),
     *                  @OA\Property(type="string", property="detail"),
     *                  @OA\Property(type="integer", property="storeOwnerBranchId"),
     *                  @OA\Property(type="string", property="branchName"),
     *                  @OA\Property(type="string", property="images"),
     *                  @OA\Property(type="boolean", property="orderIsMain"),
     *          )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterStoreOrders(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderFilterRequest::class, (object)$data);

        $result = $this->orderService->filterStoreOrders($request, $this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * store: filter bid orders by store owner
     * @Route("filterbidorders", name="filterBidOrdersByStoreOwner", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
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
     *          @OA\Property(type="boolean", property="openToPriceOffer")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Order\FilterBidOrderByStoreOwnerResponse")
     *          )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterStoreBidOrders(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderFilterRequest::class, (object)$data);

        $result = $this->orderService->filterStoreBidOrders($request, $this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * captain: Get pending orders for captain.
     * @Route("closestorders",   name="GetPendingOrdersForCaptain", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN") 
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
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="object", property="createdAt"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="string", property="note"),
     *                  @OA\Property(type="string", property="state"),
     *                  @OA\Property(type="boolean", property="orderIsMain"),
     *                  ),
     *            )
     *       )
     *  )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return captain inactive.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9100 or 9105 or 9107"),
     *          @OA\Property(type="string", property="msg", description="error captain inactive Error. or error system financial inactive Error. or captain not online"),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function closestOrders(): JsonResponse
    {
        $response = $this->orderService->closestOrders($this->getUserId());
        if (isset($response->status)) {
           
           return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_CAPTAIN_INACTIVE);
        }

        if ($response === CaptainConstant::ERROR_CAPTAIN_ONLINE_FALSE) {
            
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_CAPTAIN_ONLINE_FALSE);
        }

        if ($response === CaptainFinancialSystem::FINANCIAL_SYSTEM_INACTIVE) {
            
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_SYSTEM_FINANCIAL_INACTIVE);
        }
        
        return $this->response($response, self::FETCH);
    }

    // Currently we do not need this API
//    /**
//     * captain: Get pending bid orders for captain.
//     * @Route("closestbidorders", name="GetPendingBidOrdersForCaptain", methods={"GET"})
//     * @IsGranted("ROLE_CAPTAIN")
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
//     *      response=200,
//     *      description="Return pending orders.",
//     *      @OA\JsonContent(
//     *          @OA\Property(type="string", property="status_code"),
//     *          @OA\Property(type="string", property="msg"),
//     *          @OA\Property(type="array", property="Data",
//     *              @OA\Items(
//     *                  ref=@Model(type="App\Response\Order\BidOrderClosestGetResponse")
//     *                  ),
//     *            )
//     *       )
//     *  )
//     *
//     * or
//     *
//     * @OA\Response(
//     *      response="default",
//     *      description="Return captain inactive.",
//     *      @OA\JsonContent(
//     *          @OA\Property(type="string", property="status_code", description="9100"),
//     *          @OA\Property(type="string", property="msg", description="error captain inactive Error."),
//     *      )
//     * )
//     *
//     * @Security(name="Bearer")
//     */
//    public function closestBidOrders(): JsonResponse
//    {
//        $response = $this->orderService->closestBidOrders($this->getUserId());
//
//        if (isset($response->status)) {
//            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_CAPTAIN_INACTIVE);
//        }
//
//        return $this->response($response, self::FETCH);
//    }
    
    /**
     * captain: Get the orders received by the captain.
     * @Route("acceptedorder", name="getAcceptedOrderByCaptainId", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
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
     *      description="Return captain orders.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="object", property="createdAt"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="string", property="note"),
     *                  @OA\Property(type="string", property="state"),
     *                  @OA\Property(type="number", property="rating"),
     *                  @OA\Property(type="boolean", property="orderIsMain"),
     *                  ),
     *            )
     *       )
     *  )
     * 
     * @Security(name="Bearer")
     */
    public function acceptedOrderByCaptainId(): JsonResponse
    {
        $result = $this->orderService->acceptedOrderByCaptainId($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /** captain: Get order details.
     * @Route("captainorder/{id}", name="getSpecificOrderForCaptain", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param int $id
     * @return JsonResponse
     *
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
     *      description="Returns order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="string", property="note"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="state"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="integer", property="storeOrderDetailsId"),
     *                  @OA\Property(type="object", property="destination"),
     *                  @OA\Property(type="string", property="recipientPhone"),
     *                  @OA\Property(type="string", property="detail"),
     *                  @OA\Property(type="integer", property="storeOwnerBranchId"),
     *                  @OA\Property(type="string", property="branchName"),
     *                  @OA\Property(type="string", property="roomId"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="storeOwnerName"),
     *                  @OA\Property(type="object", property="images",
     *                          @OA\Property(type="string", property="imageURL"),
     *                          @OA\Property(type="string", property="image"),
     *                          @OA\Property(type="string", property="baseURL"),
     *                      ),
     *                  @OA\Property(type="number", property="rating"),
     *                  @OA\Property(type="string", property="branchPhone"),
     *                  @OA\Property(type="boolean", property="orderIsMain"),
     * 
     *              ),
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getSpecificOrderForCaptain(int $id): JsonResponse
    {
        $result = $this->orderService->getSpecificOrderForCaptain($id, $this->getUserId());
       
        if ($result === OrderResultConstant::ORDER_ALREADY_IS_BEING_ACCEPTED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_ALREADY_ACCEPTED_BY_CAPTAIN);
        }
       
        return $this->response($result, self::FETCH);
    }

    /** captain: Get bid order by id for captain.
     * @Route("captainbidorder/{id}", name="getSpecificBidOrderForCaptainById", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
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
     *      description="Returns bid order info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Order\BidOrderClosestGetResponse")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getSpecificBidOrderForCaptain(int $id): JsonResponse
    {
        $result = $this->orderService->getSpecificBidOrderForCaptain($id, $this->getUserId());

        return $this->response($result, self::FETCH);
    }
    
    /**
     * captain: To accept the order AND change order state and update kilometer.
     * @Route("orderupdatestate", name="orderUpdateState", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
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
     *        description="To accept the order AND change state",
     *        @OA\JsonContent(
     *              @OA\Property(type="integer", property="orderNumber"),
     *              @OA\Property(type="string", property="state", description="on way to pick order or in store or picked or ongoing or delivered"),
     *              @OA\Property(type="number", property="kilometer"),
     *              @OA\Property(type="number", property="captainOrderCost"),
     *              @OA\Property(type="string", property="noteCaptainOrderCost"),
     *              @OA\Property(type="integer", property="paidToProvider"),
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
     *              @OA\Property(type="string", property="state"),
     *              @OA\Property(type="integer", property="kilometer"),
     *              @OA\Property(type="number", property="captainOrderCost"),
     *              @OA\Property(type="string", property="noteCaptainOrderCost"),
     *              @OA\Property(type="integer", property="paidToProvider"),
     *              )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return erorr.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9306"),
     *          @OA\Property(type="string", property="msg", description="The cars remaining is finished Error."),
     *      )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function orderUpdateStateByCaptain(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateByCaptainRequest::class, (object) $data);
       
        $request->setCaptainId($this->getUserId());
     
        $violations = $this->validator->validate($request);
       
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
         }

        $response = $this->orderService->orderUpdateStateByCaptain($request);

        if($response === SubscriptionConstant::CARS_FINISHED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAN_NOT_ACCEPTED_ORDER);
        }

        if ($response === OrderResultConstant::ORDER_ALREADY_IS_BEING_ACCEPTED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_ALREADY_ACCEPTED_BY_CAPTAIN);
        }

        if ($response === OrderStateConstant::ORDER_STATE_CANCEL) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_CANCEL);
        }

        if ($response === OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_HIDE);
        }
      
        return $this->response($response, self::UPDATE);
    }

    /**
     * captain: filter orders accepted by captain.
     * @Route("filterordersbycaptain", name="filterOrdersByCaptain", methods={"POST"})
     * @IsGranted("ROLE_CAPTAIN")
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
     *        description="To accept the order AND change state",
     *        @OA\JsonContent(
     *              @OA\Property(type="string", property="state"),
     *              @OA\Property(type="string", property="fromDate"),
     *              @OA\Property(type="string", property="toDate")
     *         )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Return orders that meet the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="object", property="createdAt"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="string", property="note"),
     *                  @OA\Property(type="object", property="location"),
     *                  @OA\Property(type="string", property="branchName"),
     *                  @OA\Property(type="string", property="storeOwnerName"),
     *                  @OA\Property(type="string", property="state")
     *               )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterOrdersByCaptain(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderFilterByCaptainRequest::class, (object) $data);

        $request->setCaptainId($this->getUserId());

        $response = $this->orderService->filterOrdersByCaptain($request);

        return $this->response( $response, self::UPDATE);
    }
    
    /**
     * captain: Order Update Captain Order Cost.
     * @Route("orderupdatecaptainordercost", name="orderUpdateCaptainOrderCost", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
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
     *        description="Order Update Captain Order Cost",
     *        @OA\JsonContent(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="number", property="captainOrderCost"),
     *              @OA\Property(type="string", property="noteCaptainOrderCost"),
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
     *              @OA\Property(type="number", property="captainOrderCost"),
     *              @OA\Property(type="string", property="noteCaptainOrderCost"),
     *              @OA\Property(type="string", property="attention"),
     *              )
     *       )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function orderUpdateCaptainOrderCost(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateCaptainOrderCostRequest::class, (object) $data);
       
        $request->setCaptainId($this->getUserId());
     
        $violations = $this->validator->validate($request);
       
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
         }

        $response = $this->orderService->orderUpdateCaptainOrderCost($request);
      
        return $this->response($response, self::UPDATE);
    }
    
    /**
     * store: update Captain Arrived.
     * @Route("orderupdatecaptainarrived", name="updateCaptainArrived", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
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
     *        description="Order Update Captain isCaptainArrived",
     *        @OA\JsonContent(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="number", property="isCaptainArrived"),
     *         ),
     *      ),
     *
     * @OA\Response(
     *      response=204,
     *      description="Return Captain Arrived.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="boolean", property="isCaptainArrived"),
     *              )
     *       )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function updateCaptainArrived(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderUpdateCaptainArrivedRequest::class, (object) $data);
            
        $violations = $this->validator->validate($request);
       
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
         }

        $response = $this->orderService->updateCaptainArrived($request);
      
        return $this->response($response, self::UPDATE);
    }

    /**
     * store: order cancel.
     * @Route("ordercancel/{id}", name="orderCancel", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="Return order.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="state"),
     *              )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return erorr.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9202"),
     *          @OA\Property(type="string", property="msg", description="can not remove it, The captain received the order"),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function orderCancel(int $id): JsonResponse
    {
        $response = $this->orderService->orderCancel($id);

        if(isset($response->statusError)) {
            if($response->statusError === OrderResultConstant::ORDER_NOT_REMOVE_TIME) {
                return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_REMOVE_TIME);
            }
           
            if($response->statusError === OrderResultConstant::ORDER_NOT_REMOVE_CAPTAIN_RECEIVED) {
                return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_REMOVE_CAPTAIN_RECEIVE);
            }

        } elseif ($response === OrderResultConstant::ORDER_TYPE_BID) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_WRONG_ORDER_TYPE);
        }
      
        return $this->response($response, self::UPDATE);
    }

    /**
     * store: Create new bid order
     * @Route("bidorder", name="createBidOrderByStoreOwner", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="create a new bid order request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="payment"),
     *          @OA\Property(type="string", property="note"),
     *          @OA\Property(type="string", property="title"),
     *          @OA\Property(type="number", property="description"),
     *          @OA\Property(type="string", property="supplierCategory"),
     *          @OA\Property(type="array", property="imagesArray",
     *              @OA\Items(type="object",
     *                  @OA\Property(type="string", property="image")
     *              )
     *          ),
     *          @OA\Property(type="integer", property="branch")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new bid order info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               @OA\Property(type="integer", property="id"),
     *               @OA\Property(type="string", property="payment"),
     *               @OA\Property(type="number", property="orderCost"),
     *               @OA\Property(type="string", property="note"),
     *               @OA\Property(type="object", property="deliveryDate"),
     *               @OA\Property(type="string", property="state"),
     *               @OA\Property(type="integer", property="orderType")
     *      )
     *   )
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
    public function createBidOrder(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, BidDetailsCreateRequest::class, (object)$data);

        $request->setStoreOwner($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->orderService->createBidOrder($request);

        if ($result === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_STORE_INACTIVE);
        }

        return $this->response($result, self::CREATE);
    }

    /**
     * supplier: filter bid orders which the supplier had not provide a price offer for any one of them yet.
     * @Route("filterbidordersbysupplier", name="filterBidOrdersBySupplier", methods={"POST"})
     * @IsGranted("ROLE_SUPPLIER")
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
     *      description="filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the bid orders info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Order\BidOrderFilterBySupplierResponse")
     *              )
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns supplier profile not active message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9554"),
     *          @OA\Property(type="string", property="msg")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterBidOrdersBySupplier(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, BidOrderFilterBySupplierRequest::class, (object)$data);

        $request->setSupplierId($this->getUserId());

        $result = $this->orderService->filterBidOrdersBySupplier($request);

        if ($result === SupplierProfileConstant::INACTIVE_SUPPLIER_PROFILE_RESULT) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUPPLIER_PROFILE_NOT_ACTIVE);
        }

        return $this->response($result, self::FETCH);
    }

    /**
     * supplier: get bid order details by id for supplier
     * @Route("orderbyidforsupplier/{id}", name="getOrderByIdForSupplier", methods={"GET"})
     * @IsGranted("ROLE_SUPPLIER")
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
     *      response=201,
     *      description="Returns the bid order details info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Order\OrderByIdForSupplierGetResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getOrderByIdForSupplier(int $id): JsonResponse
    {
        $result = $this->orderService->getOrderByIdForSupplier($id, $this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * supplier: filter bid orders which the supplier had provided a price offer for each one of them.
     * @Route("filterbidorderswithpriceoffersbysupplier", name="filterBidOrdersWithPriceOffersBySupplier", methods={"POST"})
     * @IsGranted("ROLE_SUPPLIER")
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
     *      description="filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="integer", property="priceOfferStatus"),
     *          @OA\Property(type="boolean", property="openToPriceOffer")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the bid orders info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Order\BidOrderFilterBySupplierResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterBidOrdersThatHavePriceOffersBySupplier(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, BidOrderFilterBySupplierRequest::class, (object)$data);

        $request->setSupplierId($this->getUserId());

        $result = $this->orderService->filterBidOrdersThatHavePriceOffersBySupplier($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * store:Get specific bid order for store
     * @Route("storebidorder/{id}", name="getSpecificBidOrderByIdForStore", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="Returns order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Order\BidOrderForStoreOwnerGetResponse")
     *
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getSpecificBidOrderForStore(int $id): JsonResponse
    {
        $result = $this->orderService->getSpecificBidOrderForStore($id, $this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * captain: Order Update Paid To Provider.
     * @Route("orderupdatepaidtoprovider/{orderId}/{paidToProvider}", name="orderUpdatePaidToProvider", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
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
     * @OA\Response(
     *      response=204,
     *      description="Return order.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              )
     *       )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function orderUpdatePaidToProvider(int $orderId,int $paidToProvider): JsonResponse
    {
        $response = $this->orderService->orderUpdatePaidToProvider($orderId, $paidToProvider);
      
        return $this->response($response, self::UPDATE);
    }

     /**
     * store:Create new sub order by store
     * @Route("createsuborder", name="createSubOrder", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="new sub order",
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
     *               @OA\Property(type="integer", property="id"),
     *               @OA\Property(type="string", property="payment"),
     *               @OA\Property(type="number", property="orderCost"),
     *               @OA\Property(type="string", property="note"),
     *               @OA\Property(type="object", property="deliveryDate"),
     *               @OA\Property(type="string", property="state"),
     *               @OA\Property(type="integer", property="orderType"),
     *      )
     *   )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function createSubOrder(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SubOrderCreateRequest::class, (object)$data);

        $request->setStoreOwner($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->orderService->createSubOrder($request);
    
        if ($result === SubscriptionConstant::CAN_NOT_CREATE_SUB_ORDER) {
      
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_SUB_ORDER_CAN_NOT_CREATE_ORDER_FINISHED);
        }

        if ($result === OrderStateConstant::ORDER_STATE_DELIVERED) {
      
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_SUB_ORDER_CAN_NOT_CREATE);
        }
        
        return $this->response($result, self::CREATE);
    }

    /**
     * captain: Order Non Sub.
     * @Route("ordernonsub/{subOderId}", name="orderNonSub", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
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
     * @OA\Response(
     *      response=204,
     *      description="Return order.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              )
     *       )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function orderNonSub(int $subOderId): JsonResponse
    {
        $response = $this->orderService->orderNonSub($subOderId, $this->getUserId());

        return $this->response($response, self::UPDATE);
    }

    /**
     * TODO for remove after used
     * admin:update isHide to show for all orders .
     * @Route("updateishideshow", name="isHideShow", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     *
     */
    public function isHideShow(): JsonResponse
    {
        $response = $this->orderService->isHideShow();

        return $this->response($response, self::UPDATE);
    }

    /**
     * store:Recycling or cancel the order
     * @Route("recyclingorcancelorder", name="recyclingOrCancelOrder", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
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
     *               @OA\Property(type="integer", property="id"),
     *               @OA\Property(type="string", property="payment"),
     *               @OA\Property(type="number", property="orderCost"),
     *               @OA\Property(type="string", property="note"),
     *               @OA\Property(type="object", property="deliveryDate"),
     *               @OA\Property(type="string", property="state"),
     *               @OA\Property(type="integer", property="orderType"),
     *      )
     *   )
     * )
     * 
     * or
     *
     * @OA\Response(
     *      response="default",
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
    public function recyclingOrCancelOrder(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, RecyclingOrCancelOrderRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->orderService->recyclingOrCancelOrder($request);
        
        if (isset($result->canCreateOrder)) {
      
            return $this->response($result, self::ERROR_ORDER_CAN_NOT_CREATE);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * store: Order Non Sub by store.
     * @Route("ordernonsubbyowner/{subOderId}", name="orderNonSubByStore", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param int $subOderId
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
     *      description="Return order.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              )
     *       )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return error.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9211"),
     *          @OA\Property(type="string", property="msg", description="error, The captain received the order Error."),
     *        )
     *     )
     *
     * @Security(name="Bearer")
     */
    public function orderNonSubByStore(int $subOderId): JsonResponse
    {
        $response = $this->orderService->orderNonSubByStore($subOderId);
 
        if ($response === OrderResultConstant::ORDER_CAPTAIN_RECEIVED) {
      
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_UNSUB_ORDER);
        }

        return $this->response($response, self::UPDATE);
    }
     
    /**
     * store:Get orders Hidden due to exceeding delivery time
     * @Route("getordershiddenduetoexceedingdeliverytime", name="getordersHiddenDueToExceedingDeliveryTime", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
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
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns orders Hidden due to exceeding delivery time",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="string", property="note"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="string", property="state"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="integer", property="storeOrderDetailsId"),
     *                  @OA\Property(type="object", property="destination"),
     *                  @OA\Property(type="string", property="recipientPhone"),
     *                  @OA\Property(type="string", property="detail"),
     *                  @OA\Property(type="integer", property="storeOwnerBranchId"),
     *                  @OA\Property(type="string", property="branchName"),
     *                  @OA\Property(type="boolean", property="orderIsMain"),
     *          )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getordersHiddenDueToExceedingDeliveryTime(): JsonResponse
    {
        $result = $this->orderService->getordersHiddenDueToExceedingDeliveryTime($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * store: cancel bid order by store owner.
     * @Route("bidordercancel/{id}", name="bidOrderCancelByStoreOwner", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="Return order.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Order\BidOrderForStoreOwnerGetResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return erorr.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9212"),
     *          @OA\Property(type="string", property="msg", description="errorMsg"),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function cancelBidOrder(int $id): JsonResponse
    {
        $response = $this->orderService->cancelBidOrder($id);

        if ($response === OrderResultConstant::ORDER_NOT_REMOVE_STATE) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::BID_ORDER_CAN_NOT_BE_DELETED);

        } elseif ($response === OrderResultConstant::ORDER_TYPE_IS_NOT_BID) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_WRONG_ORDER_TYPE);
        }

        return $this->response($response, self::UPDATE);
    }
    
    /**
     * store: order update by store. 
     * @Route("orderupdate", name="orderUpdate", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="new package category create by admin request",
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
     *              ref=@Model(type="App\Response\Admin\Order\OrderByIdGetForAdminResponse")
     *      )
     *   )
     * )
   
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
     * @Security(name="Bearer") 
     */
    public function orderUpdateByStoreOwner(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, UpdateOrderRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->orderService->orderUpdate($request);

        if ($result === OrderResultConstant::ERROR_UPDATE_BRANCH) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_UPDATE_BRANCH);
        }

        if ($result === OrderResultConstant::ERROR_UPDATE_CAPTAIN_ONGOING) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_UPDATE_CAPTAIN_ONGOING);
        }

        return $this->response($result, self::UPDATE);
    }

    /** store: update order to hidden
     * @Route("updateordertohidden/{id}", name="updateOrderToHiddenForStore", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
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
    public function updateOrderToHiddenForStore(int $id): JsonResponse
    {
        $result = $this->orderService->updateOrderToHiddenForStore($id);

        if ($result === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::NOTFOUND);
        }

        return $this->response($result, self::UPDATE);
    }
}
