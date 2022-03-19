<?php

namespace App\Controller\Admin\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Controller\BaseController;
use App\Request\Admin\Captain\CaptainProfileStatusUpdateByAdminRequest;
use App\Request\Admin\Captain\CaptainProfileUpdateByAdminRequest;
use App\Service\Admin\Captain\AdminCaptainService;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

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
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="captainName"),
     *                  @OA\Property(type="object", property="location"),
     *                  @OA\Property(type="string", property="age"),
     *                  @OA\Property(type="string", property="car"),
     *                  @OA\Property(type="number", property="salary"),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="number", property="bounce"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="bankName"),
     *                  @OA\Property(type="string", property="bankAccountNumber"),
     *                  @OA\Property(type="string", property="stcPay"),
     *                  @OA\Property(type="object", property="images",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL")
     *                  ),
     *                  @OA\Property(type="boolean", property="isOnline"),
     *                  @OA\Property(type="object", property="mechanicLicense",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL")
     *                  ),
     *                  @OA\Property(type="object", property="identity",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL")
     *                  ),
     *                  @OA\Property(type="object", property="drivingLicence",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL")
     *                  ),
     *                  @OA\Property(type="string", property="roomId")
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
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="captainName"),
     *              @OA\Property(type="object", property="location"),
     *              @OA\Property(type="string", property="age"),
     *              @OA\Property(type="string", property="car"),
     *              @OA\Property(type="number", property="salary"),
     *              @OA\Property(type="string", property="status"),
     *              @OA\Property(type="number", property="bounce"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *              @OA\Property(type="object", property="images",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="boolean", property="isOnline"),
     *              @OA\Property(type="object", property="mechanicLicense",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="object", property="identity",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="object", property="drivingLicence",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="string", property="roomId")
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
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="captainName"),
     *              @OA\Property(type="object", property="location"),
     *              @OA\Property(type="string", property="age"),
     *              @OA\Property(type="string", property="car"),
     *              @OA\Property(type="number", property="salary"),
     *              @OA\Property(type="string", property="status"),
     *              @OA\Property(type="number", property="bounce"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *              @OA\Property(type="string", property="images"),
     *              @OA\Property(type="boolean", property="isOnline"),
     *              @OA\Property(type="string", property="mechanicLicense"),
     *              @OA\Property(type="string", property="identity"),
     *              @OA\Property(type="string", property="roomId")
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
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data", example="captain profile not exist!")
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
            return $this->response($response, self::CAPTAIN_PROFILE_NOT_EXIST);
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
     *          @OA\Property(type="string", property="identity")
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
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="captainName"),
     *              @OA\Property(type="object", property="location"),
     *              @OA\Property(type="string", property="age"),
     *              @OA\Property(type="string", property="car"),
     *              @OA\Property(type="number", property="salary"),
     *              @OA\Property(type="string", property="status"),
     *              @OA\Property(type="number", property="bounce"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *              @OA\Property(type="string", property="images"),
     *              @OA\Property(type="boolean", property="isOnline"),
     *              @OA\Property(type="string", property="mechanicLicense"),
     *              @OA\Property(type="string", property="identity"),
     *              @OA\Property(type="string", property="drivingLicence"),
     *              @OA\Property(type="string", property="roomId")
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
}
