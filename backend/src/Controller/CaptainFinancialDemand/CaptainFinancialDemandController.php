<?php

namespace App\Controller\CaptainFinancialDemand;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\CaptainFinancialDemand\CaptainFinancialDemandConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Controller\BaseController;
use App\Request\CaptainFinancialDemand\CaptainFinancialDemandCreateRequest;
use App\Service\CaptainFinancialDemand\CaptainFinancialDemandService;
use OpenApi\Annotations as OA;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

/**
 * @Route("v1/captainfinancialdemand/")
 */
class CaptainFinancialDemandController extends BaseController
{
    public function __construct(
        private AutoMapping $autoMapping,
        SerializerInterface $serializer,
        private ValidatorInterface $validator,
        private CaptainFinancialDemandService $captainFinancialDemandService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * Create new captain financial demand.
     * @Route("captainfinancialdemand", name="createCaptainFinancialDemand", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Financial Demand")
     *
     * @OA\RequestBody(
     *      description="Create new captain financial demand",
     *      @OA\JsonContent(
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new captain's financial demand",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="object", property="createdAt")
     *          )
     *      )
     * )
     */
    public function createCaptainFinancialDemand(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainFinancialDemandCreateRequest::class, (object)$data);

        $request->setCaptain($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->captainFinancialDemandService->createCaptainFinancialDemand($request);

        if ($response === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return $this->response($response, self::CAPTAIN_PROFILE_NOT_EXIST);

        } elseif ($response === CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
            return $this->response($response, self::CAPTAIN_FINANCIAL_DUES_WAS_NOT_FOUND);

        } elseif ($response === CaptainFinancialDemandConstant::CAPTAIN_FINANCIAL_DEMAND_ALREADY_EXIST_CONST) {
            return $this->response($response, self::CAPTAIN_FINANCIAL_DEMAND_ALREADY_EXIST_CONST);
        }

        return $this->response($response, self::CREATE);
    }
}
