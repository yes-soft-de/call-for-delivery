<?php

namespace App\Controller\Admin\ExternallyDeliveredOrder;

use App\AutoMapping;
use App\Constant\AppFeature\AppFeatureResultConstant;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Constant\HTTP\HttpResponseConstant;
use App\Constant\Main\MainErrorConstant;
use App\Constant\Order\OrderResultConstant;
use App\Controller\BaseController;
use App\Request\Admin\ExternallyDeliveredOrder\ExternallyDeliveredOrderCreateByAdminRequest;
use App\Service\Admin\ExternallyDeliveredOrder\AdminExternallyDeliveredOrderService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

/**
 * @Route("v1/admin/externallydeliveredorder/")
 */
class AdminExternallyDeliveredOrderController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private AdminExternallyDeliveredOrderService $adminExternallyDeliveredOrderService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin: create externally delivered order by admin
     * @Route("externallydeliveredorderbyadmin", name="createExternallyDeliveredOrderByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Externally Delivered Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create new external order request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="orderId"),
     *          @OA\Property(type="integer", property="externalCompanyId")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the newly created external order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\ExternallyDeliveredOrder\ExternallyDeliveredOrderCreateByAdminResponse")
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
     *                       @OA\Property(type="string", property="status_code", description="9076"),
     *                       @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9077"),
     *                       @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9050"),
     *                       @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9205"),
     *                       @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9052"),
     *                       @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9676"),
     *                       @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9677"),
     *                       @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createExternallyDeliveredOrderByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, ExternallyDeliveredOrderCreateByAdminRequest::class,
            (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminExternallyDeliveredOrderService->createExternallyDeliveredOrderByAdmin($request);

        if ($result === AppFeatureResultConstant::APP_FEATURE_NOT_FOUND_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::APP_FEATURE_NOT_FOUND_CONST);

        } elseif ($result === AppFeatureResultConstant::APP_FEATURE_NOT_ACTIVATED_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::APP_FEATURE_NOT_ACTIVE_CONST);

        } elseif ($result === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST);

        } elseif ($result === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_NOT_FOUND);

        } elseif ($result === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_IS_NOT_REGISTERED_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::EXTERNAL_DELIVERY_COMPANY_NOT_REGISTERED_CONST);

        } elseif ($result === HttpResponseConstant::INVALID_CREDENTIALS_RESULT_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::INVALID_CREDENTIALS_RESULT_CONST);

        } elseif ($result === HttpResponseConstant::INVALID_INPUT_RESULT_CODE_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::INVALID_INPUT_RESULT_CONST);
        }

        return $this->response($result, self::CREATE);
    }
}
