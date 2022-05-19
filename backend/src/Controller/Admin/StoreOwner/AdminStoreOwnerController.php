<?php

namespace App\Controller\Admin\StoreOwner;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Controller\BaseController;
use App\Request\Admin\StoreOwner\StoreOwnerProfileStatusUpdateByAdminRequest;
use App\Request\Admin\StoreOwner\StoreOwnerProfileUpdateByAdminRequest;
use App\Service\Admin\StoreOwner\AdminStoreOwnerService;
use Nelmio\ApiDocBundle\Annotation\Model;
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
 * @Route("v1/admin/storeowner/")
 */
class AdminStoreOwnerController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminStoreOwnerService $adminStoreOwnerService;

    public function __construct(AutoMapping $autoMapping, ValidatorInterface $validator, SerializerInterface $serializer, AdminStoreOwnerService $adminStoreOwnerService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminStoreOwnerService = $adminStoreOwnerService;
    }

    /**
     * admin: fetch store owner profiles by id.
     * @Route("storeownerprofilebyidforadmin/{storeOwnerProfileId}", name="fetchStoreOwnerProfileByIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $storeOwnerProfileId
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin Store Owner")
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
     *      description="Returns store owner profile which corresponding with the passed id",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\StoreOwner\StoreOwnerProfileByIdGetByAdminResponse")
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOwnerProfileByIdForAdmin(int $storeOwnerProfileId): JsonResponse
    {
        $response = $this->adminStoreOwnerService->getStoreOwnerProfileByIdForAdmin($storeOwnerProfileId);

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Fetch store owner profiles by status.
     * @Route("storeownerprofilesbystatusforadmin/{storeOwnerProfileStatus}", name="fetchStoreOwnerProfileByStatusForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param string $storeOwnerProfileStatus
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin Store Owner")
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
     *      description="Returns store owners' profiles which corresponding with the passed status",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="integer", property="storeOwnerId"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="object", property="images",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="string", property="roomID"),
     *              @OA\Property(type="string", property="city"),
     *              @OA\Property(type="integer", property="storeCategoryId"),
     *              @OA\Property(type="string", property="employeeCount"),
     *              @OA\Property(type="object", property="openingTime"),
     *              @OA\Property(type="object", property="closingTime"),
     *              @OA\Property(type="string", property="status"),
     *              @OA\Property(type="string", property="commission"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOwnersProfilesByStatusForAdmin(string $storeOwnerProfileStatus): JsonResponse
    {
        $response = $this->adminStoreOwnerService->getStoreOwnersProfilesByStatusForAdmin($storeOwnerProfileStatus);

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Update status of the store owner profile by admin.
     * @Route("storeownerprofilestatusbyadmin", name="updateStatusOfExistingStoreOwnerProfileByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin Store Owner")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Store Owner Profile Status request",
     *      @OA\JsonContent(
     *          @OA\Property(type="int", property="id"),
     *          @OA\Property(type="string", property="status")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the store owner's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="integer", property="storeOwnerId"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="object", property="images",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="string", property="roomID"),
     *              @OA\Property(type="string", property="city"),
     *              @OA\Property(type="integer", property="storeCategoryId"),
     *              @OA\Property(type="string", property="employeeCount"),
     *              @OA\Property(type="object", property="openingTime"),
     *              @OA\Property(type="object", property="closingTime"),
     *              @OA\Property(type="string", property="status"),
     *              @OA\Property(type="string", property="commission"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns that store owner profile not exists",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9157"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data", example="store owner profile not exists!")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateStoreOwnerProfileStatusByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerProfileStatusUpdateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if(\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminStoreOwnerService->updateStoreOwnerProfileStatusByAdmin($request);

        if ($response === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return $this->response($response, self::STORE_OWNER_PROFILE_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * admin: Update store owner profile by admin.
     * @Route("updatestoreownerprofilebyadmin", name="updateExistingStoreOwnerProfileByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Admin Store Owner")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Store Owner Profile by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="storeOwnerName"),
     *          @OA\Property(type="string", property="images"),
     *          @OA\Property(type="string", property="phone"),
     *          @OA\Property(type="string", property="openingTime"),
     *          @OA\Property(type="string", property="closingTime"),
     *          @OA\Property(type="string", property="bankName"),
     *          @OA\Property(type="string", property="bankAccountNumber"),
     *          @OA\Property(type="string", property="stcPay"),
     *          @OA\Property(type="string", property="employeeCount"),
     *          @OA\Property(type="number", property="profitMargin")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the store owner's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="integer", property="storeOwnerId"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="object", property="images",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL")
     *              ),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="string", property="roomID"),
     *              @OA\Property(type="string", property="city"),
     *              @OA\Property(type="integer", property="storeCategoryId"),
     *              @OA\Property(type="string", property="employeeCount"),
     *              @OA\Property(type="object", property="openingTime"),
     *              @OA\Property(type="object", property="closingTime"),
     *              @OA\Property(type="string", property="status"),
     *              @OA\Property(type="string", property="commission"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns that store owner profile not exists",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9157"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data", example="store owner profile not exists!")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateStoreOwnerProfileByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerProfileUpdateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminStoreOwnerService->updateStoreOwnerProfileByAdmin($request);

        if ($response === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return $this->response($response, self::STORE_OWNER_PROFILE_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }
}
