<?php

namespace App\Controller\Admin\StoreOwnerDuesFromCashOrders;

use App\AutoMapping;
use App\Controller\BaseController;
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
    private AdminStoreOwnerDuesFromCashOrdersService $adminStoreOwnerDuesFromCashOrdersService;
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;

    public function __construct(SerializerInterface $serializer, AdminStoreOwnerDuesFromCashOrdersService $adminStoreOwnerDuesFromCashOrdersService, AutoMapping $autoMapping, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminStoreOwnerDuesFromCashOrdersService = $adminStoreOwnerDuesFromCashOrdersService;
    }

    /**
     * admin:Get Store Owner Dues From Cash Orders.
     * @Route("storeownerduesfromcashorders", name="GetStoreOwnerDuesFromCashOrders", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
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
}
