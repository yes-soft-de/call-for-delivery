<?php

namespace App\Controller\StoreOwner;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Controller\BaseController;
use App\Request\StoreOwner\StoreOwnerCompleteAccountStatusUpdateRequest;
use App\Request\StoreOwner\StoreOwnerProfileStatusUpdateByAdminRequest;
use App\Request\StoreOwner\StoreOwnerProfileUpdateByAdminRequest;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use App\Service\StoreOwner\StoreOwnerProfileService;
use Symfony\Component\HttpFoundation\Request;
use stdClass;
use App\Request\User\UserRegisterRequest;
use Symfony\Component\HttpFoundation\Response;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Nelmio\ApiDocBundle\Annotation\Security;
use App\Request\StoreOwner\StoreOwnerProfileUpdateRequest;

/**
 * @Route("v1/store/")
 */
class StoreOwnerProfileController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private StoreOwnerProfileService $storeOwnerProfileService;

    public function __construct( AutoMapping $autoMapping, SerializerInterface $serializer, ValidatorInterface $validator, StoreOwnerProfileService $storeOwnerProfileService)
    {
        parent::__construct($serializer);
        $this->storeOwnerProfileService = $storeOwnerProfileService;
        $this->validator = $validator;
        $this->autoMapping = $autoMapping;
    }

    /**
     * Create new store.
     * @Route("storeownerregister", name="storeOwnerRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Profile")
     *
     * @OA\RequestBody(
     *      description="Create new store owner",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userName"),
     *          @OA\Property(type="string", property="userId"),
     *          @OA\Property(type="string", property="password"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new store owner's role and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="array", property="roles",
     *                      @OA\Items(example="user")),
     *                  @OA\Property(type="object", property="createdAt")
     *          )
     *      )
     * )
     */
    public function storeOwnerRegister(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        
        $request = $this->autoMapping->map(stdClass::class, UserRegisterRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->storeOwnerRegister($request);

        if($response->found === UserReturnResultConstant::YES_RESULT) {
            return $this->response($response, self::ERROR_USER_FOUND);
        }

        return $this->response($response, self::CREATE);
    }

    /**
     * store: Update store profile.
     * @Route("storeowner", name="storeOwnerProfileUpdate", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Store Owner Profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="storeOwnerName"),
     *          @OA\Property(type="string", property="images"),
     *          @OA\Property(type="string", property="phone"),
     *          @OA\Property(type="string", property="city"),
     *          @OA\Property(type="string", property="openingTime"),
     *          @OA\Property(type="string", property="closingTime"),
     *          @OA\Property(type="string", property="bankName"),
     *          @OA\Property(type="string", property="bankAccountNumber"),
     *          @OA\Property(type="string", property="stcPay"),
     *          @OA\Property(type="integer", property="employeeCount"),
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
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="string", property="image"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="integer", property="storeCategoryId"),
     *              @OA\Property(type="boolean", property="privateOrders"),
     *              @OA\Property(type="boolean", property="hasProducts"),
     *              @OA\Property(type="string", property="branchName"),
     *              @OA\Property(type="string", property="openingTime"),
     *              @OA\Property(type="string", property="closingTime"),
     *              @OA\Property(type="object", property="location",
     *                   @OA\Property(type="string", property="lat"),
     *                   @OA\Property(type="string", property="lon")
     *
     *          )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function storeOwnerProfileUpdate(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerProfileUpdateRequest::class, (object)$data);
        $request->setUserID($this->getUserId());

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->storeOwnerProfileUpdate($request);
        return $this->response($response, self::UPDATE);
    }

    /**
     * store: Get store owner profile.
     * @Route("storeownerprofilebyid", name="getStoreOwnerProfile", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Owner Profile")
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
     *      description="Returns the signed-in store owner's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="object", property="images",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL"),
     *              ),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="string", property="city"),
     *              @OA\Property(type="integer", property="storeCategoryId"),
     *              @OA\Property(type="object", property="openingTime"),
     *              @OA\Property(type="object", property="closingTime"),
     *              @OA\Property(type="string", property="status"),
     *              @OA\Property(type="number", property="commission"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *              @OA\Property(type="string", property="employeeCount"),
     *               @OA\Property(type="string", property="roomId"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOwnerProfile(): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getStoreOwnerProfile($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * store: Get complete account status of store owner profile.
     * @Route("storeownerprofilecompleteaccountstatus", name="getCompleteAccountStatusOfStoreOwnerProfile", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Profile")
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
     *      description="Returns the completeAccountStatus of store owner's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="completeAccountStatus")
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns the completeAccountStatus of store owner's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9158 | 9159 | 9160"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="completeAccountStatus")
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCompleteAccountStatusByStoreOwnerId(): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getCompleteAccountStatusByStoreOwnerId($this->getUserId());

        if($response->completeAccountStatus) {
            if($response->completeAccountStatus === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED) {
                return $this->response($response, self::STORE_OWNER_PROFILE_CREATED);

            } elseif ($response->completeAccountStatus === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_SUBSCRIPTION_CREATED) {
                return $this->response($response, self::STORE_OWNER_SUBSCRIPTION_CREATED);

            } elseif ($response->completeAccountStatus === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_BRANCH_CREATED) {
                return $this->response($response, self::STORE_OWNER_BRANCH_CREATED);

            }
        }

        return $this->response($response, self::FETCH);
    }

    /**
     * store: Update complete account status of the store owner profile.
     * @Route("storeownerprofilecompleteaccountstatus", name="updateCompleteAccountStatusOfStoreOwnerProfile", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Store Owner Profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="completeAccountStatus")
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
     *              @OA\Property(type="string", property="completeAccountStatus")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns the store owner's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9221"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="completeAccountStatus")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function storeOwnerProfileCompleteAccountStatusUpdate(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerCompleteAccountStatusUpdateRequest::class, (object)$data);

        $request->setStoreOwnerId($this->getUserId());

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->storeOwnerProfileCompleteAccountStatusUpdate($request);

        if($response === StoreProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS) {
            return $this->response($response, self::WRONG_COMPLETE_ACCOUNT_STATUS);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * admin: Get store owner profiles by status.
     * @Route("storeownersprofilesbystatusforadmin/{storeOwnerProfileStatus}", name="getStoreOwnerProfilesByStatusForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $storeOwnerProfileStatus
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Profile")
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
    public function getStoreOwnersProfilesByStatusForAdmin($storeOwnerProfileStatus): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getStoreOwnersProfilesByStatusForAdmin($storeOwnerProfileStatus);

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Get store owner profiles by id.
     * @Route("storeownersprofilesbyidforadmin/{storeOwnerProfileId}", name="getStoreOwnerProfileByIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param $storeOwnerProfileId
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Profile")
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
     *      description="Returns store owners' profiles which corresponding with the passed id",
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
     *              @OA\Property(type="number", property="commission"),
     *              @OA\Property(type="string", property="bankName"),
     *              @OA\Property(type="string", property="bankAccountNumber"),
     *              @OA\Property(type="string", property="stcPay"),
     *              @OA\Property(type="array", property="branches",
     *                  @OA\Items(
     *                      @OA\Property(type="integer", property="branchId"),
     *                      @OA\Property(type="object", property="location"),
     *                      @OA\Property(type="string", property="name"),
     *                      @OA\Property(type="string", property="city"),
     *                      @OA\Property(type="boolean", property="isActive"),
     *                  ),
     *               @OA\Property(type="string", property="roomId"),
     *              ),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getStoreOwnerProfileByIdForAdmin($storeOwnerProfileId): JsonResponse
    {
        $response = $this->storeOwnerProfileService->getStoreOwnerProfileByIdForAdmin($storeOwnerProfileId);

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Update status of the store owner profile.
     * @Route("storeownerprofilestatus", name="updateStoreOwnerProfileStatusByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Store Owner Profile Status",
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
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="completeAccountStatus")
     *          )
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
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->updateStoreOwnerProfileStatusByAdmin($request);

        if($response === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return $this->response($response, self::STORE_OWNER_PROFILE_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * admin: Update store owner profile.
     * @Route("storeownerprofilebyadmin", name="updateStoreOwnerProfileByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Store Owner Profile",
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
     *          @OA\Property(type="number", property="commission")
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
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="completeAccountStatus")
     *          )
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
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->updateStoreOwnerProfileByAdmin($request);

        if($response === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return $this->response($response, self::STORE_OWNER_PROFILE_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }
}
