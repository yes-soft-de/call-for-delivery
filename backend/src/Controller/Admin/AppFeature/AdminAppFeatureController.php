<?php

namespace App\Controller\Admin\AppFeature;

use App\AutoMapping;
use App\Constant\AppFeature\AppFeatureResultConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\Admin\AppFeature\AppFeatureCreateRequest;
use App\Request\Admin\AppFeature\AppFeatureStatusUpdateBySuperAdminRequest;
use App\Service\Admin\AppFeature\AdminAppFeatureService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

/**
 * Create and fetch app features by super admin.
 * @Route("v1/admin/appfeature/")
 */
class AdminAppFeatureController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private AdminAppFeatureService $adminAppFeatureService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * super admin: Create a new app feature by super admin
     * @Route("appfeature", name="createAppFeatureBySuperAdmin", methods={"POST"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="App Feature")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create new app feature by super admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="featureName"),
     *          @OA\Property(type="boolean", property="featureStatus")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns newly created app feature info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               ref=@Model(type="App\Response\Admin\AppFeature\AppFeatureForAdminGetResponse")
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createAppFeatureBySuperAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AppFeatureCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminAppFeatureService->createAppFeatureBySuperAdmin($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * super admin: get all app features by super admin
     * @Route("appfeatures", name="getAllAppFeaturesBySuperAdmin", methods={"GET"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="App Feature")
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
     *      description="Returns all app feature info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\AppFeature\AppFeatureForAdminGetResponse")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllAppFeatures(): JsonResponse
    {
        $result = $this->adminAppFeatureService->getAllAppFeatures();

        return $this->response($result, self::FETCH);
    }

    /**
     * super admin: update existing app feature status
     * @Route("appfeaturestatus", name="updateAppFeatureStatusBySuperAdmin", methods={"PUT"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="App Feature")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update app feature status by super admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="boolean", property="featureStatus")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns newly updated app feature info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               ref=@Model(type="App\Response\Admin\AppFeature\AppFeatureForAdminGetResponse")
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateAppFeatureStatusBySuperAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AppFeatureStatusUpdateBySuperAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminAppFeatureService->updateAppFeatureStatusBySuperAdmin($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: fetch app feature by name for admin
     * @Route("appfeaturebyname/{appFeatureName}", name="fetcherAppFeatureByNameForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param string $appFeatureName
     * @return JsonResponse
     *
     * @OA\Tag(name="App Feature")
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
     *      description="Returns specific app feature by name",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\AppFeature\AppFeatureForAdminGetResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return erorr.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9216 or 9076"),
     *          @OA\Property(type="string", property="msg", description="errorMsg"),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function fetchAppFeatureByNameForAdmin(string $appFeatureName): JsonResponse
    {
        $result = $this->adminAppFeatureService->fetchAppFeatureByNameForAdmin($appFeatureName);

        if ($result === AppFeatureResultConstant::APP_FEATURE_NOT_FOUND_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::APP_FEATURE_NOT_FOUND_CONST);
        }

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: update existing app feature status by admin
     * @Route("appfeaturestatusbyadmin", name="updateAppFeatureStatusByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="App Feature")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update app feature status by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="boolean", property="featureStatus")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns newly updated app feature info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\AppFeature\AppFeatureForAdminGetResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return erorr.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9216 or 9076"),
     *          @OA\Property(type="string", property="msg", description="errorMsg"),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateAppFeatureStatusByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AppFeatureStatusUpdateBySuperAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminAppFeatureService->updateAppFeatureStatusByAdmin($request);

        if ($result === AppFeatureResultConstant::APP_FEATURE_NOT_FOUND_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::APP_FEATURE_NOT_FOUND_CONST);
        }

        return $this->response($result, self::UPDATE);
    }
}
