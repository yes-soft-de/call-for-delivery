<?php

namespace App\Controller\Admin\StoreOwnerBranch;

use App\AutoMapping;
use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Controller\BaseController;
use App\Request\Admin\StoreOwnerBranch\StoreOwnerBranchUpdateByAdminRequest;
use App\Request\Admin\StoreOwnerBranch\StoreOwnerMultipleBranchesCreateByAdminRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchDeleteRequest;
use App\Service\Admin\StoreOwnerBranch\AdminStoreOwnerBranchService;
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
 * @Route("v1/admin/storeownerbranch/")
 */
class AdminStoreOwnerBranchController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private AdminStoreOwnerBranchService $adminStoreOwnerBranchService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * store: create new multiple branches by admin
     * @Route("multiplebranches", name="createMultipleBranchesByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin - Store Owner Branch")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create multiple branches at once by passing them within the branch field",
     *      @OA\JsonContent(
     *          @OA\Property(type="object", property="branches",
     *              @OA\Property(type="object", property="location",
     *                  @OA\Property(type="number", property="lat"),
     *                  @OA\Property(type="number", property="lon"),
     *              ),
     *              @OA\Property(type="string", property="name"),
     *              @OA\Property(type="string", property="city")
     *          ),
     *          @OA\Property(type="integer", property="storeOwnerProfileId")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns new branches",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="object", property="location",
     *                      @OA\Property(type="number", property="lat"),
     *                      @OA\Property(type="number", property="lon"),
     *                  ),
     *                  @OA\Property(type="string", property="name"),
     *                  @OA\Property(type="boolean", property="isActive"),
     *                  @OA\Property(type="string", property="city"),
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createMultipleBranchesByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerMultipleBranchesCreateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStoreOwnerBranchService->createMultipleBranchesByAdmin($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin: update an existing branch
     * @Route("branch", name="updateBranchByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Branch")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update branch by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="object", property="location",
     *              @OA\Property(type="number", property="lat"),
     *              @OA\Property(type="number", property="lon"),
     *              ),
     *          @OA\Property(type="string", property="name"),
     *          @OA\Property(type="string", property="city"),
     *          @OA\Property(type="string", property="branchPhone")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns branch with new information",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="object", property="location",
     *                  @OA\Property(type="number", property="lat"),
     *                  @OA\Property(type="number", property="lon"),
     *              ),
     *              @OA\Property(type="string", property="name"),
     *              @OA\Property(type="boolean", property="isActive"),
     *              @OA\Property(type="string", property="city"),
     *              @OA\Property(type="string", property="branchPhone")
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns not found",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9201"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data", example="not found")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateBranchByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, StoreOwnerBranchUpdateByAdminRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStoreOwnerBranchService->updateBranchByAdmin($request);

        if($result === StoreOwnerBranch::BRANCH_NOT_FOUND ) {
            return $this->response($result, self::ERROR);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin :Get branches of a specific store owner
     * @Route("branches/{storeOwnerId}", name="getBranchesByStoreOwnerId", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $storeOwnerId
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin - Store Owner Branch")
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns branches of the store",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                @OA\Property(type="integer", property="id"),
     *                @OA\Property(type="object", property="location",
     *                    @OA\Property(type="number", property="lat"),
     *                    @OA\Property(type="number", property="lon"),
     *                  ),
     *                @OA\Property(type="string", property="name"),
     *                @OA\Property(type="boolean", property="isActive"),
     *                @OA\Property(type="string", property="city")
     *           )
     *      )
     *  )
     *
     */
    public function getBranchesByStoreOwnerIdForAdmin($storeOwnerId): JsonResponse
    {
        $result = $this->adminStoreOwnerBranchService->getActiveBranchesByStoreOwnerIdForAdmin($storeOwnerId);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Delete an existing branch
     * @Route("deletebranch", name="deleteBranchByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Branch")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="delete branch by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="integer", property="isActive"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns deleted branch info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="object", property="location",
     *              @OA\Property(type="number", property="lat"),
     *              @OA\Property(type="number", property="lon"),
     *              ),
     *            @OA\Property(type="string", property="name"),
     *            @OA\Property(type="boolean", property="isActive"),
     *            @OA\Property(type="string", property="city"),
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9201"),
     *          @OA\Property(type="string", property="msg", description="error Successfully."),
     *          @OA\Property(type="string", property="Data", description="not found"),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteBranchByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, StoreOwnerBranchDeleteRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStoreOwnerBranchService->deleteBranchByAdmin($request);

        if($result === StoreOwnerBranch::BRANCH_NOT_FOUND ) {
            return $this->response($result, self::ERROR);
        }

        return $this->response($result, self::UPDATE);
    }
}
