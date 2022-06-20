<?php

namespace App\Controller\Admin\Order;

use App\AutoMapping;
use App\Constant\Main\MainErrorConstant;
use App\Constant\Order\OrderResultConstant;
use App\Controller\BaseController;
use App\Request\Admin\Order\CaptainNotArrivedOrderFilterByAdminRequest;
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
}