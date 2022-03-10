<?php

namespace App\Controller\Main;

use App\AutoMapping;
use App\Constant\Main\MainDeleteConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Controller\BaseController;
use App\Request\Main\OrderStateUpdateBySuperAdminRequest;
use App\Request\User\UserFilterRequest;
use App\Request\User\UserPasswordUpdateBySuperAdminRequest;
use App\Service\Main\MainService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Symfony\Component\Validator\Validator\ValidatorInterface;

/**
 * @Route("v1/main/")
 */
class MainController extends BaseController
{
    private ValidatorInterface $validator;
    private AutoMapping $autoMapping;
    private MainService $mainService;

    public function __construct(AutoMapping $autoMapping, SerializerInterface $serializer, MainService $mainService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->validator = $validator;
        $this->autoMapping = $autoMapping;
        $this->mainService = $mainService;
    }

    /**
     * check backend health.
     * @Route("checkbackendhealth", name="checkBackendHealth", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Main")
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
     *      description="Returns the new admin's role and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="string", property="result"),
     *                  @OA\Property(type="string", property="userRole")
     *          )
     *      )
     * )
     */
    public function checkBackendHealth(): JsonResponse
    {
        $response = $this->mainService->checkBackendHealth($this->getUserId());

        return $this->response($response, self::FETCH);
    }

    /**
     * For testing/debugging issues
     *
     * @Route("filterusersbysuperadmin", name="filterUsersBySuperAdmin", methods={"POST"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Main")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="filter users according to the following options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userId"),
     *          @OA\Property(type="string", property="role"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the users info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="userId"),
     *                  @OA\Property(type="array", property="roles",
     *                      @OA\Items()
     *                  )
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterUsersBySuperAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserFilterRequest::class, (object)$data);

        $response = $this->mainService->filterUsersBySuperAdmin($request);

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("userpasswordbysuperadmin", name="updateUserPasswordBySuperAdmin", methods={"PUT"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Main")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update request fields",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="password"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the users info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="userId"),
     *                  @OA\Property(type="array", property="roles",
     *                      @OA\Items()
     *                  )
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateUserPasswordBySuperAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, UserPasswordUpdateBySuperAdminRequest::class, (object)$data);

        $result = $this->mainService->updateUserPasswordBySuperAdmin($request);

        if($result === UserReturnResultConstant::USER_NOT_FOUND_RESULT) {
            return $this->response($result, self::ERROR_USER_NOT_FOUND);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("deletepackagesandsubscriptions", name="deletePackagesAndSubscriptions", methods={"DELETE"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Main")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=401,
     *      description="Returns deleted message when delete done successfully",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data", example="deleted")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deletePackagesAndSubscriptions(): JsonResponse
    {
        $response = $this->mainService->deletePackagesAndSubscriptions();

        if($response === MainDeleteConstant::DELETED) {
            return $this->response($response, self::DELETE);
        }

        return $this->json($response);
    }

    /**
     * update order state
     * @Route("updateorderstatebysuperadmin", name="updateOrderStateBySuperAdmin", methods={"PUT"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Main")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update order state by super admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="state")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns updated order info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               @OA\Property(type="integer", property="id"),
     *               @OA\Property(type="string", property="payment"),
     *               @OA\Property(type="number", property="orderCost"),
     *               @OA\Property(type="string", property="note"),
     *               @OA\Property(type="object", property="deliveryDate"),
     *               @OA\Property(type="string", property="state"),
     *               @OA\Property(type="integer", property="orderType"),
     *               @OA\Property(type="integer", property="captainId"),
     *               @OA\Property(type="object", property="createdAt"),
     *               @OA\Property(type="object", property="updatedAt"),
     *               @OA\Property(type="integer", property="kilometer")
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns order not found response",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9205"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data", example="orderNotFound")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateOrderStateBySuperAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderStateUpdateBySuperAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->mainService->updateOrderStateBySuperAdmin($request);

        if ($result === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return $this->response($result, self::ERROR_ORDER_NOT_FOUND);
        }

        return $this->response($result, self::UPDATE);
    }
}
