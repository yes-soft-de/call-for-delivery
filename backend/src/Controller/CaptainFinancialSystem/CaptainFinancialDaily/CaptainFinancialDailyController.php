<?php

namespace App\Controller\CaptainFinancialSystem\CaptainFinancialDaily;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyResultConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyFilterRequest;
use App\Service\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyGetService;
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
 * @Route("v1/captainfinancialdaily/")
 */
class CaptainFinancialDailyController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
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
    public function getCaptainFinancialDailyOfToday(): JsonResponse
    {
        $result = $this->captainFinancialDailyGetService->getCaptainFinancialAmountDailyByCaptainUserIdAndSpecificDate($this->getUserId(),
            new \DateTime('today'));

        return $this->response($result, self::FETCH);
    }

    /**
     * captain: filter captain financial daily by captains
     * @Route("filtercaptainfinancialdaily", name="filterCaptainFinancialDailyByCaptain", methods={"POST"})
     * @IsGranted("ROLE_CAPTAIN")
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
     *      description="Post a request with filtering orders options",
     *      @OA\JsonContent(
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
     *                  ref=@Model(type="App\Response\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyFilterResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterCaptainFinancialDaily(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainFinancialDailyFilterRequest::class, (object)$data);

        $request->setCaptainUserId($this->getUserId());

        $result = $this->captainFinancialDailyGetService->filterCaptainFinancialDaily($request);

        return $this->response($result, self::FETCH);
    }
}
