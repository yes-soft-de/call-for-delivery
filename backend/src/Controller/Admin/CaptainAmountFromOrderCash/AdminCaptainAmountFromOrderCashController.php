<?php

namespace App\Controller\Admin\CaptainAmountFromOrderCash;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Service\Admin\CaptainAmountFromOrderCash\AdminCaptainAmountFromOrderCashService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use App\Request\Admin\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashFilterGetRequest;
use Nelmio\ApiDocBundle\Annotation\Model;


/**
 * admin :fetch Captain Amount From Order Cash.
 * @Route("v1/admin/captainamountfromordercash/")
 */
class AdminCaptainAmountFromOrderCashController extends BaseController
{
    private AdminCaptainAmountFromOrderCashService $adminCaptainAmountFromOrderCashService;
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;

    public function __construct(SerializerInterface $serializer, AdminCaptainAmountFromOrderCashService $adminCaptainAmountFromOrderCashService, AutoMapping $autoMapping, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminCaptainAmountFromOrderCashService = $adminCaptainAmountFromOrderCashService;
    }

    /**
     * admin:Get Captain Amount From Order Cash.
     * @Route("captainamountfromordercash", name="getCaptainAmountFromOrderCash", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Amount From Order Cash")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     * 
     * @OA\RequestBody(
     *      description="get Captain Amount From Order Cash By CaptainId and Date",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="captainId"),
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *      )
     * )
     * @OA\Response(
     *      response=200,
     *      description="Returns Captain Amount From Order Cash By CaptainId and Date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *             ref=@Model(type="App\Response\Admin\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashResponse")
     *         )
     *      )
     *    )
     *  ) 
     * 
     * @Security(name="Bearer")
     */
    public function getCaptainAmountFromOrderCash(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainAmountFromOrderCashFilterGetRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainAmountFromOrderCashService->filterCaptainAmountFromOrderCash($request);
        
        return $this->response($result, self::FETCH);
    }
}
