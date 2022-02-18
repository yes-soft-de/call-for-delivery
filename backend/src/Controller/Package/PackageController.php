<?php

namespace App\Controller\Package;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Package\PackageCreateRequest;
use App\Request\Package\PackageUpdateStateRequest;
use App\Service\Package\PackageService;
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
 * Create and fetch packages.
 * @Route("v1/package/")
 */
class PackageController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $packageService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, PackageService $packageService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->packageService = $packageService;
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

        $result = $this->packageService->createPackage($request);

        return $this->response($result, self::CREATE);
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
    public function getAllPackages(): JsonResponse
    {
        $result = $this->packageService->getAllPackages();

        return $this->response($result, self::FETCH);
    }

    /**
     * Get specific package.
     * @Route("package/{id}", name="getPackageById", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $id
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
     *              @OA\Property(type="string", property="status"),
     *       )
     *    )
     * )
     * @throws NonUniqueResultException
     */
    public function getPackageById($id): JsonResponse
    {
        $result = $this->packageService->getPackageById($id);

        return $this->response($result, self::FETCH);
    }

     /**
      * admin:Update new package by admin
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
      *            @OA\Property(type="string", property="status"),
      *      )
      *   )
      * )
      *
      * @Security(name="Bearer")
      */
     public function updatePackage(Request $request): JsonResponse
     {
         $data = json_decode($request->getContent(), true);

         $request = $this->autoMapping->map(\stdClass::class, PackageUpdateStateRequest::class, (object) $data);

         $violations = $this->validator->validate($request);

         if (\count($violations) > 0) {
             $violationsString = (string) $violations;

             return new JsonResponse($violationsString, Response::HTTP_OK);
         }

         $result = $this->packageService->updatePackage($request);

         return $this->response($result, self::UPDATE);
     }
}
