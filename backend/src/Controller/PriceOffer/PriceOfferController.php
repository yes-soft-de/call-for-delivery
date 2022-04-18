<?php

namespace App\Controller\PriceOffer;

use App\AutoMapping;
use App\Constant\Main\MainMessageConstant;
use App\Controller\BaseController;
use App\Request\PriceOffer\PriceOfferCreateRequest;
use App\Service\PriceOffer\PriceOfferService;
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
     * @OA\Tag(name="Announcement")
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
     *          @OA\Property(type="integer", property="bidOrder"),
     *          @OA\Property(type="number", property="priceOfferValue"),
     *          @OA\Property(type="string", property="offerDeadline")
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

        $this->priceOfferService->createPriceOffer($request);

        return $this->response(MainMessageConstant::CREATED_SUCCESSFULLY_MSG, self::CREATE);
    }
}
