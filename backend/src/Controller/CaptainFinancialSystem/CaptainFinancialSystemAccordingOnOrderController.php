<?php

namespace App\Controller\CaptainFinancialSystem;

use App\Controller\BaseController;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemAccordingOnOrderService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;

/**
 * fetch Captain's Financial System According On Order.
 * @Route("v1/captainfinancialsystemaccordingnorder/")
 */
class CaptainFinancialSystemAccordingOnOrderController extends BaseController
{
    private CaptainFinancialSystemAccordingOnOrderService $CaptainFinancialSystemAccordingOnOrderService;

    public function __construct(SerializerInterface $serializer, CaptainFinancialSystemAccordingOnOrderService $CaptainFinancialSystemAccordingOnOrderService)
    {
        parent::__construct($serializer);
        $this->CaptainFinancialSystemAccordingOnOrderService = $CaptainFinancialSystemAccordingOnOrderService;
    }

    /**
     * :Get all Captain's Financial System According On Order.
     * @Route("captainfinancialsystemaccordingonorder", name="getAllCaptainFinancialSystemAccordingOnOrder", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain's Financial System According OnOrder")
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
     *               @OA\Property(type="string", property="categoryName"),
     *               @OA\Property(type="integer", property="countKilometersFrom"),
     *               @OA\Property(type="integer", property="countKilometersTo"),
     *               @OA\Property(type="number", property="amount"),
     *               @OA\Property(type="number", property="bounce"),
     *               @OA\Property(type="number", property="bounceCountOrdersInMonth"),
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllCaptainFinancialSystemAccordingOnOrder(): JsonResponse
    {
        $result = $this->CaptainFinancialSystemAccordingOnOrderService->getAllCaptainFinancialSystemAccordingOnOrder();

        return $this->response($result, self::FETCH);
    }
}
