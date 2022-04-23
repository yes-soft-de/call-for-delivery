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
use Symfony\Component\HttpFoundation\Request;
use stdClass;
use Nelmio\ApiDocBundle\Annotation\Model;

/**
 * Captain Financial Dues.
 * @Route("v1/captainfinancialdues/")
 */
class CaptainFinancialDuesController extends BaseController
{
    private CaptainFinancialDuesService $captainFinancialDuesService;

    public function __construct(SerializerInterface $serializer, CaptainFinancialDuesService $captainFinancialDuesService)
    {
        parent::__construct($serializer);
        $this->captainFinancialDuesService = $captainFinancialDuesService;
    }

    /**
     * captain: get Captain Financial Dues.
     * @Route("captainfinancialdues", name="getCaptainFinancialDues", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @param Request $request
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
}
