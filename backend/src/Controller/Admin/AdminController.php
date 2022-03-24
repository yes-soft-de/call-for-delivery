<?php

namespace App\Controller\Admin;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Admin\AdminProfileUpdateRequest;
use App\Request\Admin\AdminRegisterRequest;
use App\Service\Admin\AdminService;
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
 * @Route("v1/admin/")
 */
class AdminController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminService $adminService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminService $adminService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminService = $adminService;
    }

    /**
     * Create new admin.
     * @Route("createadmin", name="createAdmin", methods={"POST"})
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
     *      description="Create new admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userId"),
     *          @OA\Property(type="string", property="password"),
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
     *                  @OA\Property(type="array", property="roles",
     *                      @OA\Items(example="user")),
     *                  @OA\Property(type="object", property="createDate"),
     *                  @OA\Property(type="string", property="found")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function adminRegister(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminRegisterRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminService->adminRegister($request);

        if (isset($response->found)) {
            return $this->response($response, self::ERROR_USER_FOUND);
        }

        return $this->response($response, self::CREATE);
    }

    /**
     * Get admin profile for signed-in admin.
     * @Route("adminprofile", name="getAdminProfileBySignedInAdmin", methods={"GET"})
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
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL")
     *                  )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAdminProfileByAdminUserId(): JsonResponse
    {
        $response = $this->adminService->getAdminProfileByAdminUserId($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * Update admin profile by signed-in admin
     * @Route("adminprofile", name="updateAdminProfileBySignedInAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
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
     *          @OA\Property(type="string", property="image")
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
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateAdminProfile(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminProfileUpdateRequest::class, (object)$data);

        $request->setAdminUserId($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminService->updateAdminProfile($request);

        return $this->response($response, self::UPDATE);
    }
}
