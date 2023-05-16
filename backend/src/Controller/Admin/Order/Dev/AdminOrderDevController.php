<?php

namespace App\Controller\Admin\Order\Dev;

use App\AutoMapping;
use App\Constant\Main\MainErrorConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Controller\BaseController;
use App\Request\Admin\Order\TestingOrderCreateByAdminRequest;
use App\Service\Admin\Order\Dev\AdminOrderDevService;
use Nelmio\ApiDocBundle\Annotation\Model;
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
 * @Route("v1/dev/admin/order/")
 */
class AdminOrderDevController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private AdminOrderDevService $adminOrderDevService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin: Create new order/s by admin for testing purposes
     * @Route("createorderbyadmin", name="createDevOrderByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create a new order by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="storeOwner", description="The id of the store owner profile"),
     *          @OA\Property(type="integer", property="branch", description="The id of the store branch"),
     *          @OA\Property(type="boolean", property="orderIsMain"),
     *          @OA\Property(type="integer", property="ordersCount")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns new order",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\Order\TestingOrderCreateByAdminResponse")
     *              )
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
     *                          @OA\Property(type="string", property="status_code", description="9151"),
     *                          @OA\Property(type="string", property="msg", description="error store inactive Error.")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9204"),
     *                          @OA\Property(type="string", property="msg", description="error Successfully."),
     *                          @OA\Property(type="object", property="Data",
     *                              ref=@Model(type="App\Response\Subscription\CanCreateOrderResponse")
     *                          )
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9157"),
     *                          @OA\Property(type="string", property="msg", description="store owner profile not exist! Error.")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9162"),
     *                          @OA\Property(type="string", property="msg", description="store branch is not exist Error.")
     *                   )
     *              }
     *      )
     *
     * )
     *
     * @Security(name="Bearer")
     */
    public function createDevOrderByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, TestingOrderCreateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminOrderDevService->createDevOrderByAdmin($request, $this->getUserId());

        if ($result === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::STORE_OWNER_PROFILE_NOT_EXIST);

        } elseif ($result === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_STORE_INACTIVE);

        } elseif (isset($result->canCreateOrder)) {
            return $this->response($result, self::ERROR_ORDER_CAN_NOT_CREATE);

        } elseif ($result === StoreOwnerBranch::BRANCH_NOT_FOUND) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::STORE_BRANCH_NOT_EXIST);
        }

        return $this->response($result, self::CREATE);
    }
}
