<?php

namespace App\Controller\Main;

use App\AutoMapping;
use App\Constant\Main\MainDeleteConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Constant\User\UserRoleConstant;
use App\Controller\BaseController;
use App\Request\Main\CompleteAccountStatusUpdateRequest;
use App\Request\User\UserFilterRequest;
use App\Request\User\UserPasswordUpdateBySuperAdminRequest;
use App\Service\Main\MainService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Symfony\Component\Validator\Validator\ValidatorInterface;

/**
 * @Route("v1/main/")
 */
class MainController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private MainService $mainService;

    public function __construct(AutoMapping $autoMapping, SerializerInterface $serializer, ValidatorInterface $validator, MainService $mainService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->mainService = $mainService;
    }

    /**
     * check backend health.
     * @Route("checkbackendhealth", name="checkBackendHealth", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Main")
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
     *      description="Returns the new admin's role and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="string", property="result"),
     *                  @OA\Property(type="string", property="userRole")
     *          )
     *      )
     * )
     */
    public function checkBackendHealth(): JsonResponse
    {
        $response = $this->mainService->checkBackendHealth($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * For testing/debugging issues
     *
     * @Route("filterusersbysuperadmin", name="filterUsersBySuperAdmin", methods={"POST"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Main")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="filter users according to the following options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userId"),
     *          @OA\Property(type="string", property="role"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the users info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="userId"),
     *                  @OA\Property(type="array", property="roles",
     *                      @OA\Items()
     *                  )
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterUsersBySuperAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserFilterRequest::class, (object)$data);

        $response = $this->mainService->filterUsersBySuperAdmin($request);

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("userpasswordbysuperadmin", name="updateUserPasswordBySuperAdmin", methods={"PUT"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Main")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update request fields",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="password"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the users info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="userId"),
     *                  @OA\Property(type="array", property="roles",
     *                      @OA\Items()
     *                  )
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateUserPasswordBySuperAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserPasswordUpdateBySuperAdminRequest::class, (object)$data);

        $result = $this->mainService->updateUserPasswordBySuperAdmin($request);

        if($result === UserReturnResultConstant::USER_NOT_FOUND_RESULT) {
            return $this->response($result, self::ERROR_USER_NOT_FOUND);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("deletepackagesandsubscriptions", name="deletePackagesAndSubscriptions", methods={"DELETE"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Main")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=401,
     *      description="Returns deleted message when delete done successfully",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data", example="deleted")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deletePackagesAndSubscriptions(): JsonResponse
    {
        $response = $this->mainService->deletePackagesAndSubscriptions();

        if($response === MainDeleteConstant::DELETED) {
            return $this->response($response, self::DELETE);
        }

        return $this->json($response);
    }

    /**
     * store, captain, and supplies: Get complete account status of the user.
     * @Route("profilecompleteaccountstatus", name="getCompleteAccountStatusOfUser", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Main")
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
     *      description="Returns the completeAccountStatus of the user",
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
     *      description="Returns the completeAccountStatus of the user",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9158 | 9159 | 9160 | 9161 | 9004"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="completeAccountStatus")
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCompleteAccountStatusByUserId(): JsonResponse
    {
        if ($this->isGranted('ROLE_OWNER')) {
            $response = $this->mainService->getCompleteAccountStatusByUserId($this->getUserId(), UserRoleConstant::STORE_OWNER_USER_TYPE);

            if($response->completeAccountStatus) {
                if($response->completeAccountStatus === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED) {
                    return $this->response($response, self::STORE_OWNER_PROFILE_CREATED);

                } elseif ($response->completeAccountStatus === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_COMPLETED) {
                    return $this->response($response, self::STORE_OWNER_PROFILE_COMPLETED);

                } elseif ($response->completeAccountStatus === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_SUBSCRIPTION_CREATED) {
                    return $this->response($response, self::STORE_OWNER_SUBSCRIPTION_CREATED);

                } elseif ($response->completeAccountStatus === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_BRANCH_CREATED) {
                    return $this->response($response, self::STORE_OWNER_BRANCH_CREATED);

                }
            } elseif ($response->completeAccountStatus === null) {
                $response->completeAccountStatus = StoreProfileConstant::COMPLETE_ACCOUNT_IS_EMPTY;
                return $this->response($response, self::FETCH);
            }

        } else {
            return $this->response(UserReturnResultConstant::WRONG_USER_TYPE, self::ERROR_USER_TYPE);
        }
    }

    /**
     * store, captain, and supplies: Update complete account status of the user.
     * @Route("profilecompleteaccountstatus", name="updateCompleteAccountStatusOfTheUser", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Main")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update complete account status field request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="completeAccountStatus")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns completeAccountStatus new value",
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
     *      description="Returns completeAccountStatus new value",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9221 | 9004"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="completeAccountStatus")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateCompleteAccountStatus(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CompleteAccountStatusUpdateRequest::class, (object)$data);

        $request->setUserId($this->getUserId());

        $violations = $this->validator->validate($request);

        if(\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        if ($this->isGranted('ROLE_OWNER')) {
            $response = $this->mainService->updateCompleteAccountStatus($request, UserRoleConstant::STORE_OWNER_USER_TYPE);

            if($response === StoreProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS) {
                return $this->response($response, self::WRONG_COMPLETE_ACCOUNT_STATUS);

            } else {
                return $this->response($response, self::UPDATE);
            }

        } else {
            return $this->response(UserReturnResultConstant::WRONG_USER_TYPE, self::ERROR_USER_TYPE);
        }
    }
}
