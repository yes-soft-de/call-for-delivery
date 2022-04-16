<?php

namespace App\Controller\AnnouncementOrderDetails;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\AnnouncementOrderDetails\AnnouncementOrderPriceOfferValueUpdateRequest;
use App\Service\AnnouncementOrderDetails\AnnouncementOrderDetailsService;
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
 * @Route("v1/announcementorderdetails/")
 */
class AnnouncementOrderDetailsController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AnnouncementOrderDetailsService $announcementOrderDetailsService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AnnouncementOrderDetailsService $announcementOrderDetailsService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->announcementOrderDetailsService = $announcementOrderDetailsService;
    }

    /**
     * Supplier: update an announcement order details price offer value.
     * @Route("announcementorderdetailspriceoffervalue", name="updateAnnouncementOrderDetailsPriceOfferValueBySupplier", methods={"PUT"})
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
     *      description="update an announcement order details price offer value request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="number", property="priceOfferValue"),
     *          @OA\Property(type="number", property="priceOfferStatus")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the announcement order details info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="object", property="createdAt"),
     *              @OA\Property(type="object", property="updatedAt"),
     *              @OA\Property(type="number", property="priceOfferValue"),
     *              @OA\Property(type="integer", property="priceOfferStatus")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateAnnouncementOrderDetailsPriceOfferValueBySupplier(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AnnouncementOrderPriceOfferValueUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->announcementOrderDetailsService->updateAnnouncementOrderDetailsPriceOfferValueBySupplier($request);

        return $this->response($response, self::UPDATE);
    }
}
