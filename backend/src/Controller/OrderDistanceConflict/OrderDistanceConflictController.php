<?php

namespace App\Controller\OrderDistanceConflict;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Main\MainErrorConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\OrderDistanceConflict\OrderDistanceConflictResultConstant;
use App\Constant\StoreOrderDetails\StoreOrderDetailsConstant;
use App\Controller\BaseController;
use App\Request\OrderDistanceConflict\OrderDistanceConflictCreateByCaptainRequest;
use App\Service\OrderDistanceConflict\OrderDistanceConflictService;
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
 * @Route("v1/orderdistanceconflict/")
 */
class OrderDistanceConflictController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private OrderDistanceConflictService $orderDistanceConflictService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * captain: create new order distance conflict by captain
     * @Route("orderdistanceconflictbycaptain", name="createOrderDistanceConflictByCaptain", methods={"POST"})
     * @IsGranted("ROLE_CAPTAIN")
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
     *      description="create order distance conflict by captain",
     *      @OA\JsonContent(
     *              @OA\Property(type="integer", property="orderId"),
     *              @OA\Property(type="string", property="conflictNote"),
     *              @OA\Property(type="string", property="proposedDestinationOrDistance")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the order distance conflict info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\OrderDistanceConflict\OrderDistanceConflictCreateByCaptainResponse")
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
     *                          @OA\Property(type="string", property="status_code", description="9205"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9101"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9217"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9240"),
     *                          @OA\Property(type="string", property="msg")
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9215"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createOrderDistanceConflictByCaptain(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, OrderDistanceConflictCreateByCaptainRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->orderDistanceConflictService->createOrderDistanceConflictByCaptain($request, $this->getUserId());

        if ($result === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_NOT_FOUND);

        } elseif ($result === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_PROFILE_NOT_EXIST);

        } elseif ($result === StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_STORE_ORDER_DETAILS_NOT_FOUND);

        } elseif ($result === OrderDistanceConflictResultConstant::ORDER_DISTANCE_ALREADY_EXIST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ORDER_DISTANCE_CONFLICT_ALREADY_EXIST_CONST);

        } elseif ($result === OrderResultConstant::ORDER_ALREADY_BEING_CANCELLED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_CANCEL);
        }

        return $this->response($result, self::CREATE);
    }
}
