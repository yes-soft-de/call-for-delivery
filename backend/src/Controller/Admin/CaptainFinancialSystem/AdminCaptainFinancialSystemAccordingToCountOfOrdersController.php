<?php

namespace App\Controller\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateRequest;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersService;
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
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersUpdateRequest;

/**
 * Create and fetch Captain's Financial System According To Count Of Orders.
 * @Route("v1/admin/captainfinancialsystemaccordingntocountofordersbyadmin/")
 */
class AdminCaptainFinancialSystemAccordingToCountOfOrdersController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminCaptainFinancialSystemAccordingToCountOfOrdersService $adminCaptainFinancialSystemAccordingToCountOfOrdersService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminCaptainFinancialSystemAccordingToCountOfOrdersService $adminCaptainFinancialSystemAccordingToCountOfOrdersService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminCaptainFinancialSystemAccordingToCountOfOrdersService = $adminCaptainFinancialSystemAccordingToCountOfOrdersService;
    }

    /**
     * admin:Captain's Financial System According To Count Of Orders
     * @Route("captainfinancialsystemaccordingtocountofordersbyadmin", name="createCaptainFinancialSystemAccordingToCountOfOrdersByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain's Financial System According To Count Of Orders")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="new Captain's Financial System According To Count Of Orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="countOrdersInMonth"),
     *          @OA\Property(type="number", property="salary"),
     *          @OA\Property(type="number", property="monthCompensation"),
     *          @OA\Property(type="number", property="bounceMaxCountOrdersInMonth"),
     *          @OA\Property(type="number", property="bounceMinCountOrdersInMonth")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns Captain's Financial System According To Count Of Orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *          @OA\Property(type="integer", property="id"),
    *           @OA\Property(type="integer", property="countOrdersInMonth"),
     *          @OA\Property(type="number", property="salary"),
     *          @OA\Property(type="number", property="monthCompensation"),
     *          @OA\Property(type="number", property="bounceMaxCountOrdersInMonth"),
     *          @OA\Property(type="number", property="bounceMinCountOrdersInMonth")
     *      )
     *   )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function createCaptainFinancialSystemAccordingToCountOfOrders(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainFinancialSystemAccordingToCountOfOrdersService->createCaptainFinancialSystemAccordingToCountOfOrders($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin:Get all Captain's Financial System According To Count Of Orders.
     * @Route("captainfinancialsystemaccordingtocountofordersbyadmin", name="getAllCaptainFinancialSystemAccordingToCountOfOrdersByAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain's Financial System According ToCountOfOrders")
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
     *      description="Returns payments",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *           @OA\Items(
     *               @OA\Property(type="integer", property="id"),
     *               @OA\Property(type="integer", property="countOrdersInMonth"),
     *               @OA\Property(type="number", property="salary"),
     *               @OA\Property(type="number", property="monthCompensation"),
     *               @OA\Property(type="number", property="bounceMaxCountOrdersInMonth"),
     *               @OA\Property(type="number", property="bounceMinCountOrdersInMonth")
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllCaptainFinancialSystemAccordingToCountOfOrders(): JsonResponse
    {
        $result = $this->adminCaptainFinancialSystemAccordingToCountOfOrdersService->getAllCaptainFinancialSystemAccordingToCountOfOrders();

        return $this->response($result, self::FETCH);
    }
    
    /**
     * admin: Update Captain's Financial System According To Count Of Orders
     * @Route("captainfinancialsystemaccordingtocountofordersbyadmin", name="updateCaptainFinancialSystemAccordingToCountOfOrdersByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain's Financial System According To Count Of Orders")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update Captain's Financial System According To Count Of Orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="integer", property="countOrdersInMonth"),
     *          @OA\Property(type="number", property="salary"),
     *          @OA\Property(type="number", property="monthCompensation"),
     *          @OA\Property(type="number", property="bounceMaxCountOrdersInMonth"),
     *          @OA\Property(type="number", property="bounceMinCountOrdersInMonth")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns Captain's Financial System According To Count Of Orders",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *          @OA\Property(type="integer", property="id"),
    *           @OA\Property(type="integer", property="countOrdersInMonth"),
     *          @OA\Property(type="number", property="salary"),
     *          @OA\Property(type="number", property="monthCompensation"),
     *          @OA\Property(type="number", property="bounceMaxCountOrdersInMonth"),
     *          @OA\Property(type="number", property="bounceMinCountOrdersInMonth")
     *      )
     *   )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function updateCaptainFinancialSystemAccordingToCountOfOrders(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCaptainFinancialSystemAccordingToCountOfOrdersUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainFinancialSystemAccordingToCountOfOrdersService->updateCaptainFinancialSystemAccordingToCountOfOrders($request);

        return $this->response($result, self::CREATE);
    }
}
