<?php

namespace App\Controller\GeoDistance;

use App\AutoMapping;
use App\Constant\GeoDistance\GeoDistanceResultConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\GeoDistance\GeoDistanceGetRequest;
use App\Service\GeoDistance\GeoDistanceService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use OpenApi\Annotations as OA;

/**
 * @Route("v1/geodistance/")
 */
class GeoDistanceController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private GeoDistanceService $geoDistanceService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, GeoDistanceService $geoDistanceService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->geoDistanceService = $geoDistanceService;
    }

    /**
     * Fetch geo distance between two locations using their lon lat coordinates
     * @Route("geodistance", name="fetchGeoDistanceBetweenTwoLocations", methods={"POST"})
     * @param Request $request
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
     * @OA\RequestBody(
     *      description="fetch geo distance request",
     *      @OA\JsonContent(
     *          @OA\Property(type="number", property="originLat"),
     *          @OA\Property(type="number", property="originLng"),
     *          @OA\Property(type="number", property="destinationLat"),
     *          @OA\Property(type="number", property="destinationLng")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new admin's role and the creation date",
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
    public function updateAdminProfile(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, GeoDistanceGetRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->geoDistanceService->getGeoDistanceBetweenTwoLocations($request);

        if ($response === GeoDistanceResultConstant::BAD_REQUEST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_BAD_REQUEST);
        }

        if ($response === GeoDistanceResultConstant::CONTENT_CAN_NOT_BE_DECODED) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ERROR_CAN_NOT_DECODING_CONTENT);
        }

        return $this->response($response, self::FETCH);
    }
}
