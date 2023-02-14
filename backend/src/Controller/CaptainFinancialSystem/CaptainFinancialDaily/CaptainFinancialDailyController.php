<?php

namespace App\Controller\CaptainFinancialSystem\CaptainFinancialDaily;

use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Service\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyGetService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("v1/captainfinancialdaily/")
 */
class CaptainFinancialDailyController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private CaptainFinancialDailyGetService $captainFinancialDailyGetService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * captain: get Captain Financial Daily amount of today.
     * @Route("todaycaptainfinancialdailyamount", name="getCaptainFinancialDailyAmountOfToday", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
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
     *      description="Returns Captain Financial Daily amount of today",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *             ref=@Model(type="App\Response\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyAmountGetForCaptainResponse")
     *      )
     *    )
     *  )
     *
     * @Security(name="Bearer")
     */
    public function getCaptainFinancialDues(): JsonResponse
    {
        $result = $this->captainFinancialDailyGetService->getCaptainFinancialAmountDailyByCaptainUserIdAndSpecificDate($this->getUserId(),
            new \DateTime('today'));

        if ($result === CaptainFinancialDailyResultConstant::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_FINANCIAL_DAILY_NOT_EXIST_CONST);
        }

        return $this->response($result, self::FETCH);
    }
}
