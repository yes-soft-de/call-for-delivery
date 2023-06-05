<?php

namespace App\Controller\Admin\ExternalDeliveryCompany;

use App\AutoMapping;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyCreateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyDeleteByIdRequest;
use App\Request\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyStatusUpdateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyUpdateByAdminRequest;
use App\Service\Admin\ExternalDeliveryCompany\AdminExternalDeliveryCompanyService;
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
 * @Route("v1/admin/externaldeliverycompany/")
 */
class AdminExternalDeliveryCompanyController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private AdminExternalDeliveryCompanyService $adminExternalDeliveryCompanyService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin: create external delivery company by admin
     * @Route("externaldeliverycompany", name="createExternalDeliveryCompanyByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="External Delivery Company")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create new external delivery company request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="companyName"),
     *          @OA\Property(type="boolean", property="status")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the newly created company",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyCreateByAdminResponse")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createExternalDeliveryCompany(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ExternalDeliveryCompanyCreateByAdminRequest::class,
            (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminExternalDeliveryCompanyService->createExternalDeliveryCompany($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin: update external delivery company status by admin
     * @Route("externaldeliverycompanystatus", name="updateExternalDeliveryCompanyStatusByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="External Delivery Company")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update status request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="boolean", property="status")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the updated company",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyStatusUpdateByAdminResponse")
     *              )
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error according to situation.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9050"),
     *                       @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     *
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateExternalDeliveryCompanyStatus(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ExternalDeliveryCompanyStatusUpdateByAdminRequest::class,
            (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminExternalDeliveryCompanyService->updateExternalDeliveryCompanyStatus($request);

        if ($result === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: update external delivery company by admin
     * @Route("externaldeliverycompany", name="updateExternalDeliveryCompanyByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="External Delivery Company")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update status request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="companyName")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the updated company",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyUpdateByAdminResponse")
     *              )
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error according to situation.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9050"),
     *                       @OA\Property(type="string", property="msg")
     *                   )
     *                }
     *      )
     *
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateExternalDeliveryCompany(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ExternalDeliveryCompanyUpdateByAdminRequest::class,
            (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminExternalDeliveryCompanyService->updateExternalDeliveryCompany($request);

        if ($result === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: fetch all external delivery companies by admin
     * @Route("externaldeliverycompanies", name="fetchAllExternalDeliveryCompaniesByAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="External Delivery Company")
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
     *      description="Returns the updated company",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyFetchResponse")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function fetchAllExternalDeliveryCompanies(): JsonResponse
    {
        $result = $this->adminExternalDeliveryCompanyService->fetchAllExternalDeliveryCompanies();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: delete external delivery company by admin
     * @Route("externaldeliverycompany", name="deleteExternalDeliveryCompanyByAdmin", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="External Delivery Company")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="delete by id request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id")
     *      )
     * )
     *
     * @OA\Response(
     *      response=401,
     *      description="Returns the deleted company",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyDeleteResponse")
     *              )
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error according to situation.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9050"),
     *                       @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     *
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteExternalDeliveryCompanyById(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, ExternalDeliveryCompanyDeleteByIdRequest::class,
            (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminExternalDeliveryCompanyService->deleteExternalDeliveryCompanyById($request);

        if ($result === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST);
        }

        return $this->response($result, self::DELETE);
    }
}
