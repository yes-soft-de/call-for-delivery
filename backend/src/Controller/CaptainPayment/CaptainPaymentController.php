<?php

namespace App\Controller\CaptainPayment;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Service\CaptainPayment\CaptainPaymentService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Symfony\Component\HttpFoundation\Request;
use stdClass;
use App\Request\CaptainPayment\CaptainPaymentFilterRequest;

/**
 * fetch captain's payments.
 * @Route("v1/captainpayment/")
 */
class CaptainPaymentController extends BaseController
{
    private AutoMapping $autoMapping;
    private CaptainPaymentService $captainPaymentService;

    public function __construct(SerializerInterface $serializer, CaptainPaymentService $captainPaymentService, AutoMapping $autoMapping)
    {
        parent::__construct($serializer);
        $this->captainPaymentService = $captainPaymentService;
        $this->autoMapping = $autoMapping;
    }
    
    /**
     * captain:Get all payments.
     * @Route("captainpayments", name="getCaptainPaymentsAndFilter", methods={"POST"})
     * @IsGranted("ROLE_CAPTAIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Payment")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="filter",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *      )
     * )
     * 
     * @OA\Response(
     *      response=200,
     *      description="Returns payments",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *           @OA\Items(
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="number", property="amount"),
     *              @OA\Property(type="object", property="createdAt"),
     *              @OA\Property(type="string", property="note"),
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCaptainPayments(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainPaymentFilterRequest::class, (object)$data);
        $request->setUserId($this->getUserId());

        $result = $this->captainPaymentService->getCaptainPayments($request);

        return $this->response($result, self::FETCH);
    }
}
