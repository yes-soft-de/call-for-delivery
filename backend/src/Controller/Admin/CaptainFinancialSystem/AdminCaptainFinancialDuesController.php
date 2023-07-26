<?php

namespace App\Controller\Admin\CaptainFinancialSystem;

use App\Controller\BaseController;
use App\Request\Admin\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueFilterByAdminRequest;
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
use App\Request\Admin\CaptainFinancialSystem\ApprovalOrRefusalFinancialSystemAndFinancialCycleByAdminRequest;
use Symfony\Component\HttpFoundation\Response;
use App\Service\Admin\CaptainFinancialSystem\AdminStopFinancialSystemAndFinancialCycleService;
use App\AutoMapping;
use Symfony\Component\Validator\Validator\ValidatorInterface;

/**
 * Captain Financial Dues for admin.
 * @Route("v1/captainfinancialduesforadmin/")
 */
class AdminCaptainFinancialDuesController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AdminCaptainFinancialDuesService $adminCaptainFinancialDuesService,
        private AdminStopFinancialSystemAndFinancialCycleService $adminStopFinancialSystemAndFinancialCycleService,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin: get Captain Financial Dues.
     * @Route("captainfinancialduesforadmin/{captainId}", name="getCaptainFinancialDuesForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $captainId
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

    /**
     * admin: (approval | Refusal) to stop the financial cycle and financial system
     * @Route("approvalorrefusalfinancialcycle", name="approvalOrRefusalFinancialSystemAndFinancialCycle", methods={"PUT"})
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
     * @OA\RequestBody(
     *      description="(approval | Refusal) to stop the financial cycle and financial system",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="id"),
     *          @OA\Property(type="number", property="date"),
     *          @OA\Property(type="number", property="state"),
     *      )
     * )
     * 
     * @OA\Response(
     *      response=204,
     *      description="Return id",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *      )
     *   )
     * )
     *  
     * @Security(name="Bearer")
     */
    public function approvalOrRefusalFinancialSystemAndFinancialCycle(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ApprovalOrRefusalFinancialSystemAndFinancialCycleByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStopFinancialSystemAndFinancialCycleService->approvalOrRefusalFinancialSystemAndFinancialCycle($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: filter captain financial due sum
     * @Route("filtercaptainfinancialduesumbyadmin", name="filterCaptainFinancialDueSumByAdmin", methods={"POST"})
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
     * @OA\RequestBody(
     *      description="filter captain financial due sum",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="status"),
     *          @OA\Property(type="boolean", property="hasCaptainFinancialDueDemanded")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Return captain financial due sum according to filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueSumFilterByAdminResponse")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterCaptainFinancialDueByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainFinancialDueFilterByAdminRequest::class,
            (object)$data);

        $result = $this->adminCaptainFinancialDuesService->filterCaptainFinancialDueByAdmin($request);

        return $this->response($result, self::FETCH);
    }
}
