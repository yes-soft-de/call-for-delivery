<?php

namespace App\Controller\Admin\DeliveryCar;

use App\AutoMapping;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\Admin\DeliveryCar\DeliveryCarCreateRequest;
use App\Service\Admin\DeliveryCar\AdminDeliveryCarService;
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
 * @Route("v1/admin/deliverycar/")
 */
class AdminDeliveryCarController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminDeliveryCarService $adminDeliveryCarService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminDeliveryCarService $adminDeliveryCarService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminDeliveryCarService = $adminDeliveryCarService;
    }

    /**
     * admin: Create new delivery car
     * @Route("deliverycar", name="createDeliveryCarByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
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
     * @OA\RequestBody(
     *      description="create new delivery car by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="carModel"),
     *          @OA\Property(type="string", property="details"),
     *          @OA\Property(type="number", property="deliveryCost")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns new delivery car info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\DeliveryCar\DeliveryCarGetForAdminResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createDeliveryCarByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, DeliveryCarCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminDeliveryCarService->createDeliveryCarByAdmin($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin: get all delivery cars for admin
     * @Route("deliverycarsforadmin", name="fetchAllDeliveryCarsByAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
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
     *                  ref=@Model(type="App\Response\Admin\DeliveryCar\DeliveryCarGetForAdminResponse")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllDeliveryCarsForAdmin(Request $request): JsonResponse
    {
        $result = $this->adminDeliveryCarService->getAllDeliveryCarsForAdmin();

        return $this->response($result, self::FETCH);
    }
}
