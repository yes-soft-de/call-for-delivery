<?php

namespace App\Controller\Admin\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Eraser\EraserResultConstant;
use App\Controller\BaseController;
use App\Request\Admin\Captain\CaptainProfileStatusUpdateByAdminRequest;
use App\Request\Admin\Captain\CaptainProfileUpdateByAdminRequest;
use App\Request\Admin\Captain\DeleteCaptainAccountAndProfileByAdminRequest;
use App\Service\Admin\Captain\AdminCaptainService;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use App\Constant\Main\MainErrorConstant;

/**
 * @Route("v1/admin/captain/")
 */
class AdminCaptainController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminCaptainService $adminCaptainService;

    public function __construct( AutoMapping $autoMapping, SerializerInterface $serializer, ValidatorInterface $validator, AdminCaptainService $adminCaptainService)
    {
        parent::__construct($serializer);
        $this->adminCaptainService = $adminCaptainService;
        $this->validator = $validator;
        $this->autoMapping = $autoMapping;
    }

    /**
     * admin: Get captains' profiles by status.
     * @Route("captainsprofilesbystatus/{captainProfileStatus}", name="getCaptainProfilesByStatusForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param string $captainProfileStatus
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Returns captains' profiles which corresponding with the passed status",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\Captain\CaptainProfileGetForAdminResponse")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCaptainsProfilesByStatusForAdmin(string $captainProfileStatus): JsonResponse
    {
        $response = $this->adminCaptainService->getCaptainsProfilesByStatusForAdmin($captainProfileStatus);

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Get captain profiles by id.
     * @Route("captainprofilebyid/{captainProfileId}", name="getCaptainProfileByIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $captainProfileId
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Returns captain profile which corresponding with the passed id",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Captain\CaptainProfileGetForAdminResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCaptainProfileByIdForAdmin(int $captainProfileId): JsonResponse
    {
        $response = $this->adminCaptainService->getCaptainProfileByIdForAdmin($captainProfileId);

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Update status of the captain profile.
     * @Route("captainprofilestatus", name="updateCaptainProfileStatusByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Captain Profile Status",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="status")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the captain's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Captain\CaptainProfileGetForAdminResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns that captain profile not exists",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9101"),
     *          @OA\Property(type="string", property="msg", description="captain profile not exist! Error."),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateCaptainProfileStatusByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainProfileStatusUpdateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminCaptainService->updateCaptainProfileStatusByAdmin($request);

        if ($response === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_PROFILE_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * admin: Update captain profile.
     * @Route("captainprofile", name="updateCaptainProfileByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Captain Profile Status",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="captainName"),
     *          @OA\Property(type="object", property="location"),
     *          @OA\Property(type="string", property="age"),
     *          @OA\Property(type="string", property="car"),
     *          @OA\Property(type="number", property="salary"),
     *          @OA\Property(type="number", property="bounce"),
     *          @OA\Property(type="string", property="phone"),
     *          @OA\Property(type="string", property="bankName"),
     *          @OA\Property(type="string", property="bankAccountNumber"),
     *          @OA\Property(type="string", property="stcPay"),
     *          @OA\Property(type="string", property="images"),
     *          @OA\Property(type="boolean", property="isOnline"),
     *          @OA\Property(type="string", property="mechanicLicense"),
     *          @OA\Property(type="string", property="drivingLicence"),
     *          @OA\Property(type="string", property="identity"),
     *          @OA\Property(type="string", property="address")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the captain's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Captain\CaptainProfileGetForAdminResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns that captain profile not exists",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9101"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data", example="captain profile not exist!")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateCaptainProfileByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainProfileUpdateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminCaptainService->updateCaptainProfileByAdmin($request);

        if ($response === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return $this->response($response, self::CAPTAIN_PROFILE_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }
    
    /**
     * admin: Get ready captains and the count of their current orders.
     * @Route("getreadycaptainsandcountoftheircurrentorders", name="getReadyCaptainsAndCountOfTheirCurrentOrders", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Returns ready captains and the count of their current orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="integer", property="captainId"),
     *              @OA\Property(type="string", property="captainName"),
     *              @OA\Property(type="integer", property="countOngoingOrders"),
     *              @OA\Property(type="object", property="images"),
     *          )
     *      )
     * ) 
     * 
     * @Security(name="Bearer")
     */
    public function getReadyCaptainsAndCountOfTheirCurrentOrders(): JsonResponse
    {
        $response = $this->adminCaptainService->getReadyCaptainsAndCountOfTheirCurrentOrders();

        return $this->response($response, self::FETCH);
    }

    /**
     * Admin: delete captain account and profile by admin
     * @Route("deletecaptainprofilebyadmin", name="deleteCaptainAccountAndProfileByAdmin", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     *
     * @OA\Tag(name="Captain Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="delete request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="captainId")
     *      )
     * )
     *
     * @OA\Response(
     *      response=401,
     *      description="Returns deleted user info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Eraser\DeleteCaptainAccountAndProfileBySuperAdminResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteCaptainAccountAndProfileByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, DeleteCaptainAccountAndProfileByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminCaptainService->deleteCaptainAccountAndProfileByAdmin($request);

        if ($response === EraserResultConstant::CAN_NOT_DELETE_USER_HAS_CASH_ORDER_PAYMENTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAN_NOT_DELETE_USER_HAS_CASH_ORDER_PAYMENTS);
        }

        if ($response === EraserResultConstant::CAN_NOT_DELETE_USER_HAS_ORDERS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAN_NOT_DELETE_USER_HAS_ORDERS);
        }

        if ($response === EraserResultConstant::CAN_NOT_DELETE_USER_HAS_FINANCIAL_DUES) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAN_NOT_DELETE_USER_HAS_FINANCIAL_DUES);
        }

        if ($response === EraserResultConstant::CAN_NOT_DELETE_USER_HAS_PAYMENTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAN_NOT_DELETE_USER_HAS_PAYMENTS);
        }

        if ($response === EraserResultConstant::CAN_NOT_DELETE_USER_HAS_PAYMENTS_TO_COMPANY) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAN_NOT_DELETE_USER_HAS_PAYMENTS_TO_COMPANY);
        }

        return $this->response($response, self::DELETE);
    }
}
