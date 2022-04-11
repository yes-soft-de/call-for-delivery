<?php

namespace App\Controller\Admin\SupplierCategory;

use App\AutoMapping;
use App\Constant\Main\MainErrorConstant;
use App\Constant\SupplierCategory\SupplierCategoryResultConstant;
use App\Controller\BaseController;
use App\Request\Admin\SupplierCategory\SupplierCategoryCreateByAdminRequest;
use App\Request\Admin\SupplierCategory\SupplierCategoryStatusUpdateByAdminRequest;
use App\Request\Admin\SupplierCategory\SupplierCategoryUpdateByAdminRequest;
use App\Service\Admin\SupplierCategory\AdminSupplierCategoryService;
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
 * @Route("v1/admin/suppliercategory/")
 */
class AdminSupplierCategoryController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminSupplierCategoryService $adminSupplierCategoryService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminSupplierCategoryService $adminSupplierCategoryService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminSupplierCategoryService = $adminSupplierCategoryService;
    }

    /**
     * Admin: create a new supplier category.
     * @Route("suppliercategory", name="createSupplierCategoryByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Supplier Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create new supplier category by admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="name"),
     *          @OA\Property(type="string", property="description"),
     *          @OA\Property(type="boolean", property="status"),
     *          @OA\Property(type="string", property="image")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new supplier category",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="name"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="boolean", property="status")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createSupplierCategoryByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SupplierCategoryCreateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminSupplierCategoryService->createSupplierCategoryByAdmin($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * Admin: update existing supplier category.
     * @Route("suppliercategory", name="updateSupplierCategoryByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Supplier Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create new supplier category by admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="name"),
     *          @OA\Property(type="string", property="description"),
     *          @OA\Property(type="string", property="image")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the updated supplier category",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="name"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="boolean", property="status")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns the updated supplier category",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9550"),
     *          @OA\Property(type="string", property="msg", example="supplier category does not exist Error")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateSupplierCategoryByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SupplierCategoryUpdateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminSupplierCategoryService->updateSupplierCategoryByAdmin($request);

        if ($response === SupplierCategoryResultConstant::SUPPLIER_CATEGORY_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUPPLIER_CATEGORY_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * Admin: update existing supplier category status.
     * @Route("suppliercategorystatus", name="updateSupplierCategoryStatusByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Supplier Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create new supplier category by admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="boolean", property="status")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the updated supplier category",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="name"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="boolean", property="status")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns the updated supplier category",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9550"),
     *          @OA\Property(type="string", property="msg", example="supplier category does not exist Error")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateSupplierCategoryStatusByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SupplierCategoryStatusUpdateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminSupplierCategoryService->updateSupplierCategoryStatusByAdmin($request);

        if ($response === SupplierCategoryResultConstant::SUPPLIER_CATEGORY_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUPPLIER_CATEGORY_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * Admin: fetch all supplier categories.
     * @Route("suppliercategories", name="getAllSupplierCategoriesByAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Supplier Category")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns all existing supplier categories",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="name"),
     *                  @OA\Property(type="string", property="description"),
     *                  @OA\Property(type="boolean", property="status"),
     *                  @OA\Property(type="object", property="image",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  )
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllSupplierCategoriesForAdmin(): JsonResponse
    {
        $response = $this->adminSupplierCategoryService->getAllSupplierCategoriesForAdmin();

        return $this->response($response, self::FETCH);
    }
}
