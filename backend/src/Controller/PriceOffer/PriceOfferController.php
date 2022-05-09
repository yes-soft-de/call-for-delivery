<?php

namespace App\Controller\PriceOffer;

use App\AutoMapping;
use App\Constant\Main\MainMessageConstant;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Controller\BaseController;
use App\Request\PriceOffer\PriceOfferCreateRequest;
use App\Request\PriceOffer\PriceOfferStatusUpdateRequest;
use App\Service\PriceOffer\PriceOfferService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Nelmio\ApiDocBundle\Annotation\Model;
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
 * @Route("v1/priceoffer/")
 */
class PriceOfferController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private PriceOfferService $priceOfferService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, PriceOfferService $priceOfferService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->priceOfferService = $priceOfferService;
    }

    /**
     * supplier: create a price offer for a bid order by supplier.
     * @Route("priceoffer", name="createPriceOfferBySupplier", methods={"POST"})
     * @IsGranted("ROLE_SUPPLIER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Price Offer")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create price offer request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="bidDetails"),
     *          @OA\Property(type="number", property="priceOfferValue"),
     *          @OA\Property(type="string", property="offerDeadline"),
     *          @OA\Property(type="integer", property="deliveryCar"),
     *          @OA\Property(type="integer", property="transportationCount")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns created successfully message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg", example="created  successfully")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createPriceOffer(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, PriceOfferCreateRequest::class, (object)$data);

        $request->setSupplierProfile($this->getUserId());

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->priceOfferService->createPriceOffer($request);

        if ($response === SupplierProfileConstant::INACTIVE_SUPPLIER_PROFILE_RESULT) {
            return $this->response(MainMessageConstant::CREATED_SUCCESSFULLY_MSG, self::SUPPLIER_PROFILE_NOT_ACTIVE);
        }

        return $this->response(MainMessageConstant::CREATED_SUCCESSFULLY_MSG, self::CREATE);
    }

    /**
     * store owner: get price offers by bid details id for store owner.
     * @Route("priceoffersbybidorderidforstore/{bidDetailsId}", name="getPriceOffersByBidDetailsIdForStoreOwner", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @param int $bidDetailsId
     * @return JsonResponse
     *
     * @OA\Tag(name="Price Offer")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns created successfully message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\PriceOffer\PriceOfferByBidOrderIdGetForStoreOwnerResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getPriceOffersByBidOrderIdForStoreOwner(int $bidDetailsId): JsonResponse
    {
        $response = $this->priceOfferService->getPriceOffersByBidOrderIdForStoreOwner($bidDetailsId);

        return $this->response($response, self::FETCH);
    }

    /**
     * store owner: update a price offer status by store owner.
     * @Route("priceofferstatus", name="updatePriceOfferStatusByStoreOwner", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Price Offer")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update price offer status request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="priceOfferStatus")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns updated successfully message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\PriceOffer\PriceOfferUpdateResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updatePriceOfferStatusByStoreOwner(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, PriceOfferStatusUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->priceOfferService->updatePriceOfferStatusByStoreOwner($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * supplier: update a price offer status by supplies.
     * @Route("priceofferstatusbysupplier", name="updatePriceOfferStatusBySupplier", methods={"PUT"})
     * @IsGranted("ROLE_SUPPLIER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Price Offer")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update price offer status request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="priceOfferStatus")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns updated successfully message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\PriceOffer\PriceOfferUpdateResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updatePriceOfferStatusBySupplier(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, PriceOfferStatusUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->priceOfferService->updatePriceOfferStatusBySupplier($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("pendingpriceoffer/{id}", name="deletePendingPriceOfferById", methods={"DELETE"})
     * @IsGranted("ROLE_SUPPLIER")
     * @param int $id
     * @return JsonResponse
     *
     * @OA\Tag(name="Price Offer")
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
     *      description="Returns deleted price offers info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\PriceOffer\PriceOfferDeleteResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns Data not found!",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg", example="Data not found!")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deletePendingPriceOfferById(int $id): JsonResponse
    {
        $response = $this->priceOfferService->deletePendingPriceOfferById($id);

        return $this->response($response, self::DELETE);
    }

    /**
     * @Route("deleteallpricesoffers", name="deleteAllPricesOffersBySuperAdmin", methods={"DELETE"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Price Offer")
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
     *      description="Returns deleted prices offers info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\PriceOffer\PriceOfferDeleteResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteAllPricesOffers(): JsonResponse
    {
        $response = $this->priceOfferService->deleteAllPricesOffers();

        return $this->response($response, self::DELETE);
    }
}
