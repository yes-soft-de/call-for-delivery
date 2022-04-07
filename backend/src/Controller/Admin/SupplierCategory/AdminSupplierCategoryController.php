<?php

namespace App\Controller\Admin\SupplierCategory;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Admin\SupplierCategory\SupplierCategoryCreateByAdminRequest;
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
}
