<?php

namespace App\Controller\Admin\CaptainFinancialSystem;

use App\Controller\BaseController;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialDuesService;
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
 * Captain Financial Dues for admin.
 * @Route("v1/captainfinancialduesforadmin/")
 */
class AdminCaptainFinancialDuesController extends BaseController
{
    private AdminCaptainFinancialDuesService $adminCaptainFinancialDuesService;

    public function __construct(SerializerInterface $serializer, AdminCaptainFinancialDuesService $adminCaptainFinancialDuesService)
    {
        parent::__construct($serializer);
        $this->adminCaptainFinancialDuesService = $adminCaptainFinancialDuesService;
    }

    /**
     * admin: get Captain Financial Dues.
     * @Route("captainfinancialduesforadmin/{captainId}", name="getCaptainFinancialDuesForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
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
     *             ref=@Model(type="App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialDuesResponse")
     *      )
     *    )
     *  ) 
     * 
     * @Security(name="Bearer")
     */
    public function getCaptainFinancialDues($captainId): JsonResponse
    {
        $result = $this->adminCaptainFinancialDuesService->getCaptainFinancialDues($captainId);

        return $this->response($result, self::FETCH);
    }

    /**
     * for remove after used
     * @Route("statetoactive", name="stateToActive", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     */
    public function stateToActive(): JsonResponse
    {
        $result = $this->adminCaptainFinancialDuesService->stateToActive();

        return $this->response($result, self::FETCH);
    }
}
