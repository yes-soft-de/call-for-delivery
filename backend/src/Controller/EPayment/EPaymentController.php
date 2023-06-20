<?php

namespace App\Controller\EPayment;

use App\AutoMapping;
use App\Constant\Main\MainErrorConstant;
use App\Constant\Package\PackageConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\User\UserRoleConstant;
use App\Controller\BaseController;
use App\Request\EPayment\EPaymentCreateByStoreOwnerRequest;
use App\Service\EPayment\EPaymentService;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Uid\Uuid;
use Symfony\Component\Validator\Validator\ValidatorInterface;

/**
 * @Route("v1/epayment/")
 */
class EPaymentController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private EPaymentService $ePaymentService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * @Route("epaymentbystore", name="createEPaymentByStoreOwner", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="E-Payment")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create payment by store request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="status"),
     *          @OA\Property(type="integer", property="paymentFor"),
     *          @OA\Property(type="integer", property="paymentGetaway"),
     *          @OA\Property(type="number", property="amount"),
     *          @OA\Property(type="string", property="clientAddress"),
     *          @OA\Property(type="string", property="paymentId")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns succeded updating message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="object", property="startDate"),
     *              @OA\Property(type="object", property="endDate"),
     *              @OA\Property(type="string", property="status"),
     *              @OA\Property(type="string", property="note")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createEPaymentByStoreOwner(Request $request): JsonResponse
    {
        // prevent captain and supplier from using this api
        if (in_array(UserRoleConstant::ROLE_CAPTAIN, $this->getUser()->getRoles())
            || in_array(UserRoleConstant::ROLE_SUPPLIER, $this->getUser()->getRoles())) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_USER_TYPE);
        }

        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, EPaymentCreateByStoreOwnerRequest::class,
            (object) $data);

        $request->setStoreOwnerProfile($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->ePaymentService->createEPaymentByStoreOwner($request);

        if ($result === 0) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::E_PAYMENT_HAD_NOT_CREATED_SUCCESSFULLY_CONST);

        } elseif ($result === PackageConstant::PACKAGE_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::PACKAGE_NOT_EXIST);

        } elseif ($result === SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::SUBSCRIPTION_NOT_FOUND);

        } elseif ($result === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::STORE_OWNER_PROFILE_NOT_EXIST);
        }

        return $this->response($result, self::CREATE);
    }
}
