<?php

namespace App\Controller\EPayment;

use App\AutoMapping;
use App\Constant\Main\MainErrorConstant;
use App\Constant\Package\PackageConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Subscription\SubscriptionConstant;
use App\Controller\BaseController;
use App\Request\EPayment\EPaymentCreateByStoreOwnerRequest;
use App\Service\EPayment\EPaymentService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
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
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     *
     * @Security(name="Bearer")
     */
    public function createEPaymentByStoreOwner(Request $request): JsonResponse
    {
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
            return $this->response(MainErrorConstant::ERROR_MSG, self::E_PAYMENT_HAD_NOT_CREATED_SUCCESSFULLY_CONST);

        } elseif ($result === SubscriptionConstant::SUBSCRIPTION_DOES_NOT_EXIST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::E_PAYMENT_HAD_NOT_CREATED_SUCCESSFULLY_CONST);

        } elseif ($result === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::E_PAYMENT_HAD_NOT_CREATED_SUCCESSFULLY_CONST);
        }

        return $this->response($result, self::UPDATE);
    }
}
