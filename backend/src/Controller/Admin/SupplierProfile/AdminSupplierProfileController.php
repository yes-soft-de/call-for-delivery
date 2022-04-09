<?php

namespace App\Controller\Admin\SupplierProfile;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Admin\SupplierProfile\SupplierProfileStatusUpdateByAdminRequest;
use App\Service\Admin\SupplierProfile\AdminSupplierProfileService;
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
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="name"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="object", property="createdAt"),
     *              @OA\Property(type="object", property="updatedAt"),
     *              @OA\Property(type="object", property="image",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="boolean", property="status")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns admin profile does not exist response",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9410"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data", example="adminProfileNotExist")
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

//        if ($response === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
//            return $this->response($response, self::ADMIN_PROFILE_NOT_EXIST);
//        }

        return $this->response($response, self::UPDATE);
    }
}
