<?php

namespace App\Controller\SupplierCategory;

use App\Controller\BaseController;
use App\Service\SupplierCategory\SupplierCategoryService;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("v1/suppliercategory/")
 */
class SupplierCategoryController extends BaseController
{
    private SupplierCategoryService $supplierCategoryService;

    public function __construct(SerializerInterface $serializer, SupplierCategoryService $supplierCategoryService)
    {
        parent::__construct($serializer);
        $this->supplierCategoryService = $supplierCategoryService;
    }

    /**
     * Supplier: fetch all active supplier categories.
     * @Route("activesuppliercategories", name="getAllActiveSupplierCategoriesBySupplier", methods={"GET"})
     * @IsGranted("ROLE_SUPPLIER")
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
     *      description="Returns all active supplier categories",
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
    public function getAllActiveSupplierCategories(): JsonResponse
    {
        $response = $this->supplierCategoryService->getAllActiveSupplierCategories();

        return $this->response($response, self::FETCH);
    }
}
