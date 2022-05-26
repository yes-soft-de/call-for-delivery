<?php

namespace App\Controller\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingOnOrderCreateRequest;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingOnOrderService;
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
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingOnOrderUpdateRequest;

/**
 * Create and fetch Captain's Financial System According On Order.
 * @Route("v1/admin/captainfinancialsystemaccordingnorderbyadmin/")
 */
class AdminCaptainFinancialSystemAccordingOnOrderController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminCaptainFinancialSystemAccordingOnOrderService $adminCaptainFinancialSystemAccordingOnOrderService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminCaptainFinancialSystemAccordingOnOrderService $adminCaptainFinancialSystemAccordingOnOrderService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminCaptainFinancialSystemAccordingOnOrderService = $adminCaptainFinancialSystemAccordingOnOrderService;
    }

    /**
     * admin:Captain's Financial System According On Order
     * @Route("captainfinancialsystemaccordingonorderbyadmin", name="createCaptainFinancialSystemAccordingOnOrderByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain's Financial System According On Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="new Captain's Financial System According On Order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="categoryName"),
     *          @OA\Property(type="number", property="countKilometersFrom"),
     *          @OA\Property(type="number", property="countKilometersTo"),
     *          @OA\Property(type="number", property="amount"),
     *          @OA\Property(type="number", property="bounce"),
     *          @OA\Property(type="number", property="bounceCountOrdersInMonth"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns Captain's Financial System According On Order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="categoryName"),
     *          @OA\Property(type="integer", property="countKilometersFrom"),
     *          @OA\Property(type="integer", property="countKilometersTo"),
     *          @OA\Property(type="number", property="amount"),
     *          @OA\Property(type="number", property="bounce"),
     *          @OA\Property(type="number", property="bounceCountOrdersInMonth"),
     *      )
     *   )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function createCaptainFinancialSystemAccordingOnOrder(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCaptainFinancialSystemAccordingOnOrderCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainFinancialSystemAccordingOnOrderService->createCaptainFinancialSystemAccordingOnOrder($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin:Get all Captain's Financial System According OnOrder.
     * @Route("captainfinancialsystemaccordingonorderbyadmin", name="getAllCaptainFinancialSystemAccordingOnOrderByAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain's Financial System According OnOrder")
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
     *               @OA\Property(type="string", property="categoryName"),
     *               @OA\Property(type="integer", property="countKilometersFrom"),
     *               @OA\Property(type="integer", property="countKilometersTo"),
     *               @OA\Property(type="number", property="amount"),
     *               @OA\Property(type="number", property="bounce"),
     *               @OA\Property(type="number", property="bounceCountOrdersInMonth"),
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllCaptainFinancialSystemAccordingOnOrder(): JsonResponse
    {
        $result = $this->adminCaptainFinancialSystemAccordingOnOrderService->getAllCaptainFinancialSystemAccordingOnOrder();

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: Update Captain's Financial System According On Order
     * @Route("captainfinancialsystemaccordingonorderbyadmin", name="updateCaptainFinancialSystemAccordingOnOrderByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain's Financial System According On Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update Captain's Financial System According On Order",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="categoryName"),
     *          @OA\Property(type="number", property="countKilometersFrom"),
     *          @OA\Property(type="number", property="countKilometersTo"),
     *          @OA\Property(type="number", property="amount"),
     *          @OA\Property(type="number", property="bounce"),
     *          @OA\Property(type="number", property="bounceCountOrdersInMonth"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns Captain's Financial System According On Order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="categoryName"),
     *          @OA\Property(type="integer", property="countKilometersFrom"),
     *          @OA\Property(type="integer", property="countKilometersTo"),
     *          @OA\Property(type="number", property="amount"),
     *          @OA\Property(type="number", property="bounce"),
     *          @OA\Property(type="number", property="bounceCountOrdersInMonth"),
     *      )
     *   )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function updateCaptainFinancialSystemAccordingOnOrder(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCaptainFinancialSystemAccordingOnOrderUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainFinancialSystemAccordingOnOrderService->updateCaptainFinancialSystemAccordingOnOrder($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: delete Captain's Financial System According On Order
     * @Route("captainfinancialsystemaccordingonorderbyadmin/{id}", name="deleteCaptainFinancialSystemAccordingOnOrderByAdmin", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain's Financial System According On Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     *
     * @OA\Response(
     *      response=401,
     *      description="Returns Captain's Financial System According On Order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *          @OA\Property(type="integer", property="id"),
     *      )
     *   )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function deleteCaptainFinancialSystemAccordingOnOrder($id): JsonResponse
    {
        $result = $this->adminCaptainFinancialSystemAccordingOnOrderService->deleteCaptainFinancialSystemAccordingOnOrder($id);

        return $this->response($result, self::DELETE);
    }
}
