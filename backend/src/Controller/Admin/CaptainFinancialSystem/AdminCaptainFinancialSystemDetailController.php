<?php

namespace App\Controller\Admin\CaptainFinancialSystem;

use App\Constant\Captain\CaptainConstant;
use App\Controller\BaseController;
use App\Request\Admin\CaptainFinancialSystem\CaptainFinancialSystemDetailCreateByAdminRequest;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailService;
use Nelmio\ApiDocBundle\Annotation\Model;
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
use Symfony\Component\HttpFoundation\Response;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailUpdateRequest;
use App\AutoMapping;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailUpdateByAdminRequest;

/**
 * @Route("v1/admin/captainfinancialsystemdetail/")
 */
class AdminCaptainFinancialSystemDetailController extends BaseController
{
    private AdminCaptainFinancialSystemDetailService $adminCaptainFinancialSystemDetailService;
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;

    public function __construct(SerializerInterface $serializer, AdminCaptainFinancialSystemDetailService $adminCaptainFinancialSystemDetailService, AutoMapping $autoMapping, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->adminCaptainFinancialSystemDetailService = $adminCaptainFinancialSystemDetailService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }

    /**
     * admin: get Balance Detail for specific captain.
     * @Route("captainbalancedetailforcaptainspecific/{captainId}", name="getBalanceDetailForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $captainId
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

    /**
     * admin: Activate/Inactive the financial system chosen by the captain
     * @Route("captainfinancialsystemdetailstatus", name="updateStatusCaptainFinancialSystemDetail", methods={"PUT"})
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
     * @OA\RequestBody(
     *      description="Update Captain Financial System Detail",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="boolean", property="status"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns Captain Financial System Detail",
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
     * @Security(name="Bearer")
     */
    public function updateStatusCaptainFinancialSystemDetail(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCaptainFinancialSystemDetailUpdateRequest::class, (object)$data);

        $request->setUpdatedBy($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainFinancialSystemDetailService->updateStatusCaptainFinancialSystemDetail($request);

        return $this->response($result, self::UPDATE);
    }
    /**
     * admin: update the financial system chosen by the captain
     * @Route("captainfinancialsystemdetailupdate", name="captainFinancialSystemDetailUpdate", methods={"PUT"})
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
     * @OA\RequestBody(
     *      description="Update Captain Financial System Detail",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="boolean", property="status"),
     *          @OA\Property(type="integer", property="captainFinancialSystemType"),
     *          @OA\Property(type="integer", property="captainFinancialSystemId"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns Captain Financial System Detail",
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
     * @Security(name="Bearer")
     */
    public function captainFinancialSystemDetailUpdate(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCaptainFinancialSystemDetailUpdateByAdminRequest::class, (object)$data);

        $request->setUpdatedBy($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainFinancialSystemDetailService->captainFinancialSystemDetailUpdate($request);

        if($result === CaptainFinancialSystem::NOT_UPDATE_FINANCIAL_SYSTEM_ACTIVE) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::NOT_UPDATE_FINANCIAL_SYSTEM_ACTIVE);
        }

        return $this->response($result, self::UPDATE);
    }

    // Following API replaced by command
//    /**
//     * @Route("calculateordersthatnotbelongtoanyfinancialdues", name="calculateOrdersThatNotBelongToAnyFinancialDues", methods={"GET"})
//     * @IsGranted("ROLE_ADMIN")
//     * @return JsonResponse
//     *
//     */
//    public function calculateOrdersThatNotBelongToAnyFinancialDues(): JsonResponse
//    {
//        $result = $this->adminCaptainFinancialSystemDetailService->calculateOrdersThatNotBelongToAnyFinancialDues();
//
//        return $this->response($result, self::FETCH);
//    }

    /**
     * admin: create Captain Financial System Detail By admin on behalf of the captain
     * @Route("captainfinancialsystemdetailbyadmin", name="createCaptainFinancialSystemDetailByAdmin", methods={"POST"})
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
     * @OA\RequestBody(
     *      description="new Captain Financial System Detail",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="captainFinancialSystemType"),
     *          @OA\Property(type="integer", property="captainFinancialSystemId"),
     *          @OA\Property(type="integer", property="captain", description="Captain profile id")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns Captain Financial System Detail",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\CaptainFinancialSystem\CaptainFinancialSystemDetailCreateByAdminResponse")
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9101"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9601"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createCaptainFinancialSystemDetailByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainFinancialSystemDetailCreateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainFinancialSystemDetailService->createCaptainFinancialSystemDetailByAdmin($request);

        if ($result === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_PROFILE_NOT_EXIST);

        } elseif ($result === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE);
        }

        return $this->response($result, self::CREATE);
    }
}
