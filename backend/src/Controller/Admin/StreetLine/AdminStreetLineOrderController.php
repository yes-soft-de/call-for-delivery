<?php

namespace App\Controller\Admin\StreetLine;

use App\AutoMapping;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Constant\ExternalDeliveryCompany\StreetLine\StreetLineCompanyConstant;
use App\Constant\ExternallyDeliveredOrder\ExternallyDeliveredOrderConstant;
use App\Constant\HTTP\HttpResponseConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\Admin\StreetLine\OrderInStreetLineCancelByAdminRequest;
use App\Service\Admin\StreetLine\AdminStreetLineOrderService;
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
 * @Route("v1/admin/streetline/order/")
 */
class AdminStreetLineOrderController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private AdminStreetLineOrderService $adminStreetLineOrderService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin: cancel order in StreetLine company (Only)
     * @Route("cancelexternalorderonly", name="cancelExternalOrderInStreetLineOnlyByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="StreetLine Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="cancel external order request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="orderId")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the cancelled external order info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\StreetLine\OrderInStreetLineCancelByAdminResponse")
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
     *                   ),
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9680"),
     *                       @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9679"),
     *                       @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9681"),
     *                       @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                       @OA\Property(type="string", property="status_code", description="9678"),
     *                       @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function cancelOrderInStreetLineCompanyByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, OrderInStreetLineCancelByAdminRequest::class,
            (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStreetLineOrderService->cancelOrderInStreetLineCompanyByAdmin($request, $this->getUserId());


        if ($result === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_IS_NOT_REGISTERED_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::EXTERNAL_DELIVERY_COMPANY_NOT_REGISTERED_CONST);

        } elseif ($result === HttpResponseConstant::INVALID_CREDENTIALS_RESULT_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::INVALID_CREDENTIALS_RESULT_CONST);

        } elseif ($result === HttpResponseConstant::INVALID_INPUT_RESULT_CODE_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::INVALID_INPUT_RESULT_CONST);

        } elseif ($result === StreetLineCompanyConstant::RESPONSE_MESSAGE_INVALID_ORDER_VALUE_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::RESPONSE_MESSAGE_INVALID_ORDER_VALUE_CONST);

        }  elseif ($result === HttpResponseConstant::METHOD_NOT_ALLOWED_RESULT_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::METHOD_NOT_ALLOWED_CONST);

        } elseif ($result === HttpResponseConstant::UNRECOGNIZED_RESPONSE_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::UNRECOGNIZED_RESPONSE_CONST);

        } elseif ($result === ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::EXTERNAL_ORDER_NOT_FOUND_CONST);
        }

        return $this->response($result, self::UPDATE);
    }
}
