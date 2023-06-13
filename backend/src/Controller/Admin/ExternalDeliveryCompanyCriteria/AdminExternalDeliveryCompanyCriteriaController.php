<?php

namespace App\Controller\Admin\ExternalDeliveryCompanyCriteria;

use App\AutoMapping;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaResultConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaCreateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaDeleteByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaStatusUpdateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaUpdateByAdminRequest;
use App\Service\Admin\ExternalDeliveryCompanyCriteria\AdminExternalDeliveryCompanyCriteriaService;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

/**
 * @Route("v1/admin/externaldeliverycompanycriteria/")
 */
class AdminExternalDeliveryCompanyCriteriaController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private AdminExternalDeliveryCompanyCriteriaService $adminExternalDeliveryCompanyCriteriaService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin: create external delivery company criteria by admin
     * @Route("externaldeliverycompanycriteria", name="createExternalDeliveryCompanyCriteriaByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="External Delivery Company Criteria")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create new criteria for a specific delivery company request",
     *      @OA\JsonContent(
     *          @OA\Property(type="boolean", property="isSpecificDate"),
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="integer", property="isDistance", example="205: off. 206: storeBranchToClientDistance"),
     *          @OA\Property(type="number", property="fromDistance"),
     *          @OA\Property(type="number", property="toDistance"),
     *          @OA\Property(type="number", property="payment", example="207: off. 208: card. 209: cash. 210: both"),
     *          @OA\Property(type="boolean", property="isFromAllStores"),
     *          @OA\Property(type="array", property="fromStoresBranches",
     *              @OA\Items(type="integer")
     *          ),
     *          @OA\Property(type="integer", property="externalDeliveryCompany", description="external delivery company profile id"),
     *          @OA\Property(type="string", property="criteriaName"),
     *          @OA\Property(type="boolean", property="status"),
     *          @OA\Property(type="number", property="cashLimit")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the newly created external delivery company criteria",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaCreateByAdminResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9050"),
     *                       @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createExternalDeliveryCompanyCriteria(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, ExternalDeliveryCompanyCriteriaCreateByAdminRequest::class,
            (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminExternalDeliveryCompanyCriteriaService->createExternalDeliveryCompanyCriteria($request);

        if ($result === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST);
        }

        return $this->response($result, self::CREATE);
    }

    /**
     * admin: update external delivery company criteria by admin
     * @Route("externaldeliverycompanycriteria", name="updateExternalDeliveryCompanyCriteriaByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="External Delivery Company Criteria")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create new criteria for a specific delivery company request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="boolean", property="isSpecificDate"),
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="integer", property="isDistance", example="205: off. 206: storeBranchToClientDistance"),
     *          @OA\Property(type="number", property="fromDistance"),
     *          @OA\Property(type="number", property="toDistance"),
     *          @OA\Property(type="number", property="payment", example="207: off. 208: card. 209: cash. 210: both"),
     *          @OA\Property(type="boolean", property="isFromAllStores"),
     *          @OA\Property(type="array", property="fromStoresBranches",
     *              @OA\Items(type="integer")
     *          ),
     *          @OA\Property(type="string", property="criteriaName"),
     *          @OA\Property(type="number", property="cashLimit")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the updated external delivery company criteria",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaUpdateByAdminResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9250"),
     *                       @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateExternalDeliveryCompanyCriteria(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, ExternalDeliveryCompanyCriteriaUpdateByAdminRequest::class,
            (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminExternalDeliveryCompanyCriteriaService->updateExternalDeliveryCompanyCriteria($request,
            $this->getUserId());

        if ($result === ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: update external delivery company criteria status by admin
     * @Route("externaldeliverycompanycriteriastatus", name="updateExternalDeliveryCompanyCriteriaStatusByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="External Delivery Company Criteria")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create new criteria for a specific delivery company request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="boolean", property="status")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the updated external delivery company criteria",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaUpdateByAdminResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9250"),
     *                       @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateExternalDeliveryCompanyCriteriaStatus(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, ExternalDeliveryCompanyCriteriaStatusUpdateByAdminRequest::class,
            (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminExternalDeliveryCompanyCriteriaService->updateExternalDeliveryCompanyCriteriaStatus($request,
            $this->getUserId());

        if ($result === ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: fetch external delivery company criteria by external company by admin
     * @Route("externaldeliverycompanycriteria/{externalDeliveryCompanyId}", name="fetchExternalDeliveryCompanyCriteriaByExternalCompanyIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $externalDeliveryCompanyId
     * @return JsonResponse
     *
     * @OA\Tag(name="External Delivery Company Criteria")
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
     *      description="Returns all external delivery company criteria of a company",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyGetByExternalCompanyForAdminResponse")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getExternalDeliveryCompanyCriteriaByExternalDeliveryCompanyId(int $externalDeliveryCompanyId): JsonResponse
    {
        $result = $this->adminExternalDeliveryCompanyCriteriaService->getExternalDeliveryCompanyCriteriaByExternalDeliveryCompanyId($externalDeliveryCompanyId);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: delete external delivery company criteria by id by admin
     * @Route("externaldeliverycompanycriteria", name="deleteExternalDeliveryCompanyCriteriaByIdByAdmin", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="External Delivery Company Criteria")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="delete criteria by id request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id")
     *      )
     * )
     *
     * @OA\Response(
     *      response=401,
     *      description="Returns the deleted external delivery company criteria",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaDeleteResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteExternalDeliveryCompanyCriteriaById(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, ExternalDeliveryCompanyCriteriaDeleteByAdminRequest::class,
            (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminExternalDeliveryCompanyCriteriaService->deleteExternalDeliveryCompanyCriteriaById($request);

        if ($result === ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST);
        }

        return $this->response($result, self::DELETE);
    }
}
