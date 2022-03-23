<?php

namespace App\Controller\Admin\Package;

use App\AutoMapping;
use App\Constant\Package\PackageCategoryConstant;
use App\Controller\BaseController;
use App\Request\Admin\Package\PackageCategoryCreateByAdminRequest;
use App\Request\Admin\Package\PackageCategoryUpdateRequest;
use App\Service\Admin\Package\AdminPackageCategoryService;
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
 * Create and fetch package Categories.
 * @Route("v1/admin/packagecategory/")
 */
class AdminPackageCategoryController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminPackageCategoryService $adminPackageCategoryService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminPackageCategoryService $adminPackageCategoryService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminPackageCategoryService = $adminPackageCategoryService;
    }

    /**
     * @Route("packagecategory", name="createPackageCategoryByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Package Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="new package category create by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="name"),
     *          @OA\Property(type="string", property="description")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new created package category info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="string", property="name"),
     *            @OA\Property(type="string", property="description")
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createPackageCategory(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, PackageCategoryCreateByAdminRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminPackageCategoryService->createPackageCategoryByAdmin($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin:Update package category by admin
     * @Route("category", name="updatePackageCategory", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Package Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="package",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="name"),
     *          @OA\Property(type="string", property="description")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns new package",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="string", property="name"),
     *            @OA\Property(type="string", property="description")
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updatePackageCategory(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, PackageCategoryUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminPackageCategoryService->updatePackageCategory($request);

        if($result === PackageCategoryConstant::PACKAGE_CATEGORY_NOT_EXIST) {
            return $this->response($result, self::PACKAGE_NOT_EXIST);

        } else {
            return $this->response($result, self::UPDATE);
        }
    }

    /**
     * admin: Get all packages categories and related packages.
     * @Route("categories", name="getAllPackagesCategoriesAndPackages", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Package Category")
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
     *      description="Returns categories and packages ",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *           @OA\Items(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="name"),
     *              @OA\Property(type="string", property="description"),
     *              @OA\Property(type="array", property="packages",
     *                  @OA\Items(
     *                      @OA\Property(type="string", property="name"),
     *                      @OA\Property(type="number", property="cost"),
     *                      @OA\Property(type="string", property="note"),
     *                      @OA\Property(type="integer", property="carCount"),
     *                      @OA\Property(type="string", property="city"),
     *                      @OA\Property(type="integer", property="orderCount"),
     *                      @OA\Property(type="string", property="status"),
     *                  )
     *              )
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllPackagesCategories(): JsonResponse
    {
        $result = $this->adminPackageCategoryService->getAllPackagesCategories();

        return $this->response($result, self::FETCH);
    }
}
