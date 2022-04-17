<?php

namespace App\Controller\BidOrder;

use App\AutoMapping;
use App\Constant\Main\MainErrorConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Controller\BaseController;
use App\Request\BidOrder\BidOrderCreateRequest;
use App\Service\BidOrder\BidOrderService;
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
 * @Route("v1/bidorder/")
 */
class BidOrderController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private BidOrderService $bidOrderService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, BidOrderService $bidOrderService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->bidOrderService = $bidOrderService;
    }

    /**
     * store: Create new bid order
     * @Route("bidorder", name="createBidOrderByStoreOwner", methods={"POST"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Bid Order")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create a new bid order request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="title"),
     *          @OA\Property(type="number", property="description"),
     *          @OA\Property(type="string", property="supplierCategory"),
     *          @OA\Property(type="string", property="images")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new bid order info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *               @OA\Property(type="integer", property="id"),
     *               @OA\Property(type="string", property="title"),
     *               @OA\Property(type="string", property="description"),
     *               @OA\Property(type="object", property="createdAt"),
     *               @OA\Property(type="object", property="updatedAt")
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return error.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9151"),
     *          @OA\Property(type="string", property="msg", description="error store inactive Error."),
     *        )
     *     )
     *
     * @Security(name="Bearer")
     */
    public function createBidOrder(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, BidOrderCreateRequest::class, (object)$data);

        $request->setStoreOwnerProfile($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->bidOrderService->createBidOrder($request);

        if ($result === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_STORE_INACTIVE);
        }

        return $this->response($result, self::CREATE);
    }
}
