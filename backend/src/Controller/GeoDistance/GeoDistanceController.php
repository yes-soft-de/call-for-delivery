<?php

namespace App\Controller\GeoDistance;

use App\Constant\GeoDistance\GeoDistanceResultConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Service\GeoDistance\GeoDistanceService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;

/**
 * @Route("v1/geodistance/")
 */
class GeoDistanceController extends BaseController
{
    private GeoDistanceService $geoDistanceService;

    public function __construct(SerializerInterface $serializer, GeoDistanceService $geoDistanceService)
    {
        parent::__construct($serializer);
        $this->geoDistanceService = $geoDistanceService;
    }

    /**
     * Fetch geo distance between two locations using their lon lat coordinates
     * @Route("geodistance/{originLat}/{originLng}/{destinationLat}/{destinationLng}", name="fetchGeoDistanceBetweenTwoLocations", methods={"GET"})
     * @param float $originLat
     * @param float $originLng
     * @param float $destinationLat
     * @param float $destinationLng
     * @return JsonResponse
     *
     * @OA\Tag(name="Geo Distance")
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
     *      description="Returns distance info between the two locations",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\GeoDistance\GeoDistanceInfoGetResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns error message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9370|9371"),
     *          @OA\Property(type="string", property="msg")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getGeoDistanceBetweenTwoLocations(float $originLat, float $originLng, float $destinationLat, float $destinationLng): JsonResponse
    {
        $response = $this->geoDistanceService->getGeoDistanceBetweenTwoLocations($originLat, $originLng, $destinationLat, $destinationLng);

        if ($response === GeoDistanceResultConstant::BAD_REQUEST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_BAD_REQUEST);
        }

        if ($response === GeoDistanceResultConstant::CONTENT_CAN_NOT_BE_DECODED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_CAN_NOT_DECODING_CONTENT);
        }

        return $this->response($response, self::FETCH);
    }

    /**
     * store: Fetch cost delivered geo distance between two locations using their lon lat coordinates
     * @Route("geodistanceandcostdelivered/{originLat}/{originLng}/{destinationLat}/{destinationLng}", name="fetchCostDeliveredGeoDistanceBetweenTwoLocations", methods={"GET"})
     * @IsGranted("ROLE_OWNER")
     * @param float $originLat
     * @param float $originLng
     * @param float $destinationLat
     * @param float $destinationLng
     * @return JsonResponse
     *
     * @OA\Tag(name="Geo Distance")
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
     *      description="Returns distance info between the two locations",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\GeoDistance\GeoDistanceInfoGetResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns error message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9370|9371"),
     *          @OA\Property(type="string", property="msg")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function fetchCostDeliveredGeoDistanceBetweenTwoLocationsForStore(float $originLat, float $originLng, float $destinationLat, float $destinationLng): JsonResponse
    {
        $response = $this->geoDistanceService->fetchCostDeliveredGeoDistanceBetweenTwoLocationsForStore($originLat, $originLng, $destinationLat, $destinationLng, $this->getUserId());

        if ($response === GeoDistanceResultConstant::BAD_REQUEST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_BAD_REQUEST);
        }

        if ($response === GeoDistanceResultConstant::CONTENT_CAN_NOT_BE_DECODED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_CAN_NOT_DECODING_CONTENT);
        }

        return $this->response($response, self::FETCH);
    }

    /**
     * admin: Fetch cost delivered geo distance between two locations using their lon lat coordinates
     * @Route("geodistanceandcostdeliveredforadmin/{originLat}/{originLng}/{destinationLat}/{destinationLng}/{storeOwnerProfileId}", name="fetchCostDeliveredGeoDistanceBetweenTwoLocationsForadmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param float $originLat
     * @param float $originLng
     * @param float $destinationLat
     * @param float $destinationLng
     * @param int $storeOwnerProfileId
     * @return JsonResponse
     *
     * @OA\Tag(name="Geo Distance")
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
     *      description="Returns distance info between the two locations",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\GeoDistance\GeoDistanceInfoGetResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns error message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9370|9371"),
     *          @OA\Property(type="string", property="msg")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function fetchCostDeliveredGeoDistanceBetweenTwoLocationsForAdmin(float $originLat, float $originLng, float $destinationLat, float $destinationLng, int $storeOwnerProfileId): JsonResponse
    {
        $response = $this->geoDistanceService->fetchCostDeliveredGeoDistanceBetweenTwoLocationsForAdmin($originLat, $originLng, $destinationLat, $destinationLng, $storeOwnerProfileId);

        if ($response === GeoDistanceResultConstant::BAD_REQUEST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_BAD_REQUEST);
        }

        if ($response === GeoDistanceResultConstant::CONTENT_CAN_NOT_BE_DECODED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_CAN_NOT_DECODING_CONTENT);
        }

        return $this->response($response, self::FETCH);
    }
}
