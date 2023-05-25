<?php

namespace App\Controller\Admin\OrderDistanceConflict;

use App\AutoMapping;
use App\Constant\Admin\AdminProfileConstant;
use App\Constant\Main\MainErrorConstant;
use App\Constant\OrderDistanceConflict\OrderDistanceConflictResultConstant;
use App\Controller\BaseController;
use App\Request\Admin\OrderDistanceConflict\OrderDistanceConflictFilterByAdminRequest;
use App\Request\Admin\OrderDistanceConflict\OrderDistanceConflictRefuseByAdminRequest;
use App\Service\Admin\OrderDistanceConflict\AdminOrderDistanceConflictService;
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
 * @Route("v1/admin/orderdistanceconflict/")
 */
class AdminOrderDistanceConflictController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private AdminOrderDistanceConflictService $adminOrderDistanceConflictService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin: refuse a specific order distance conflict by admin
     * @Route("refuseorderdistanceconflictbyadmin", name="refuseOrderDistanceConflictByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order Distance Conflict")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="refuse order distance conflict by admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="adminNote")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the refused order distance conflict info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\OrderDistanceConflict\OrderDistanceConflictUpdateByAdminResponse")
     *      )
     *   )
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
     *                          @OA\Property(type="string", property="status_code", description="9210"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9410"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function refuseOrderDistanceConflictByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderDistanceConflictRefuseByAdminRequest::class,
            (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminOrderDistanceConflictService->refuseOrderDistanceConflictByAdmin($request, $this->getUserId());

        if ($result === OrderDistanceConflictResultConstant::ORDER_DISTANCE_CONFLICT_NOT_EXIST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ORDER_DISTANCE_CONFLICT_NOT_EXIST_CONST);

        } elseif ($result === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ADMIN_PROFILE_NOT_EXIST);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: filter orders distance conflicts by admin
     * @Route("filterorderdistanceconflictbyadmin", name="filterOrderDistanceConflictByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Order Distance Conflict")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="filter order distance conflict by admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="boolean", property="isResolved"),
     *          @OA\Property(type="integer", property="storeOwnerProfileId"),
     *          @OA\Property(type="integer", property="storeBranchId"),
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the filtered order distance conflict info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="integer", property="orderId"),
     *                  @OA\Property(type="object", property="createdAt"),
     *                  @OA\Property(type="object", property="updatedAt"),
     *                  @OA\Property(type="integer", property="conflictResolvedBy"),
     *                  @OA\Property(type="integer", property="conflictResolvedByUserType"),
     *                  @OA\Property(type="object", property="resolvedAt"),
     *                  @OA\Property(type="boolean", property="isResolved"),
     *                  @OA\Property(type="string", property="conflictNote"),
     *                  @OA\Property(type="string", property="adminNote"),
     *                  @OA\Property(type="number", property="oldDistance"),
     *                  @OA\Property(type="number", property="newDistance"),
     *                  @OA\Property(type="array", property="oldDestination", @OA\Items()),
     *                  @OA\Property(type="array", property="newDestination", @OA\Items()),
     *                  @OA\Property(type="string", property="proposedDestinationOrDistance"),
     *                  @OA\Property(type="integer", property="resolveType"),
     *                  @OA\Property(type="string", property="captainName"),
     *                  @OA\Property(type="integer", property="captainProfileId"),
     *                  @OA\Property(type="string", property="storeOwnerName"),
     *                  @OA\Property(type="integer", property="storeOwnerProfileId"),
     *                  @OA\Property(type="string", property="storeBranchName")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterOrderDistanceConflictByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderDistanceConflictFilterByAdminRequest::class,
            (object)$data);

        $result = $this->adminOrderDistanceConflictService->filterOrderDistanceConflictByAdmin($request);

        return $this->response($result, self::FETCH);
    }
}
