<?php

namespace App\Controller\Admin\CaptainFinancialSystem\CaptainFinancialDaily;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyFilterByAdminRequest;
use App\Service\Admin\CaptainFinancialSystem\CaptainFinancialDaily\AdminCaptainFinancialDailyGetService;
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
 * @Route("v1/admin/captainfinancialdaily/")
 */
class AdminCaptainFinancialDailyController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private AdminCaptainFinancialDailyGetService $adminCaptainFinancialDailyGetService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin: filter captain financial daily by admin
     * @Route("filtercaptainfinancialdailybyadmin", name="filtercaptainfinancialdailybyadmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Financial Daily")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Post a request with filtering captain financial daily options",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="captainProfileId"),
     *          @OA\Property(type="integer", property="isPaid"),
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns captain financial daily which meet the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyFilterByAdminResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterCaptainFinancialDailyByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainFinancialDailyFilterByAdminRequest::class, (object)$data);

        $result = $this->adminCaptainFinancialDailyGetService->filterCaptainFinancialDailyByAdmin($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Get active and online captains with their financial daily of today for admin
     * @Route("captainswithfinancialdailyoftoday", name="fetchActiveAndOnlineCaptainsWithTodayFinancialDailyByAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Financial Daily")
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
     *      description="Returns captains info with financial daily of today",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyTodayGetForAdminResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getActiveCaptainsWithFinancialDailyOfTodayForAdmin(): JsonResponse
    {
        $result = $this->adminCaptainFinancialDailyGetService->getActiveCaptainsWithFinancialDailyOfTodayForAdmin();

        return $this->response($result, self::FETCH);
    }
}
