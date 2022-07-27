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
    private AdminCaptainFinancialDuesService $adminCaptainFinancialDuesService;
    private AdminStopFinancialSystemAndFinancialCycleService $adminStopFinancialSystemAndFinancialCycleService;
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;

    public function __construct(SerializerInterface $serializer, AdminCaptainFinancialDuesService $adminCaptainFinancialDuesService, AdminStopFinancialSystemAndFinancialCycleService $adminStopFinancialSystemAndFinancialCycleService, AutoMapping $autoMapping, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->adminCaptainFinancialDuesService = $adminCaptainFinancialDuesService;
        $this->adminStopFinancialSystemAndFinancialCycleService = $adminStopFinancialSystemAndFinancialCycleService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
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

        $result = $this->adminStopFinancialSystemAndFinancialCycleService->approvalOrRefusalFinancialSystemAndFinancialCycle( $request);

        return $this->response($result, self::UPDATE);
    }
}
