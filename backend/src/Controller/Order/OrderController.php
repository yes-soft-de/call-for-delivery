<?php

namespace App\Controller\Order;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Order\OrderCreateRequest;
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
     *                  @OA\Property(type="object", property="images",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL")
     *              ),
     *          )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getSpecificOrderForStore($id): JsonResponse
    {
        $result = $this->orderService->getSpecificOrderForStore($id);

        return $this->response($result, self::FETCH);
    }
}
