<?php

namespace App\Controller\Admin\Package;

use App\AutoMapping;
use App\Constant\Package\PackageConstant;
use App\Controller\BaseController;
use App\Request\Admin\Package\PackageCreateRequest;
use App\Request\Admin\Package\PackageUpdateRequest;
use App\Request\Admin\Package\PackageStatusUpdateRequest;
use App\Service\Admin\Package\AdminPackageService;
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
 * Create and fetch packages.
 * @Route("v1/admin/package/")
 */
class AdminPackageController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminPackageService $adminPackageService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminPackageService $adminPackageService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminPackageService = $adminPackageService;
    }

    /**
     * admin:Create new package by admin
     * @Route("package", name="createPackage", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
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
     * @OA\RequestBody(
     *      description="new package",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="name"),
     *          @OA\Property(type="number", property="cost"),
     *          @OA\Property(type="string", property="note"),
     *          @OA\Property(type="integer", property="carCount"),
     *          @OA\Property(type="string", property="city"),
     *          @OA\Property(type="integer", property="orderCount"),
     *          @OA\Property(type="integer", property="expired"),
     *          @OA\Property(type="string", property="status"),
     *          @OA\Property(type="integer", property="packageCategory"),
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
     *            @OA\Property(type="number", property="cost"),
     *            @OA\Property(type="string", property="note"),
     *            @OA\Property(type="integer", property="carCount"),
     *            @OA\Property(type="string", property="city"),
     *            @OA\Property(type="integer", property="orderCount"),
     *            @OA\Property(type="integer", property="expired"),
     *            @OA\Property(type="string", property="status"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createPackage(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, PackageCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminPackageService->createPackage($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin: Update new package by admin
     * @Route("package", name="updatePackage", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
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
     * @OA\RequestBody(
     *      description="package",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="name"),
     *          @OA\Property(type="number", property="cost"),
     *          @OA\Property(type="string", property="note"),
     *          @OA\Property(type="integer", property="carCount"),
     *          @OA\Property(type="string", property="city"),
     *          @OA\Property(type="integer", property="orderCount"),
     *          @OA\Property(type="integer", property="expired"),
     *          @OA\Property(type="string", property="status"),
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
     *            @OA\Property(type="number", property="cost"),
     *            @OA\Property(type="string", property="note"),
     *            @OA\Property(type="integer", property="carCount"),
     *            @OA\Property(type="string", property="city"),
     *            @OA\Property(type="integer", property="orderCount"),
     *            @OA\Property(type="integer", property="expired"),
     *            @OA\Property(type="string", property="status"),
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns new package",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9351"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data", example="package not exist")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updatePackage(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, PackageUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminPackageService->updatePackage($request);

        if($result === PackageConstant::PACKAGE_NOT_EXIST) {
            return $this->response($result, self::PACKAGE_NOT_EXIST);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin:Update new package by admin
     * @Route("packagestatus", name="updatePackageStatus", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
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
     * @OA\RequestBody(
     *      description="update package status",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="status")
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
     *            @OA\Property(type="number", property="cost"),
     *            @OA\Property(type="string", property="note"),
     *            @OA\Property(type="integer", property="carCount"),
     *            @OA\Property(type="string", property="city"),
     *            @OA\Property(type="integer", property="orderCount"),
     *            @OA\Property(type="integer", property="expired"),
     *            @OA\Property(type="string", property="status"),
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns new package",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9351"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data", example="package not exist")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updatePackageStatus(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, PackageStatusUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminPackageService->updatePackageStatus($request);

        if($result === PackageConstant::PACKAGE_NOT_EXIST) {
            return $this->response($result, self::PACKAGE_NOT_EXIST);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin:Get all packages.
     * @Route("packages", name="getAllPackages", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
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
     *      response=200,
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
     *
     * @Security(name="Bearer")
     */
    public function getAllPackages(): JsonResponse
    {
        $result = $this->adminPackageService->getAllPackages();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Get all packages of a specific category id.
     * @Route("packagesbycategoryid/{packageCategoryId}", name="getPackagesByPackageCategoryIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $packageCategoryId
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
     *      description="Returns packages of specific category",
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
    public function getPackagesByCategoryIdForAdmin(int $packageCategoryId): JsonResponse
    {
        $result = $this->adminPackageService->getPackagesByCategoryId($packageCategoryId);

        return $this->response($result, self::FETCH);
    }
}
