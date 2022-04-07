<?php

namespace App\Controller\CaptainFinancialSystem;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfHoursService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;

/**
 * fetch Captain's Financial System According To Count Of Hours.
 * @Route("v1/captainfinancialsystemaccordingtocountofhours/")
 */
class CaptainFinancialSystemAccordingToCountOfHoursController extends BaseController
{
    private CaptainFinancialSystemAccordingToCountOfHoursService $captainFinancialSystemAccordingToCountOfHoursService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, CaptainFinancialSystemAccordingToCountOfHoursService $captainFinancialSystemAccordingToCountOfHoursService)
    {
        parent::__construct($serializer);
        $this->captainFinancialSystemAccordingToCountOfHoursService = $captainFinancialSystemAccordingToCountOfHoursService;
    }

    /**
     * :Get all Captain's Financial System According To Count Of Hours.
     * @Route("captainfinancialsystemaccordingtocountofhours", name="getAllCaptainFinancialSystemAccordingToCountOfHours", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain's Financial System According To Count Of Hours")
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
     *      description="Returns payments",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *           @OA\Items(
     *               @OA\Property(type="integer", property="id"),
     *               @OA\Property(type="integer", property="countHours"),
     *               @OA\Property(type="number", property="compensationForEveryOrder"),
     *               @OA\Property(type="number", property="salary"),
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllCaptainFinancialSystemAccordingToCountOfHours(): JsonResponse
    {
        $result = $this->captainFinancialSystemAccordingToCountOfHoursService->getAllCaptainFinancialSystemAccordingToCountOfHours();

        return $this->response($result, self::FETCH);
    }
}
