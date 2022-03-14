<?php

namespace App\Controller\CaptainOffer;

use App\Controller\BaseController;
use App\Service\CaptainOffer\CaptainOfferService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;

/**
 * fetched Captain Offer.
 * @Route("v1/captainoffer/")
 */
class CaptainOfferController extends BaseController
{
    private CaptainOfferService $captainOfferService;

    public function __construct(SerializerInterface $serializer, CaptainOfferService $captainOfferService)
    {
        parent::__construct($serializer);
        $this->captainOfferService = $captainOfferService;
    }

    /**
     * store:Get Captain Offers.
     * @Route("captainoffers", name="getCaptainOffers", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Offer")
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
     *      response=200,
     *      description="Returns captain offers",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *           @OA\Items(
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="integer", property="carCount"),
     *            @OA\Property(type="integer", property="expired"),
     *            @OA\Property(type="number", property="price"),
     *           ),
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCaptainOffers(): JsonResponse
    {
        $result = $this->captainOfferService->getCaptainOffers();
        
        return $this->response($result, self::FETCH);
    }
}
