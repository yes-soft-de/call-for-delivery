<?php

namespace App\Controller\Admin\StoreOwnerDuesFromCashOrders;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreDueSumFromCashOrderFilterByAdminRequest;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDueFromCashOrderFilterByAdminRequest;
use App\Service\Admin\StoreOwnerDuesFromCashOrders\AdminStoreOwnerDuesFromCashOrdersService;;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersFilterGetRequest;
use Nelmio\ApiDocBundle\Annotation\Model;

/**
 * admin :fetch Store Owner Dues From Cash Orders.
 * @Route("v1/admin/storeownerduesfromcashorders/")
 */
class AdminStoreOwnerDuesFromCashOrdersController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AdminStoreOwnerDuesFromCashOrdersService $adminStoreOwnerDuesFromCashOrdersService,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin:Get Store Owner Dues From Cash Orders.
     * @Route("storeownerduesfromcashorders", name="GetStoreOwnerDuesFromCashOrders", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Dues From Cash Orders")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="get Store Owner Dues From Cash Orders By StoreId and Date",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="storeId"),
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *      )
     * )
     * @OA\Response(
     *      response=200,
     *      description="Returns Store Owner Dues From Cash Orders By StoreId and Date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="object", property="total",
     *                  @OA\Property(type="number", property="sumAmountStorOwnerDues"),
     *                  @OA\Property(type="number", property="sumPaymentsFromCompany"),
     *                  @OA\Property(type="boolean", property="advancePayment"),
     *                  @OA\Property(type="number", property="total"),
     *              ),
     *              @OA\Property(type="array", property="detail",
     *                 @OA\Items(
     *                      ref=@Model(type="App\Response\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersResponse")
     *         )
     *      ),
     *              @OA\Property(type="array", property="finishedPayments",
     *                 @OA\Items(
     *                      ref=@Model(type="App\Response\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersResponse")
     *         )
     *      )
     *    )
     *  )
     * )
     * @Security(name="Bearer")
     */
    public function getStoreOwnerDuesFromCashOrders(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerDuesFromCashOrdersFilterGetRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStoreOwnerDuesFromCashOrdersService->filterStoreOwnerDuesFromCashOrders($request);
        
        return $this->response($result, self::FETCH);
    }

    /**
     * admin: filter store due sum from cash orders
     * @Route("filterstoreduesumfromcashorderbyadmin", name="filterStoreDueSumFromCashOrderByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Dues From Cash Orders")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="filter request options",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="isPaid", example="1: paid. 2: not paid")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns Store Owner Due Sum from cash orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileId"),
     *                  @OA\Property(type="string", property="storeOwnerName"),
     *                  @OA\Property(type="array", property="image",
     *                      @OA\Items()
     *                  ),
     *                  @OA\Property(type="number", property="amountSum"),
     *                  @OA\Property(type="number", property="toBePaid"),
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterStoreDueFromCashOrdersByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreDueSumFromCashOrderFilterByAdminRequest::class, (object)$data);

        $result = $this->adminStoreOwnerDuesFromCashOrdersService->filterStoreDueFromCashOrdersByAdmin($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: filter store owners due from cash orders by admin
     * @Route("filterstoreduefromcashorderbyadmin", name="filterStoreOwnerDueFromCashOrderByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Dues From Cash Orders")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="filter request options",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="storeOwnerProfileId"),
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="integer", property="isPaid", example="1: paid. 2: not paid"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns Store Owner Due from cash orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileId"),
     *                  @OA\Property(type="string", property="storeOwnerName"),
     *                  @OA\Property(type="array", property="image",
     *                      @OA\Items()
     *                  ),
     *                  @OA\Property(type="number", property="amount"),
     *                  @OA\Property(type="number", property="toBePaid"),
     *                  @OA\Property(type="array", property="paymentFromCompanyToStore",
     *                      @OA\Items()
     *                  ),
     *                  @OA\Property(type="integer", property="flag", example="1: paid. 2: not paid")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterStoreOwnerDueFromCashOrderByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerDueFromCashOrderFilterByAdminRequest::class, (object)$data);

        $result = $this->adminStoreOwnerDuesFromCashOrdersService->filterStoreOwnerDueFromCashOrderByAdmin($request);

        return $this->response($result, self::FETCH);
    }
}
