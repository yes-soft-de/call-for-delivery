<?php

namespace App\Controller\Admin\CaptainOffer;

use App\AutoMapping;
use App\Constant\CaptainOffer\CaptainOfferConstant;
use App\Controller\BaseController;
use App\Request\Admin\CaptainOffer\CaptainOfferCreateRequest;
use App\Request\Admin\CaptainOffer\CaptainOfferUpdateRequest;
use App\Service\Admin\CaptainOffer\AdminCaptainOfferService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use OpenApi\Annotations as OA;

/**
 * admin :Create Captain Offer.
 * @Route("v1/admin/captainoffer/")
 */
class AdminCaptainOfferController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminCaptainOfferService $adminCaptainOfferService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminCaptainOfferService $adminCaptainOfferService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminCaptainOfferService = $adminCaptainOfferService;
    }

    /**
     * admin:Create Captain Offer By Admin.
     * @Route("create", name="createCaptainOfferByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
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
     * @OA\RequestBody(
     *      description="new captain offer create request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="carCount"),
     *          @OA\Property(type="string", property="status"),
     *          @OA\Property(type="integer", property="expired"),
     *          @OA\Property(type="number", property="price"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns new captain offer create",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="integer", property="carCount"),
     *            @OA\Property(type="string", property="status"),
     *           @OA\Property(type="integer", property="expired"),
     *           @OA\Property(type="number", property="price"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createCaptainOfferByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, CaptainOfferCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);

        }
         
        $result = $this->adminCaptainOfferService->createCaptainOfferByAdmin($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin:Update Captain Offer By Admin.
     * @Route("update", name="updateCaptainOfferByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
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
     * @OA\RequestBody(
     *      description="captain offer request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="integer", property="carCount"),
     *          @OA\Property(type="string", property="status"),
     *          @OA\Property(type="integer", property="expired"),
     *          @OA\Property(type="number", property="price"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns captain offer",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="integer", property="carCount"),
     *            @OA\Property(type="string", property="status"),
     *           @OA\Property(type="integer", property="expired"),
     *           @OA\Property(type="number", property="price"),
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateCaptainOfferByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, CaptainOfferUpdateRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainOfferService->updateCaptainOfferByAdmin($request);

        if($result === CaptainOfferConstant::CAPTAIN_OFFER_NOT_EXIST) {

            return $this->response($result, self::CAPTAIN_OFFER_NOT_EXIST);
        }
        
        return $this->response($result, self::UPDATE);
        }

    /**
     * admin:Get Captain Offers By Admin.
     * @Route("captainoffers", name="getCaptainOffersByAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
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
     *            @OA\Property(type="string", property="status"),
     *            @OA\Property(type="integer", property="expired"),
     *            @OA\Property(type="number", property="price"),
     *           ),
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCaptainOffersByAdmin(): JsonResponse
    {
        $result = $this->adminCaptainOfferService->getCaptainOffersByAdmin();
        
        return $this->response($result, self::FETCH);
    }

    /**
     * admin:Get Captain Offer By Admin.
     * @Route("captainoffer/{id}", name="getCaptainOfferByAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
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
     *      description="Returns captain offer",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *            @OA\Property(type="integer", property="id"),
     *            @OA\Property(type="integer", property="carCount"),
     *            @OA\Property(type="string", property="status"),
     *            @OA\Property(type="integer", property="expired"),
     *            @OA\Property(type="number", property="price"),
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCaptainOfferByAdmin($id): JsonResponse
    {
        $result = $this->adminCaptainOfferService->getCaptainOfferByAdmin($id);
        
        return $this->response($result, self::FETCH);
    }
}
