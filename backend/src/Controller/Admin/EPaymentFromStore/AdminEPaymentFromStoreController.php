<?php

namespace App\Controller\Admin\EPaymentFromStore;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Admin\EPaymentFromStore\EPaymentFromStoreFilterByAdminRequest;
use App\Request\Admin\Order\CaptainNotArrivedOrderFilterByAdminRequest;
use App\Service\Admin\EPaymentFromStore\AdminEPaymentFromStoreService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("v1/admin/epaymentfromstore/")
 */
class AdminEPaymentFromStoreController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private AdminEPaymentFromStoreService $adminEPaymentFromStoreService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin: filter e-payments from store by admin
     * @Route("filterepaymentfromstorebyadmin", name="filterEPaymentFromStoreByAdminAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="E-Payment from Store")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Post a request with filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="storeOwnerProfileId"),
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns all e-payments which had been made by a specific store",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="number", property="subscriptionCost"),
     *              @OA\Property(type="array", property="ePayments",
     *                  @OA\Items(
     *                      ref=@Model(type="App\Response\Admin\EPaymentFromStore\EPaymentFromStoreGetForAdminResponse")
     *                  )
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterEPaymentFromStoreByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, EPaymentFromStoreFilterByAdminRequest::class,
            (object) $data);

        $result = $this->adminEPaymentFromStoreService->filterEPaymentFromStoreByAdmin($request);

        return $this->response($result, self::FETCH);
    }
}
