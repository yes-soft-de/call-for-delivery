<?php

namespace App\Controller\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Controller\BaseController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use App\Service\Captain\CaptainService;
use Symfony\Component\HttpFoundation\Request;
use stdClass;
use App\Request\User\UserRegisterRequest;
use Symfony\Component\HttpFoundation\Response;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Nelmio\ApiDocBundle\Annotation\Security;
use App\Request\Captain\CaptainProfileUpdateRequest;
use App\Constant\Main\MainErrorConstant;
use App\Request\Captain\CaptainProfileIsOnlineUpdateByCaptainRequest;

/**
 * @Route("v1/captain/")
 */
class CaptainController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private CaptainService $captainProfileService;

    public function __construct( AutoMapping $autoMapping, SerializerInterface $serializer, ValidatorInterface $validator, CaptainService $captainProfileService)
    {
        parent::__construct($serializer);
        $this->captainProfileService = $captainProfileService;
        $this->validator = $validator;
        $this->autoMapping = $autoMapping;
    }

    /**
     * Create new captain.
     * @Route("captainregister", name="captainRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="captain profile")
     *
     * @OA\RequestBody(
     *      description="Create new captain",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userName"),
     *          @OA\Property(type="string", property="userId"),
     *          @OA\Property(type="string", property="password"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new captain's role and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="array", property="roles",
     *                      @OA\Items(example="user")),
     *                  @OA\Property(type="object", property="createdAt")
     *          )
     *      )
     * )
     */
    public function captainRegister(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        
        $request = $this->autoMapping->map(stdClass::class, UserRegisterRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->captainProfileService->captainRegister($request);

        if($response->found === UserReturnResultConstant::YES_RESULT) {
            return $this->response($response, self::ERROR_USER_FOUND);
        }

        return $this->response($response, self::CREATE);
    }

    /**
     * captain: Update captain profile.
     * @Route("captainprofilupdate", name="captainProfileUpdate", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
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
     *      description="Update Store Owner Profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="images"),
     *          @OA\Property(type="string", property="captainName"),
     *          @OA\Property(type="object", property="location"),
     *          @OA\Property(type="string", property="age"),
     *          @OA\Property(type="string", property="car"),
     *          @OA\Property(type="string", property="drivingLicence"),
     *          @OA\Property(type="number", property="salary"),
     *          @OA\Property(type="string", property="status"),
     *          @OA\Property(type="number", property="bounce"),
     *          @OA\Property(type="string", property="phone"),
     *          @OA\Property(type="string", property="bankName"),
     *          @OA\Property(type="string", property="bankAccountNumber"),
     *          @OA\Property(type="string", property="stcPay"),
     *          @OA\Property(type="string", property="mechanicLicense"),
     *          @OA\Property(type="string", property="identity"),
     *          @OA\Property(type="string", property="address"),
     *          @OA\Property(type="string", property="avenue"),
     *          @OA\Property(type="string", property="city")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the store owner's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
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
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function captainProfileUpdate(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainProfileUpdateRequest::class, (object)$data);
        $request->setCaptainId($this->getUserId());

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->captainProfileService->captainProfileUpdate($request);
      
        return $this->response($response, self::UPDATE);
    }

    /**
     * store: Get captain profile.
     * @Route("captainprofilebyid", name="getCaptainProfile", methods={"GET"})
     * @IsGranted("ROLE_CAPTAIN")
     * @return JsonResponse
     * *
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
     *      description="Returns the signed-in captain's profile",
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
     *              @OA\Property(type="object", property="images"),
     *              @OA\Property(type="object", property="mechanicLicense"),
     *              @OA\Property(type="object", property="drivingLicence"),
     *              @OA\Property(type="object", property="identity"),
     *              @OA\Property(type="string", property="address"),
     *              @OA\Property(type="object", property="avenue"),
     *              @OA\Property(type="string", property="city")
     *         )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCaptainProfile(): JsonResponse
    {
        $response = $this->captainProfileService->getCaptainProfile($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * captain: Update field isOnline .
     * @Route("captainprofileupdateisonline", name="updateIsOnline", methods={"PUT"})
     * @IsGranted("ROLE_CAPTAIN")
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
     *      description="Update field isOnline",
     *      @OA\JsonContent(
     *          @OA\Property(type="boolean", property="isOnline")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns online field",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="boolean", property="isOnline"),
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
    public function updateIsOnline(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainProfileIsOnlineUpdateByCaptainRequest::class, (object)$data);
        $request->setCaptainId($this->getUserId());

        $response = $this->captainProfileService->updateIsOnline($request);

        if ($response === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_PROFILE_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }
}
