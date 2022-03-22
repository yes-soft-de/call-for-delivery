<?php

namespace App\Controller\Order;

use App\AutoMapping;
use App\Controller\BaseController;
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
use Nelmio\ApiDocBundle\Annotation\Security;
use App\Constant\Main\MainErrorConstant;

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
     *                  @OA\Property(type="string", property="images")
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
     *          @OA\Property(type="string", property="status_code", description="9100"),
     *          @OA\Property(type="string", property="msg", description="error captain inactive Error."),
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
        
        return $this->response($response, self::FETCH);
    }
    
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
     *              ),
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getSpecificOrderForCaptain($id): JsonResponse
    {
        $result = $this->orderService->getSpecificOrderForCaptain($id);

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
     *              )
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

        return $this->response( $response, self::UPDATE);
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
}
