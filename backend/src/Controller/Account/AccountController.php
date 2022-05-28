<?php

namespace App\Controller\Account;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Main\MainErrorConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Constant\User\UserRoleConstant;
use App\Constant\UserStatus\UserStatusConstant;
use App\Controller\BaseController;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Service\Account\AccountService;
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
 * @Route("v1/account/")
 */
class AccountController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AccountService $accountService;

    public function __construct(AutoMapping $autoMapping, SerializerInterface $serializer, ValidatorInterface $validator, AccountService $accountService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->accountService = $accountService;
    }

    /**
     * store, captain, and supplier: Get complete account status of the user.
     * @Route("profilecompleteaccountstatus", name="getCompleteAccountStatusOfUser", methods={"GET"})
     * @IsGranted("ROLE_USER")
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
     *          @OA\Property(type="string", property="status_code", example="9158 or 9159 or 9160 or 9161 or 9004"),
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
        if ($this->isGranted(UserRoleConstant::ROLE_OWNER)) {
            $response = $this->accountService->getCompleteAccountStatusByUserId($this->getUserId(), UserRoleConstant::STORE_OWNER_USER_TYPE);

            if ($response->status) {
                if ($response->status === UserStatusConstant::USER_STATUS_MAINTENANCE_MOOD) {
                    return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_USER_MAINTENANCE_MOOD);
                }
            }

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

        } elseif ($this->isGranted(UserRoleConstant::ROLE_CAPTAIN)) {
            $response = $this->accountService->getCompleteAccountStatusByUserId($this->getUserId(), UserRoleConstant::CAPTAIN_USER_TYPE);

            if ($response->status) {
                if ($response->status === UserStatusConstant::USER_STATUS_MAINTENANCE_MOOD) {
                    return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_USER_MAINTENANCE_MOOD);
                }
            }

            if ($response->completeAccountStatus === CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED) {
                return $this->response($response, self::CAPTAIN_PROFILE_CREATED);

            } elseif ($response->completeAccountStatus === CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_COMPLETED) {
                return $this->response($response, self::CAPTAIN_PROFILE_COMPLETED);

            } elseif ($response->completeAccountStatus === CaptainConstant::COMPLETE_ACCOUNT_STATUS_SYSTEM_FINANCIAL_SELECTED) {
                return $this->response($response, self::CAPTAIN_PROFILE_SYSTEM_FINANCIAL_SELECTED);

            } elseif ($response->completeAccountStatus === null) {
                $response->completeAccountStatus = CaptainConstant::COMPLETE_ACCOUNT_IS_EMPTY;
                return $this->response($response, self::FETCH);

            } else {
                return $this->response(UserReturnResultConstant::WRONG_USER_TYPE, self::ERROR_USER_TYPE);
            }

        } elseif ($this->isGranted(UserRoleConstant::ROLE_SUPPLIER)) {
            $response = $this->accountService->getCompleteAccountStatusByUserId($this->getUserId(), UserRoleConstant::SUPPLIER_USER_TYPE);

            if ($response->status) {
                if ($response->status === UserStatusConstant::USER_STATUS_MAINTENANCE_MOOD) {
                    return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_USER_MAINTENANCE_MOOD);
                }
            }

            if ($response->completeAccountStatus === SupplierProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED) {
                return $this->response($response, self::SUPPLIER_PROFILE_CREATED);

            } elseif ($response->completeAccountStatus === SupplierProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_COMPLETED) {
                return $this->response($response, self::SUPPLIER_PROFILE_COMPLETED);

            } elseif ($response->completeAccountStatus === null) {
                $response->completeAccountStatus = SupplierProfileConstant::COMPLETE_ACCOUNT_IS_EMPTY;
                return $this->response($response, self::FETCH);

            } else {
                return $this->response(UserReturnResultConstant::WRONG_USER_TYPE, self::ERROR_USER_TYPE);
            }
        }
    }

    /**
     * store, captain, and supplier: Update complete account status of the user.
     * @Route("profilecompleteaccountstatus", name="updateCompleteAccountStatusOfTheUser", methods={"PUT"})
     * @IsGranted("ROLE_USER")
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

        if ($this->isGranted(UserRoleConstant::ROLE_OWNER)) {
            $response = $this->accountService->updateCompleteAccountStatus($request, UserRoleConstant::STORE_OWNER_USER_TYPE);

            if($response === StoreProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS) {
                return $this->response($response, self::WRONG_COMPLETE_ACCOUNT_STATUS);

            } else {
                return $this->response($response, self::UPDATE);
            }

        } elseif ($this->isGranted(UserRoleConstant::ROLE_CAPTAIN)) {
            $response = $this->accountService->updateCompleteAccountStatus($request, UserRoleConstant::CAPTAIN_USER_TYPE);

            if($response === CaptainConstant::WRONG_COMPLETE_ACCOUNT_STATUS) {
                return $this->response($response, self::WRONG_COMPLETE_ACCOUNT_STATUS);

            } else {
                return $this->response($response, self::UPDATE);
            }

        } elseif ($this->isGranted(UserRoleConstant::ROLE_SUPPLIER)) {
            $response = $this->accountService->updateCompleteAccountStatus($request, UserRoleConstant::SUPPLIER_USER_TYPE);

            if ($response === SupplierProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS) {
                return $this->response($response, self::WRONG_COMPLETE_ACCOUNT_STATUS);

            } else {
                return $this->response($response, self::UPDATE);
            }

        } else {
            return $this->response(UserReturnResultConstant::WRONG_USER_TYPE, self::ERROR_USER_TYPE);
        }
    }
}
