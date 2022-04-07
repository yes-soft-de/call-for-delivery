<?php

namespace App\Controller\CaptainFinancialSystem;

use App\Controller\BaseController;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfOrdersService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;

/**
 * fetch Captain's Financial System According To Count Of Orders.
 * @Route("v1/captainfinancialsystemaccordingntocountoforders/")
 */
class CaptainFinancialSystemAccordingToCountOfOrdersController extends BaseController
{
    private CaptainFinancialSystemAccordingToCountOfOrdersService $captainFinancialSystemAccordingToCountOfOrdersService;

    public function __construct(SerializerInterface $serializer, CaptainFinancialSystemAccordingToCountOfOrdersService $captainFinancialSystemAccordingToCountOfOrdersService)
    {
        parent::__construct($serializer);
        $this->captainFinancialSystemAccordingToCountOfOrdersService = $captainFinancialSystemAccordingToCountOfOrdersService;
    }

    /**
     * :Get all Captain's Financial System According To Count Of Orders.
     * @Route("captainfinancialsystemaccordingtocountoforders", name="getAllCaptainFinancialSystemAccordingToCountOfOrders", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain's Financial System According ToCountOfOrders")
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
     *               @OA\Property(type="integer", property="countOrdersInMonth"),
     *               @OA\Property(type="number", property="salary"),
     *               @OA\Property(type="number", property="monthCompensation"),
     *               @OA\Property(type="number", property="bounceMaxCountOrdersInMonth"),
     *               @OA\Property(type="number", property="bounceMinCountOrdersInMonth")
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllCaptainFinancialSystemAccordingToCountOfOrders(): JsonResponse
    {
        $result = $this->captainFinancialSystemAccordingToCountOfOrdersService->getAllCaptainFinancialSystemAccordingToCountOfOrders();

        return $this->response($result, self::FETCH);
    }
}
