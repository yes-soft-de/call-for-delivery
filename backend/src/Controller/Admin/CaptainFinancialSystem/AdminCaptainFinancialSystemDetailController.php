<?php

namespace App\Controller\Admin\CaptainFinancialSystem;

use App\Controller\BaseController;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Symfony\Component\HttpFoundation\Request;
use stdClass;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Main\MainErrorConstant;

/**
 * create Captain Financial System Detail.
 * @Route("v1/admin/captainfinancialsystemdetail/")
 */
class AdminCaptainFinancialSystemDetailController extends BaseController
{
    private AdminCaptainFinancialSystemDetailService $adminCaptainFinancialSystemDetailService;

    public function __construct(SerializerInterface $serializer, AdminCaptainFinancialSystemDetailService $adminCaptainFinancialSystemDetailService)
    {
        parent::__construct($serializer);
        $this->adminCaptainFinancialSystemDetailService = $adminCaptainFinancialSystemDetailService;
    }

    /**
     * admin: get Balance Detail for specific captain.
     * @Route("captainbalancedetailforcaptainspecific/{captainId}", name="getBalanceDetailForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Financial System Detail")
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
     *      description="Returns get Balance Detail",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *          @OA\Property(type="integer", property="countOrders"),
     *          @OA\Property(type="integer", property="countOrdersMaxFromNineteen"),
     *          @OA\Property(type="float", property="compensationForEveryOrder"),
     *          @OA\Property(type="float", property="salary"),
     *          @OA\Property(type="float", property="total"),
     *          @OA\Property(type="float", property="financialDues"),
     *          @OA\Property(type="float", property="sumPayments"),
     *          @OA\Property(type="string", property="totalIsMain"),
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return erorr.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9602"),
     *          @OA\Property(type="string", property="msg", description="youNotHaveCaptainFinancialSystem"),
     *      )
     * )
     *   
     * @Security(name="Bearer")
     */
    public function getBalanceDetailForAdmin(int $captainId): JsonResponse
    {
        $result = $this->adminCaptainFinancialSystemDetailService->getBalanceDetailForAdmin($captainId);

        if($result === CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM);
        }

        return $this->response($result, self::FETCH);
    }
}
