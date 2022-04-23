<?php

namespace App\Controller\DeliveryCar;

use App\Controller\BaseController;
use App\Service\DeliveryCar\DeliveryCarService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("v1/deliverycar/")
 */
class DeliverCarController extends BaseController
{
    private DeliveryCarService $deliveryCarService;

    public function __construct(SerializerInterface $serializer, DeliveryCarService $deliveryCarService)
    {
        parent::__construct($serializer);
        $this->deliveryCarService = $deliveryCarService;
    }

    /**
     * supplier: get all delivery cars for supplier
     * @Route("deliverycars", name="fetchAllDeliveryCarsBySupplier", methods={"GET"})
     * @IsGranted("ROLE_SUPPLIER")
     * @return JsonResponse
     *
     * @OA\Tag(name="Delivery Car")
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
     *      description="Returns all delivery cars info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\DeliveryCar\DeliveryCarGetResponse")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllDeliveryCarsForSupplier(): JsonResponse
    {
        $result = $this->deliveryCarService->getAllDeliveryCarsForSupplier();

        return $this->response($result, self::FETCH);
    }
}
