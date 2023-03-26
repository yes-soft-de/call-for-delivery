<?php

namespace App\Controller\Admin\Report;

use App\AutoMapping;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\Admin\Report\CaptainWithDeliveredOrdersDuringSpecificTimeFilterByAdminRequest;
use App\Request\Admin\Report\StoresAndOrdersCountDuringSpecificTimeFilterByAdminRequest;
use App\Service\Admin\Report\ReportService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Nelmio\ApiDocBundle\Annotation\Model;
use OpenApi\Annotations as OA;

/**
 * @Route("v1/admin/report/")
 */
class ReportController extends BaseController
{
    private AutoMapping $autoMapping;
    private ReportService $reportService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ReportService $reportService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->reportService = $reportService;
    }

    /**
     * admin: Get statistics.
     * @Route("getstatistics", name="getStatisticsForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Report")
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
     *      description="Returns general statistics",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Report\StatisticsForAdminGetResponse")
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getStatisticsForAdmin(): JsonResponse
    {
        $result = $this->reportService->getStatisticsForAdmin();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Get advanced statistics for admin.
     * @Route("fetchdashstatistics", name="getAdvancedStatisticsForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Report")
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
     *      description="Returns general statistics",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="object", property="data",
     *                  @OA\Property(type="object", property="orders",
     *                      @OA\Property(type="object", property="counts",
     *                          @OA\Property(type="integer", property="allOrders"),
     *                          @OA\Property(type="object", property="delivered",
     *                              @OA\Property(type="object", property="lastSevenDays",
     *                                  @OA\Property(type="array", property="daily",
     *                                      @OA\Items(
     *                                          @OA\Property(type="string", property="date"),
     *                                          @OA\Property(type="integer", property="count")
     *                                      )
     *                                  ),
     *                                  @OA\Property(type="integer", property="sum"),
     *                                  @OA\Property(type="integer", property="minDeliveredCountPerDay"),
     *                                  @OA\Property(type="integer", property="maxDeliveredCountPerDay")
     *                              ),
     *                          ),
     *                          @OA\Property(type="integer", property="pending"),
     *                          @OA\Property(type="integer", property="onGoing")
     *                      )
     *                  ),
     *                  @OA\Property(type="object", property="stores",
     *                      @OA\Property(type="object", property="counts",
     *                          @OA\Property(type="integer", property="active"),
     *                          @OA\Property(type="integer", property="inactive"),
     *                          @OA\Property(type="array", property="lastThreeActive",
     *                              @OA\Items(
     *                                  @OA\Property(type="integer", property="id"),
     *                                  @OA\Property(type="string", property="storeOwnerName"),
     *                                  @OA\Property(type="array", property="images",
     *                                      @OA\Items(
     *                                          @OA\Property(type="string", property="imageURL"),
     *                                          @OA\Property(type="string", property="image"),
     *                                          @OA\Property(type="string", property="baseURL")
     *                                      )
     *                                  ),
     *                                  @OA\Property(type="object", property="createdAt")
     *                              )
     *                          )
     *                      )
     *                  ),
     *                  @OA\Property(type="object", property="captains",
     *                      @OA\Property(type="object", property="counts",
     *                          @OA\Property(type="integer", property="active"),
     *                          @OA\Property(type="integer", property="inactive"),
     *                          @OA\Property(type="array", property="lastThreeActive",
     *                              @OA\Items(
     *                                  @OA\Property(type="integer", property="id"),
     *                                  @OA\Property(type="string", property="captainName"),
     *                                  @OA\Property(type="array", property="images",
     *                                      @OA\Items(
     *                                          @OA\Property(type="string", property="imageURL"),
     *                                          @OA\Property(type="string", property="image"),
     *                                          @OA\Property(type="string", property="baseURL")
     *                                      )
     *                                  ),
     *                                  @OA\Property(type="object", property="createdAt")
     *                              )
     *                          )
     *                      )
     *                  )
     *              )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getDashboardStatisticsForAdmin(): JsonResponse
    {
        $result = $this->reportService->getDashboardStatisticsForAdmin();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Get captains ratings for admin.
     * @Route("captainsratings", name="getCaptainsRatingsForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Report")
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
     *      description="Returns captains names and images and avg ratings for each one",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Report\CaptainsRatingsForAdminGetResponse")
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCaptainsRatingsForAdmin(): JsonResponse
    {
        $result = $this->reportService->getCaptainsRatingsForAdmin();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Get active captains with delivered (during last financial cycle) orders count for admin
     * @Route("activecaptainswithorderscountforadmin", name="getActiveCaptainsWithOrdersCountForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Report")
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
     *      description="Returns active captains with orders count",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Report\ActiveCaptainWithOrdersCountInLastFinancialCycleGetForAdminResponse")
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByAdmin(): JsonResponse
    {
        $result = $this->reportService->getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByAdmin();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: filter captains who delivered orders between specific dates by admin
     * @Route("filtercaptainsdeliveredordersbyadmin", name="filterCaptainsWithTheirDeliveredOrdersByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Report")
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
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns captains with delivered orders that accomodate with the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\Report\CaptainsWithDeliveredOrdersCountFilterByAdminResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterCaptainsWhoDeliveredOrdersDuringSpecificTime(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainWithDeliveredOrdersDuringSpecificTimeFilterByAdminRequest::class, (object)$data);

        $result = $this->reportService->getCaptainsWhoDeliveredOrdersDuringSpecificTime($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Get top active stores depending on delivered orders during current month
     * @Route("topactivestoresforadmin", name="getTopActiveStoresWithOrdersCountForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Report")
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
     *      description="Returns active captains with orders count",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Report\TopOrdersStoresForCurrentMonthByAdminGetResponse")
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getTopOrdersStoresDuringCurrentMonthByAdmin(): JsonResponse
    {
        $result = $this->reportService->getTopOrdersStoresDuringCurrentMonthByAdmin();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: filter stores who delivered orders between specific dates by admin
     * @Route("filterstoresdeliveredordersbyadmin", name="filterStoresWithTheirDeliveredOrdersByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Report")
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
     *          @OA\Property(type="string", property="state"),
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns stores with delivered orders that accomodate with the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\Report\StoresWithOrdersCountDuringSpecificTimeFilterByAdminResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterTopStoresAccordingOnOrdersByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoresAndOrdersCountDuringSpecificTimeFilterByAdminRequest::class, (object)$data);

        $result = $this->reportService->filterTopStoresAccordingOnOrdersByAdmin($request);

        return $this->response($result, self::FETCH);
    }

//    /**
//     * DEBUGGER: Get active captains with delivered (during last financial cycle) orders count for admin
//     * @Route("activecaptainswithorderscountfortester", name="getActiveCaptainsWithOrdersCountForTester", methods={"POST"})
//     * @IsGranted("ROLE_SUPER_ADMIN")
//     * @param Request $request
//     * @return JsonResponse
//     *
//     * @OA\Tag(name="Report")
//     *
//     * @OA\Parameter(
//     *      name="token",
//     *      in="header",
//     *      description="token to be passed as a header",
//     *      required=true
//     * )
//     *
//     * @Security(name="Bearer")
//     */
//    public function getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByTester(Request $request): JsonResponse
//    {
//        $data = json_decode($request->getContent(), true);
//
//        if ($data !== null && $data !== false) {
//            $result = $this->reportService->getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByTester($data['customizedTimezone']);
//
//            return $this->response($result, self::FETCH);
//        }
//
//        return $this->response(MainErrorConstant::ERROR_MSG, self::FETCH);
//    }
}
