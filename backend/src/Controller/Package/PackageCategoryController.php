<?php

namespace App\Controller\Package;

use App\Controller\BaseController;
use App\Service\Package\PackageCategoryService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Security;

/**
 * Create and fetch package Categories.
 * @Route("v1/packagecategory/")
 */
class PackageCategoryController extends BaseController
{
    private PackageCategoryService $packageCategoryService;

    public function __construct(SerializerInterface $serializer, PackageCategoryService $packageCategoryService)
    {
        parent::__construct($serializer);
        $this->packageCategoryService = $packageCategoryService;
    }

    /**
     * Get specific package category.
     * @Route("packagecategory/{id}", name="getPackageCategoryById", methods={"GET"})
     * @param int $id
     * @return JsonResponse
     *
     * @OA\Tag(name="Package Category")
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns package category",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="name"),
     *              @OA\Property(type="string", property="description"),
     *       )
     *    )
     * )
     */
    public function getPackageCategoryById(int $id): JsonResponse
    {
        $result = $this->packageCategoryService->getPackageCategoryById($id);

        return $this->response($result, self::FETCH);
    }

    /**
     * store: Get all packages categories and related packages.
     * @Route("packagescategoriesforstore", name="getAllPackagesCategoriesAndPackagesForStore", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     * 
     * @OA\Tag(name="Package Category")
     * @OA\Response(
     *      response=201,
     *      description="Returns packages",
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
    public function getAllPackagesCategoriesAndPackagesForStore(): JsonResponse
    {
        $result = $this->packageCategoryService->getAllPackagesCategoriesAndPackagesForStore();

        return $this->response($result, self::FETCH);
    }
}
