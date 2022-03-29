<?php

namespace App\Controller\Admin\Report;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Service\Admin\Report\ReportService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use OpenApi\Annotations as OA;

/**
 * @Route("v1/admin/report/")
 */
class ReportController extends BaseController
{
    private ReportService $reportService;

    public function __construct(SerializerInterface $serializer, ReportService $reportService)
    {
        parent::__construct($serializer);
        $this->reportService = $reportService;
    }

    /**
     * admin: Get statistics.
     * @Route("getstatistics", name="getStatisticsForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin")
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
     *      description="Returns packages",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="activeStoresCount"),
     *              @OA\Property(type="integer", property="inactiveStoresCount"),
     *              @OA\Property(type="integer", property="ongoingOrdersCount"),
     *              @OA\Property(type="integer", property="allOrdersCount")
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
}
