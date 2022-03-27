<?php

namespace App\Controller\Admin\AdminProfile;

use App\AutoMapping;
use App\Constant\Admin\AdminProfileConstant;
use App\Controller\BaseController;
use App\Request\Admin\AdminProfile\AdminProfileRequest;
use App\Request\Admin\AdminProfile\AdminProfileStatusUpdateRequest;
use App\Request\Admin\AdminProfile\AdminProfileUpdateBySuperAdminRequest;
use App\Request\Admin\AdminProfile\FilterAdminProfilesRequest;
use App\Service\Admin\AdminProfile\AdminProfileService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use OpenApi\Annotations as OA;

/**
 * @Route("v1/admin/profile/")
 */
class AdminProfileController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminProfileService $adminProfileService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminProfileService $adminProfileService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminProfileService = $adminProfileService;
    }

    /**
     * Get admin profile for signed-in admin.
     * @Route("profile", name="getAdminProfileBySignedInAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin")
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
     *      description="Returns the admin's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="name"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="object", property="createdAt"),
     *                  @OA\Property(type="object", property="updatedAt"),
     *                  @OA\Property(type="object", property="images",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL")
     *                  ),
     *                  @OA\Property(type="boolean", property="status")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAdminProfileByAdminUserId(): JsonResponse
    {
        $response = $this->adminProfileService->getAdminProfileByAdminUserId($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * Update admin profile by signed-in admin, or by super admin
     * @Route("profile", name="updateAdminProfileBySignedInAdminOrBySuperAdmin", methods={"PUT"})
     * @IsGranted("ROLE_SUPER_USER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create new admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="name"),
     *          @OA\Property(type="string", property="phone"),
     *          @OA\Property(type="array", property="images",
     *              @OA\Items(
     *                  @OA\Property(type="string", property="image")
     *              )
     *          )
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new admin's role and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="name"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="object", property="createdAt"),
     *              @OA\Property(type="object", property="updatedAt"),
     *              @OA\Property(type="object", property="image",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="boolean", property="status")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateAdminProfile(Request $request): JsonResponse
    {
        $response = [];

        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminProfileRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        if ($this->isGranted('ROLE_SUPER_ADMIN')) {
            $response = $this->adminProfileService->updateAdminProfileBySuperAdmin($request);

        } elseif ($this->isGranted('ROLE_ADMIN')) {
            $request->setUser($this->getUser());

            $response = $this->adminProfileService->updateAdminProfile($request);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * Update admin profile status by super admin
     * @Route("profilestatus", name="updateAdminProfileStatusBySuperAdmin", methods={"PUT"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update admin profile state request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="status")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the admin's profile info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="204"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="object", property="user",
     *                  @OA\Property(type="string", property="id"),
     *                  @OA\Property(type="string", property="userId"),
     *                  @OA\Property(type="array", property="roles",
     *                      @OA\Items()
     *                  )
     *              ),
     *              @OA\Property(type="string", property="name"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="object", property="createdAt"),
     *              @OA\Property(type="object", property="updatedAt"),
     *              @OA\Property(type="object", property="image",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="boolean", property="status")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns admin profile does not exist response",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9410"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data", example="adminProfileNotExist")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateAdminProfileStatus(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminProfileStatusUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminProfileService->updateAdminProfileStatus($request);

        if ($response === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return $this->response($response, self::ADMIN_PROFILE_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * Filter admin profiles by super admin
     * @Route("filterprofiles", name="filterAdminProfilesBySuperAdmin", methods={"POST"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="filter request options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="name"),
     *          @OA\Property(type="string", property="phone")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new admin's role and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="object", property="user",
     *                  @OA\Property(type="string", property="id"),
     *                  @OA\Property(type="string", property="userId"),
     *                  @OA\Property(type="array", property="roles",
     *                      @OA\Items()
     *                  )
     *              ),
     *              @OA\Property(type="string", property="name"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="object", property="createdAt"),
     *              @OA\Property(type="object", property="updatedAt"),
     *              @OA\Property(type="object", property="image",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="boolean", property="status")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterAdminProfiles(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, FilterAdminProfilesRequest::class, (object)$data);

        $response = $this->adminProfileService->filterAdminProfiles($request);

        return $this->response($response, self::FETCH);
    }
}
