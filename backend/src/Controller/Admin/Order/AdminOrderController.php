<?php

namespace App\Controller\Admin\Order;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Admin\Order\CaptainNotArrivedOrderFilterByAdminRequest;
use App\Request\Admin\Order\OrderFilterByAdminRequest;
use App\Service\Admin\Order\AdminOrderService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use OpenApi\Annotations as OA;

/**
 * @Route("v1/admin/order/")
 */
class AdminOrderController extends BaseController
{
    private AutoMapping $autoMapping;
    private AdminOrderService $adminOrderService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, AdminOrderService $adminOrderService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
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
     * admin: Get pending orders for captain.
     * @Route("orderpending",   name="getPendingOrdersForAdmin", methods={"GET"})
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
     *                  @OA\Property(type="array", property="subOrder",
     *                    @OA\Items( 
     *                        @OA\Property(type="integer", property="id"),
     *                        @OA\Property(type="object", property="deliveryDate"),
     *                        @OA\Property(type="object", property="createdAt"),
     *                        @OA\Property(type="string", property="payment"),
     *                        @OA\Property(type="number", property="orderCost"),
     *                        @OA\Property(type="integer", property="orderType"),
     *                        @OA\Property(type="string", property="note"),
     *                        @OA\Property(type="string", property="state"),
     *                          ) 
     *                      )
     *                  ),
     *            )
     *       )
     *  )
     *
     * @Security(name="Bearer")
     */
    public function getPendingOrdersForAdmin(): JsonResponse
    {
        $response = $this->adminOrderService->getPendingOrdersForAdmin();
        
        return $this->response($response, self::FETCH);
    }
}