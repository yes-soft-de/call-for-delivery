<?php

namespace App\Controller\Admin\Order;

use App\AutoMapping;
use App\Constant\Main\MainErrorConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Controller\BaseController;
use App\Request\Admin\Order\CaptainNotArrivedOrderFilterByAdminRequest;
use App\Request\Admin\Order\OrderCreateByAdminRequest;
use App\Request\Admin\Order\OrderFilterByAdminRequest;
use App\Request\Admin\Order\RePendingAcceptedOrderByAdminRequest;
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

/**
 * @Route("v1/admin/order/")
 */
class AdminOrderController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminOrderService $adminOrderService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminOrderService $adminOrderService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminOrderService = $adminOrderService;
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
     *          @OA\Property(type="integer", property="storeOwnerProfileId")
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
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="payment"),
     *                  @OA\Property(type="number", property="orderCost"),
     *                  @OA\Property(type="string", property="note"),
     *                  @OA\Property(type="object", property="deliveryDate"),
     *                  @OA\Property(type="object", property="createdAt"),
     *                  @OA\Property(type="object", property="updatedAt"),
     *                  @OA\Property(type="integer", property="kilometer"),
     *                  @OA\Property(type="string", property="state"),
     *                  @OA\Property(type="integer", property="orderType"),
     *                  @OA\Property(type="integer", property="storeOrderDetailsId"),
     *                  @OA\Property(type="object", property="destination"),
     *                  @OA\Property(type="string", property="recipientName"),
     *                  @OA\Property(type="string", property="recipientPhone"),
     *                  @OA\Property(type="string", property="detail"),
     *                  @OA\Property(type="integer", property="storeOwnerBranchId"),
     *                  @OA\Property(type="string", property="branchName"),
     *                  @OA\Property(type="object", property="location"),
     *                  @OA\Property(type="object", property="images",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL")
     *                  ),
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

        $result = $this->adminOrderService->filterStoreOrdersByAdmin($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: get specific order by id
     * @Route("orderbyidforadmin/{id}", name="getSpecificOrderByIdForAdmin", methods={"GET"})
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
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="payment"),
     *              @OA\Property(type="number", property="orderCost"),
     *              @OA\Property(type="string", property="note"),
     *              @OA\Property(type="object", property="deliveryDate"),
     *              @OA\Property(type="object", property="createdAt"),
     *              @OA\Property(type="object", property="updatedAt"),
     *              @OA\Property(type="integer", property="kilometer"),
     *              @OA\Property(type="string", property="state"),
     *              @OA\Property(type="integer", property="orderType"),
     *              @OA\Property(type="integer", property="storeOrderDetailsId"),
     *              @OA\Property(type="object", property="destination"),
     *              @OA\Property(type="string", property="recipientName"),
     *              @OA\Property(type="string", property="recipientPhone"),
     *              @OA\Property(type="string", property="detail"),
     *              @OA\Property(type="integer", property="storeOwnerBranchId"),
     *              @OA\Property(type="string", property="branchName"),
     *              @OA\Property(type="object", property="location"),
     *              @OA\Property(type="object", property="orderImage",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="integer", property="captainUserId"),
     *              @OA\Property(type="string", property="captainName"),
     *              @OA\Property(type="string", property="phone")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getSpecificOrderByIdForAdmin(int $id): JsonResponse
    {
        $result = $this->adminOrderService->getSpecificOrderByIdForAdmin($id);

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
     *          @OA\Property(type="string", property="toDate")
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
     * @Route("orderpending", name="getPendingOrdersForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN") 
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
     *              )
     *           )
     *        )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getPendingOrdersForAdmin(): JsonResponse
    {
        $response = $this->adminOrderService->getPendingOrdersForAdmin();
        
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
     *      description="new package category create by admin request",
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
     *              ref=@Model(type="App\Response\Admin\Order\OrderByIdGetForAdminResponse")
     *      )
     *   )
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

        $result = $this->adminOrderService->rePendingAcceptedOrderByAdmin($request);

        if ($result === OrderResultConstant::ORDER_ACCEPTED_BY_CAPTAIN) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_ALREADY_ACCEPTED_BY_CAPTAIN);
        }

        if ($result === OrderResultConstant::ORDER_RETURNING_TO_PENDING_HAS_PROBLEM) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_IN_RETURNING_ORDER_TO_PENDING_STATUS);
        }

        return $this->response($result, self::UPDATE);
    }

     /**
     * @Route("updateordertohidden/{id}", name="updateOrderToHidden", methods={"PUT"})
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
        $result = $this->adminOrderService->updateOrderToHidden($id);

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

        $result = $this->adminOrderService->orderUpdateByAdmin($request);

        if ($result === OrderResultConstant::ERROR_UPDATE_BRANCH) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_UPDATE_BRANCH);
        }

        if ($result === OrderResultConstant::ERROR_UPDATE_CAPTAIN_ONGOING) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_UPDATE_CAPTAIN_ONGOING);
        }

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

        $result = $this->adminOrderService->createOrderByAdmin($request);

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
}
