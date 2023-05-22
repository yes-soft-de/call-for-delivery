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
