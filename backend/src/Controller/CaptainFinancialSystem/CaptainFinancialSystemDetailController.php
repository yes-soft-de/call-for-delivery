<?php

namespace App\Controller\CaptainFinancialSystem;

use App\Controller\BaseController;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemDetailService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use App\AutoMapping;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use App\Request\CaptainFinancialSystem\CaptainFinancialSystemDetailRequest;
use stdClass;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Main\MainErrorConstant;

/**
 * create Captain Financial System Detail.
 * @Route("v1/captainfinancialsystemdetail/")
 */
class CaptainFinancialSystemDetailController extends BaseController
{
    private CaptainFinancialSystemDetailService $captainFinancialSystemDetailService;
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;

    public function __construct(SerializerInterface $serializer, CaptainFinancialSystemDetailService $captainFinancialSystemDetailService, AutoMapping $autoMapping, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->captainFinancialSystemDetailService = $captainFinancialSystemDetailService;
    }

    /**
     * captain: create Captain Financial System Detail
     * @Route("captainfinancialsystemdetail", name="createCaptainFinancialSystemDetail", methods={"POST"})
     * @IsGranted("ROLE_CAPTAIN")
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
     * @OA\RequestBody(
     *      description="new Captain Financial System Detail",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="captainFinancialSystemType"),
     *          @OA\Property(type="integer", property="captainFinancialSystemId"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="ReturnsCaptain Financial System Detail",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="integer", property="captainFinancialSystemType"),
     *          @OA\Property(type="integer", property="captainFinancialSystemId"),
     *      )
     *   )
     * )
     * 
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns the completeAccountStatus of the user",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9601"),
     *          @OA\Property(type="string", property="msg", description="youHaveFinancialSystem,canNotChooseAnotherFinancialSystemNow Error."),
     *   )
     * )
     *  
     * @Security(name="Bearer")
     */
    public function createCaptainFinancialSystemDetail(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainFinancialSystemDetailRequest::class, (object)$data);

        $request->setCaptain($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->captainFinancialSystemDetailService->createCaptainFinancialSystemDetail($request);

        if($result === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE);
        }

        return $this->response($result, self::CREATE);
    }
}
