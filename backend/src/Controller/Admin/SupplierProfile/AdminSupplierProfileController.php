<?php

namespace App\Controller\Admin\SupplierProfile;

use App\AutoMapping;
use App\Constant\Main\MainErrorConstant;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Controller\BaseController;
use App\Request\Admin\SupplierProfile\SupplierProfileFilterByAdminRequest;
use App\Request\Admin\SupplierProfile\SupplierProfileStatusUpdateByAdminRequest;
use App\Request\Admin\SupplierProfile\SupplierProfileUpdateByAdminRequest;
use App\Service\Admin\SupplierProfile\AdminSupplierProfileService;
use Nelmio\ApiDocBundle\Annotation\Model;
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
 * @Route("v1/admin/supplierprofile/")
 */
class AdminSupplierProfileController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminSupplierProfileService $adminSupplierProfileService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminSupplierProfileService $adminSupplierProfileService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminSupplierProfileService = $adminSupplierProfileService;
    }

    /**
     * Admin: update supplier profile status
     * @Route("supplierprofilestatus", name="updateSupplierProfileStatusByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Supplier Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update supplier profile state request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="boolean", property="status")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the supplier's profile info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="204"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\SupplierProfile\SupplierProfileStatusUpdateByAdminResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns supplier profile does not exist response",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9551"),
     *          @OA\Property(type="string", property="msg", example="supplier profile not exist! Error.")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateSupplierProfileStatusByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SupplierProfileStatusUpdateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminSupplierProfileService->updateSupplierProfileStatusByAdmin($request);

        if ($response === SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUPPLIER_PROFILE_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * Admin: filter suppliers profiles
     * @Route("filtersuppliersprofiles", name="filterSuppliersProfilesByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Supplier Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Filter supplier profile request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="supplierName"),
     *          @OA\Property(type="string", property="phone"),
     *          @OA\Property(type="boolean", property="status"),
     *          @OA\Property(type="integer", property="supplierCategoryId")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the supplier's profile info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="204"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\SupplierProfile\SupplierProfileGetByAdminResponse")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterSupplierProfileByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SupplierProfileFilterByAdminRequest::class, (object)$data);

        $response = $this->adminSupplierProfileService->filterSupplierProfileByAdmin($request);

        return $this->response($response, self::FETCH);
    }

    /**
     * Admin: update supplier profile
     * @Route("supplierprofile", name="updateSupplierProfileByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Supplier Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update supplier profile by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="supplierName"),
     *          @OA\Property(type="string", property="phone"),
     *          @OA\Property(type="array", property="images",
     *              @OA\Items(
     *                  @OA\Property(type="string", property="image")
     *              )
     *          ),
     *          @OA\Property(type="object", property="location"),
     *          @OA\Property(type="string", property="bankName"),
     *          @OA\Property(type="string", property="bankAccountNumber"),
     *          @OA\Property(type="string", property="stcPay"),
     *          @OA\Property(type="array", property="supplierCategories",
     *              @OA\Items(type="integer")
     *          ),
     *          @OA\Property(type="bool", property="allSupplierCategories",
     *              description="takes 'true' when we want to store all supplier categories in supplierCategories field.")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the supplier's profile info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="204"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\SupplierProfile\SupplierProfileStatusUpdateByAdminResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns supplier profile does not exist response",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9551"),
     *          @OA\Property(type="string", property="msg", example="supplier profile not exist! Error.")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateSupplierProfileByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, SupplierProfileUpdateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminSupplierProfileService->updateSupplierProfileByAdmin($request);

        if ($response === SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUPPLIER_PROFILE_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * Admin: get supplier profile by id
     * @Route("supplierprofilebyid/{supplierProfileId}", name="getSupplierProfileByIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $supplierProfileId
     * @return JsonResponse
     *
     * @OA\Tag(name="Supplier Profile")
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
     *      description="Returns the supplier's profile info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="204"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\SupplierProfile\SupplierProfileGetByAdminResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getSupplierProfileBySupplierProfileIdForAdmin(int $supplierProfileId): JsonResponse
    {
        $response = $this->adminSupplierProfileService->getSupplierProfileBySupplierProfileIdForAdmin($supplierProfileId);

        return $this->response($response, self::FETCH);
    }
}
