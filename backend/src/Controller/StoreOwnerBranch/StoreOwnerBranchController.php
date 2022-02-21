<?php

namespace App\Controller\StoreOwnerBranch;

use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Controller\BaseController;
use App\AutoMapping;
use App\Request\StoreOwnerBranch\StoreOwnerBranchCreateRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchUpdateRequest;
use App\Request\StoreOwnerBranch\StoreOwnerBranchDeleteRequest;
use App\Request\StoreOwnerBranch\StoreOwnerMultipleBranchesCreateRequest;
use App\Service\StoreOwnerBranch\StoreOwnerBranchService;
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
 * @Route("v1/StoreOwnerBranch/")
 */
class StoreOwnerBranchController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $storeOwnerBranchService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, StoreOwnerBranchService $storeOwnerBranchService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->storeOwnerBranchService = $storeOwnerBranchService;
    }
    
    /**
     * store: create new branch
     * @Route("branch", name="createBranch", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="new branch",
     *      @OA\JsonContent(
     *          @OA\Property(type="object", property="location",
     *              @OA\Property(type="number", property="lat"),
     *              @OA\Property(type="number", property="lon"),
     *              ),
     *          @OA\Property(type="string", property="name"),
     *          @OA\Property(type="string", property="city"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns new branch",
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
     * @Security(name="Bearer")
     */
    public function createBranch(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerBranchCreateRequest::class, (object)$data);
        $request->setStoreOwner($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->storeOwnerBranchService->createBranch($request);
           
        return $this->response($result, self::CREATE);
    }

    /**
     * store: create new multiple branches.
     * @Route("multiplebranches", name="createMultipleBranches", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="create multiple branches at once by passing them within the branch field",
     *      @OA\JsonContent(
     *          @OA\Property(type="object", property="branches",
     *              @OA\Property(type="object", property="location",
     *                  @OA\Property(type="number", property="lat"),
     *                  @OA\Property(type="number", property="lon"),
     *              ),
     *              @OA\Property(type="string", property="name"),
     *              @OA\Property(type="string", property="city")
     *          )
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
    public function createMultipleBranches(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerMultipleBranchesCreateRequest::class, (object)$data);

        $request->setStoreOwner($this->getUserId());

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->storeOwnerBranchService->createMultipleBranches($request);

        return $this->response($result, self::CREATE);
    }

    /**
     *  store: update branch
     * @Route("branch", name="updateBranch", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="branch",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="object", property="location",
     *              @OA\Property(type="number", property="lat"),
     *              @OA\Property(type="number", property="lon"),
     *              ),
     *          @OA\Property(type="string", property="name"),
     *          @OA\Property(type="string", property="city"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns branch",
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
     * @Security(name="Bearer")
     */
    public function updateBranch(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, StoreOwnerBranchUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->storeOwnerBranchService->updateBranch($request);
        if($result === StoreOwnerBranch::BRANCH_NOT_FOUND ) {

            return $this->response($result, self::ERROR);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * store:Delete branch
     * @Route("deletebranch", name="deleteBranch", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
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
     *      description="branch",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="object", property="isActive"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns branch",
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
     *      response="default",
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
    public function deletebranch(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, StoreOwnerBranchDeleteRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->storeOwnerBranchService->deletebranch($request);
        if($result === StoreOwnerBranch::BRANCH_NOT_FOUND ) {

            return $this->response($result, self::ERROR);
        }

            return $this->response($result, self::UPDATE);
    }

    /**
     * store:Get all branches
     * @Route("branches", name="getAllBranches", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
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
     * @OA\Response(
     *      response=200,
     *      description="Returns branches",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *            @OA\Items(
     *                @OA\Property(type="integer", property="id"),
     *                @OA\Property(type="object", property="location",
     *                    @OA\Property(type="number", property="lat"),
     *                    @OA\Property(type="number", property="lon"),  
     *                  ),
     *                @OA\Property(type="string", property="name"),
     *                @OA\Property(type="boolean", property="isActive"),
     *                @OA\Property(type="string", property="city"),
     *              ),
     *           )
     *      )
     *  )
     *
     * @Security(name="Bearer")
     */
    public function getAllBranches(): JsonResponse
    {
        $result = $this->storeOwnerBranchService->getAllBranches($this->getUserId());

        return $this->response($result, self::FETCH);
    }

    /**
     * store:Get specific branch
     * @Route("branch/{id}", name="getBranchById", methods={"GET"})
     * @param $id
     * @return JsonResponse
     *
     * @OA\Tag(name="Branch")
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns branch",
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
     *                @OA\Property(type="string", property="city"),
     *           )
     *      )
     *  )
     *
     */
    public function getBranchById($id): JsonResponse
    {
        $result = $this->storeOwnerBranchService->getBranchById($id);

        return $this->response($result, self::FETCH);
    }
}
