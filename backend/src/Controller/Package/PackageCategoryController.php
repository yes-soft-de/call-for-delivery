<?php

namespace App\Controller\Package;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Package\PackageCategoryCreateRequest;
use App\Request\Package\PackageCategoryUpdateRequest;
use App\Service\Package\PackageCategoryService;
use Doctrine\ORM\NonUniqueResultException;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Security;

/**
 * Create and fetch package Categories.
 * @Route("v1/packagecategory/")
 */
class PackageCategoryController extends BaseController
{
    public function __construct(SerializerInterface $serializer, private AutoMapping $autoMapping, private ValidatorInterface $validator, private PackageCategoryService $packageCategoryService)
    {
        parent::__construct($serializer);
    }

    /**
     * admin:Create new package category by admin
     * @Route("create", name="createPackageCategory", methods={"POST"})
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
     *      description="new package category",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="name"),
     *          @OA\Property(type="string", property="description"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns new package",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="string", property="name"),
     *            @OA\Property(type="string", property="description"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createPackageCategory(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, PackageCategoryCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->packageCategoryService->createPackageCategory($request);

        return $this->response($result, self::CREATE);
    }

     /**
      * admin:Update package category by admin
      * @Route("update", name="updatePackageCategory", methods={"PUT"})
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
      *      response=201,
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
 
          $result = $this->packageCategoryService->updatePackageCategory($request);
 
          return $this->response($result, self::UPDATE);
      }


    /**
     * Get specific package category.
     * @Route("packagecategory/{id}", name="getPackageCategoryById", methods={"GET"})
     * @param $id
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
    public function getPackageCategoryById($id): JsonResponse
    {
        $result = $this->packageCategoryService->getPackageCategoryById($id);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Get all packages categories and related packages.
     * @Route("packagescategories", name="getAllPackagesCategoriesAndPackages", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     * 
     * @OA\Tag(name="Package Category")
     * 
     * @OA\Response(
     *      response=201,
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
     */
    public function getAllPackagesCategoriesAndPackagesForAdmin(): JsonResponse
    {
        $result = $this->packageCategoryService->getAllPackagesCategoriesAndPackagesForAdmin();

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
     */
    public function getAllPackagesCategoriesAndPackagesForStore(): JsonResponse
    {
        $result = $this->packageCategoryService->getAllPackagesCategoriesAndPackagesForStore();

        return $this->response($result, self::FETCH);
    }
}
