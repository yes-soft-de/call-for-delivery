<?php

namespace App\Controller\CaptainFinancialSystem;

use App\Controller\BaseController;
use App\Service\CaptainFinancialSystem\CaptainFinancialDuesService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Model;
// use App\Service\CaptainFinancialSystem\CaptainStopFinancialSystemAndFinancialCycleService;

/**
 * Captain Financial Dues.
 * @Route("v1/captainfinancialdues/")
 */
class CaptainFinancialDuesController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private CaptainFinancialDuesService $captainFinancialDuesService,
        // private CaptainStopFinancialSystemAndFinancialCycleService $captainStopFinancialSystemAndFinancialCycleService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * captain: get Captain Financial Dues.
     * @Route("captainfinancialdues", name="getCaptainFinancialDues", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Financial Dues")
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
     *      description="Returns get Captain Financial Dues",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *             ref=@Model(type="App\Response\CaptainFinancialSystem\CaptainFinancialDuesResponse")
     *      )
     *    )
     *  )
     *
     * @Security(name="Bearer")
     */
    public function getCaptainFinancialDues(): JsonResponse
    {
        $result = $this->captainFinancialDuesService->getCaptainFinancialDues($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    // This feature had been commented out currently
//    /**
//     * captain: stop financial system and financial cycle
//     * @Route("stopfinancialcycle", name="stopFinancialSystemAndFinancialCycle", methods={"PUT"})
//     * @IsGranted("ROLE_CAPTAIN")
//     * @return JsonResponse
//     *
//     * @OA\Tag(name="Captain Financial Dues")
//     *
//     * @OA\Parameter(
//     *      name="token",
//     *      in="header",
//     *      description="token to be passed as a header",
//     *      required=true
//     * )
//     *
//     * @OA\Response(
//     *      response=201,
//     *      description="Returns id",
//     *      @OA\JsonContent(
//     *          @OA\Property(type="string", property="status_code"),
//     *          @OA\Property(type="string", property="msg"),
//     *          @OA\Property(type="object", property="Data",
//     *            @OA\Property(type="integer", property="id"),
//     *      )
//     *   )
//     * )
//     *
//     * @Security(name="Bearer")
//     */
//    public function stopFinancialSystemAndFinancialCycle(): JsonResponse
//    {
//        $result = $this->captainStopFinancialSystemAndFinancialCycleService->stopFinancialSystemAndFinancialCycle($this->getUserId());
//
//        return $this->response($result, self::UPDATE);
//    }
}
