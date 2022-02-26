<?php

namespace App\Controller\CompanyInfo;

use App\AutoMapping;
use App\Constant\CompanyInfo\CompanyInfoConstant;
use App\Controller\BaseController;
use App\Request\CompanyInfo\CompanyInfoCreateRequest;
use App\Request\CompanyInfo\CompanyInfoUpdateRequest;
use App\Service\CompanyInfo\CompanyInfoService;
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
 * @Route("v1/company/")
 */
class CompanyInfoController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private CompanyInfoService $companyInfoService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, CompanyInfoService $companyInfoService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->companyInfoService = $companyInfoService;
    }

    /**
     * @Route("companyinfo", name="createCompanyInfo", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Company Info")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create new company info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="phone"),
     *          @OA\Property(type="string", property="phoneTwo"),
     *          @OA\Property(type="string", property="whatsapp"),
     *          @OA\Property(type="string", property="fax"),
     *          @OA\Property(type="string", property="email"),
     *          @OA\Property(type="string", property="bankName"),
     *          @OA\Property(type="string", property="stc"),
     *          @OA\Property(type="float", property="kilometers"),
     *          @OA\Property(type="float", property="maxKilometerBonus"),
     *          @OA\Property(type="float", property="minKilometerBonus")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new entered company info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="phoneTwo"),
     *                  @OA\Property(type="string", property="whatsapp"),
     *                  @OA\Property(type="string", property="fax"),
     *                  @OA\Property(type="string", property="email"),
     *                  @OA\Property(type="string", property="bankName"),
     *                  @OA\Property(type="string", property="stc"),
     *                  @OA\Property(type="float", property="kilometers"),
     *                  @OA\Property(type="float", property="maxKilometerBonus"),
     *                  @OA\Property(type="float", property="minKilometerBonus")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function create(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CompanyInfoCreateRequest::class, (object)$data);

        $result = $this->companyInfoService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("companyinfo", name="updateCompanyInfo", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Company Info")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="upadte company info",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="phone"),
     *          @OA\Property(type="string", property="phoneTwo"),
     *          @OA\Property(type="string", property="whatsapp"),
     *          @OA\Property(type="string", property="fax"),
     *          @OA\Property(type="string", property="email"),
     *          @OA\Property(type="string", property="bankName"),
     *          @OA\Property(type="string", property="stc"),
     *          @OA\Property(type="float", property="kilometers"),
     *          @OA\Property(type="float", property="maxKilometerBonus"),
     *          @OA\Property(type="float", property="minKilometerBonus")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new entered company info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="phoneTwo"),
     *                  @OA\Property(type="string", property="whatsapp"),
     *                  @OA\Property(type="string", property="fax"),
     *                  @OA\Property(type="string", property="email"),
     *                  @OA\Property(type="string", property="bankName"),
     *                  @OA\Property(type="string", property="stc"),
     *                  @OA\Property(type="float", property="kilometers"),
     *                  @OA\Property(type="float", property="maxKilometerBonus"),
     *                  @OA\Property(type="float", property="minKilometerBonus")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns the new entered company info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9230"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data", example="companyInfoNotExists")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function update(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, CompanyInfoUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->companyInfoService->update($request);

        if($result === CompanyInfoConstant::COMPANY_INFO_NOT_EXISTS) {
            return $this->response($result, self::COMPANY_INFO_NOT_EXISTS);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("companyinfo", name="getCompanyInfo", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Company Info")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns company info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="phoneTwo"),
     *                  @OA\Property(type="string", property="whatsapp"),
     *                  @OA\Property(type="string", property="fax"),
     *                  @OA\Property(type="string", property="email"),
     *                  @OA\Property(type="string", property="bankName"),
     *                  @OA\Property(type="string", property="stc"),
     *                  @OA\Property(type="float", property="kilometers"),
     *                  @OA\Property(type="float", property="maxKilometerBonus"),
     *                  @OA\Property(type="float", property="minKilometerBonus")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCompanyInfo(): JsonResponse
    {
        $result = $this->companyInfoService->getCompanyInfo();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("companyinfoforuser", name="getCompanyInfoForUser", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Company Info")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns company info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="phoneTwo"),
     *                  @OA\Property(type="string", property="whatsapp"),
     *                  @OA\Property(type="string", property="fax"),
     *                  @OA\Property(type="string", property="email"),
     *                  @OA\Property(type="string", property="bankName"),
     *                  @OA\Property(type="string", property="stc"),
     *                  @OA\Property(type="float", property="kilometers"),
     *                  @OA\Property(type="float", property="maxKilometerBonus"),
     *                  @OA\Property(type="float", property="minKilometerBonus")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCompanyInfoForUser(): JsonResponse
    {
        $result = [];

        if ($this->isGranted('ROLE_OWNER')) {
            $result = $this->companyInfoService->getCompanyInfoForUser(CompanyInfoConstant::COMPANY_INFO_REQUIRED_BY_STORE_OWNER, $this->getUserId());

        } elseif ($this->isGranted('ROLE_CAPTAIN')) {
            $result = $this->companyInfoService->getCompanyInfoForUser(CompanyInfoConstant::COMPANY_INFO_REQUIRED_BY_CAPTAIN, $this->getUserId());
        }

        return $this->response($result, self::FETCH);
    }
}
