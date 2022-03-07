<?php

namespace App\Controller\Package;

use App\Controller\BaseController;
use App\Service\Package\PackageService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Security;

/**
 * Fetch packages.
 * @Route("v1/package/")
 */
class PackageController extends BaseController
{
    private PackageService $packageService;

    public function __construct(SerializerInterface $serializer, PackageService $packageService)
    {
        parent::__construct($serializer);
        $this->packageService = $packageService;
    }

    /**
     * Get all active packages.
     * @Route("packagesactive", name="getActivePackages", methods={"GET"})
     * @return JsonResponse
     * 
     * @OA\Tag(name="Package")
     * 
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
     *              @OA\Property(type="number", property="cost"),
     *              @OA\Property(type="string", property="note"),
     *              @OA\Property(type="integer", property="carCount"),
     *              @OA\Property(type="string", property="city"),
     *              @OA\Property(type="integer", property="orderCount"),
     *              @OA\Property(type="integer", property="expired"),
     *              @OA\Property(type="string", property="status"),
     *          )
     *       )
     *    )
     * )
     */
    public function getActivePackages(): JsonResponse
    {
        $result = $this->packageService->getActivePackages();

        return $this->response($result, self::FETCH);
    }

    /**
     * Get specific package.
     * @Route("package/{id}", name="getPackageById", methods={"GET"})
     * @param int $id
     * @return JsonResponse
     *
     * @OA\Tag(name="Package")
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns package",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="name"),
     *              @OA\Property(type="number", property="cost"),
     *              @OA\Property(type="string", property="note"),
     *              @OA\Property(type="integer", property="carCount"),
     *              @OA\Property(type="string", property="city"),
     *              @OA\Property(type="integer", property="orderCount"),
     *              @OA\Property(type="integer", property="expired"),
     *              @OA\Property(type="string", property="status"),
     *       )
     *    )
     * )
     */
    public function getPackageById(int $id): JsonResponse
    {
        $result = $this->packageService->getPackageById($id);

        return $this->response($result, self::FETCH);
    }

    /**
     * Get all packages by category id.
     * @Route("packagesbycategoryid/{packageCategoryId}", name="getAllPackagesByCategoryId", methods={"GET"})
     * @param int $packageCategoryId
     * @return JsonResponse
     *
     * @OA\Tag(name="Package")
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
     *      description="Returns packages",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *           @OA\Items(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="name"),
     *              @OA\Property(type="number", property="cost"),
     *              @OA\Property(type="string", property="note"),
     *              @OA\Property(type="integer", property="carCount"),
     *              @OA\Property(type="string", property="city"),
     *              @OA\Property(type="integer", property="orderCount"),
     *              @OA\Property(type="string", property="status"),
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllPackagesByCategoryId(int $packageCategoryId): JsonResponse
    {
        $result = $this->packageService->getAllPackagesByCategoryId($packageCategoryId);

        return $this->response($result, self::FETCH);
    }
}
