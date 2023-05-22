<?php

namespace App\Controller\Order\Destination;

use App\Controller\BaseController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("v1/order/destination/")
 */
class OrderDestinationController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
//        private AutoMapping $autoMapping,
//        private ValidatorInterface $validator,
//        private OrderDestinationService $orderDestinationService
    )
    {
        parent::__construct($serializer);
    }

//    /**
//     * Captain: add distance to storeBranchToClientDistance by a new client location
//     * @Route("newdestinancebycaptain", name="updateOrderDestinationByCaptain", methods={"PUT"})
//     * @IsGranted("ROLE_CAPTAIN")
//     * @param Request $request
//     * @return JsonResponse
//     *
//     * @OA\Tag(name="Order")
//     *
//     * @OA\Parameter(
//     *      name="token",
//     *      in="header",
//     *      description="token to be passed as a header",
//     *      required=true
//     * )
//     *
//     * @OA\RequestBody(
//     *      description="update order destination by captain request",
//     *      @OA\JsonContent(
//     *          @OA\Property(type="integer", property="id", description="order id"),
//     *          @OA\Property(type="string", property="storeBranchToClientDistanceAdditionExplanation"),
//     *          @OA\Property(type="array", property="destination", description="new client destination",
//     *              @OA\Items(
//     *                  @OA\Property(type="number", property="lat"),
//     *                  @OA\Property(type="number", property="lon")
//     *              )
//     *          )
//     *      )
//     * )
//     *
//     * @OA\Response(
//     *      response=204,
//     *      description="Returns the updated order",
//     *      @OA\JsonContent(
//     *          @OA\Property(type="string", property="status_code"),
//     *          @OA\Property(type="string", property="msg"),
//     *          @OA\Property(type="object", property="Data",
//     *              ref=@Model(type="App\Response\Order\Destination\OrderDestinationUpdateResponse")
//     *      )
//     *   )
//     * )
//     *
//     * or
//     *
//     * @OA\Response(
//     *      response="default",
//     *      description="Return error.",
//     *      @OA\JsonContent(
//     *           oneOf={
//     *                   @OA\Schema(type="object",
//     *                          @OA\Property(type="string", property="status_code", description="9205"),
//     *                          @OA\Property(type="string", property="msg")
//     *                   ),
//     *                   @OA\Schema(type="object",
//     *                          @OA\Property(type="string", property="status_code", description="9217"),
//     *                          @OA\Property(type="string", property="msg")
//     *                   ),
//     *                   @OA\Schema(type="object",
//     *                          @OA\Property(type="string", property="status_code", description="9372"),
//     *                          @OA\Property(type="string", property="msg")
//     *                   ),
//     *                   @OA\Schema(type="object",
//     *                          @OA\Property(type="string", property="status_code", description="9602"),
//     *                          @OA\Property(type="string", property="msg")
//     *                   ),
//     *                   @OA\Schema(type="object",
//     *                          @OA\Property(type="string", property="status_code", description="9604"),
//     *                          @OA\Property(type="string", property="msg")
//     *                   ),
//     *                   @OA\Schema(type="object",
//     *                          @OA\Property(type="string", property="status_code", description="9373"),
//     *                          @OA\Property(type="string", property="msg")
//     *                   )
//     *
//     *              }
//     *        )
//     *     )
//     *
//     * @Security(name="Bearer")
//     */
//    public function updateNormalOrderDestinationByNewClientLocationAddition(Request $request): JsonResponse
//    {
//        $data = json_decode($request->getContent(), true);
//
//        $request = $this->autoMapping->map(stdClass::class, OrderStoreBranchToClientDistanceAdditionByCaptainUpdateRequest::class, (object)$data);
//
//        $violations = $this->validator->validate($request);
//
//        if (\count($violations) > 0) {
//            $violationsString = (string) $violations;
//
//            return new JsonResponse($violationsString, Response::HTTP_OK);
//        }
//
//        $result = $this->orderDestinationService->updateNormalOrderDestinationByNewClientLocationAddition($request);
//
//        if ($result === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
//            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_ORDER_NOT_FOUND);
//
//        } elseif ($result === StoreOrderDetailsConstant::STORE_ORDER_DETAILS_NOT_FOUND) {
//            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_STORE_ORDER_DETAILS_NOT_FOUND);
//
//        } elseif ($result === GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED) {
//            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_CAN_NOT_CALCULATE_DISTANCE);
//
//        } elseif ($result === CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM) {
//            return $this->response(MainErrorConstant::ERROR_MSG, self::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM);
//
//        } elseif ($result === CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
//            return $this->response(MainErrorConstant::ERROR_MSG, self::CAPTAIN_FINANCIAL_DUES_WAS_NOT_FOUND);
//
//        } elseif ($result === GeoDistanceResultConstant::DESTINATION_HAS_NULL_VALUE) {
//            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_DESTINATION_HAS_NULL_VALUE);
//        }
//
//        return $this->response($result, self::UPDATE);
//    }
}
