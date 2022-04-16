<?php

namespace App\Controller\Announcement;

use App\AutoMapping;
use App\Constant\Announcement\AnnouncementResultConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\Announcement\AnnouncementCreateRequest;
use App\Request\Announcement\AnnouncementFilterBySupplierRequest;
use App\Request\Announcement\AnnouncementStatusUpdateRequest;
use App\Request\Announcement\AnnouncementUpdateRequest;
use App\Service\Announcement\AnnouncementService;
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
 * @Route("v1/announcement/")
 */
class AnnouncementController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AnnouncementService $announcementService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AnnouncementService $announcementService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->announcementService = $announcementService;
    }

    /**
     * Supplier: Create new announcement.
     * @Route("announcement", name="createNewAnnouncementBySupplier", methods={"POST"})
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
     *      description="Create new announcement",
     *      @OA\JsonContent(
     *          @OA\Property(type="number", property="price"),
     *          @OA\Property(type="number", property="quantity"),
     *          @OA\Property(type="string", property="details"),
     *          @OA\Property(type="array", property="imagesArray",
     *              @OA\Items(
     *                  @OA\Property(type="string", property="image")
     *              )
     *          )
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new announcement info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="number", property="price"),
     *              @OA\Property(type="number", property="quantity"),
     *              @OA\Property(type="string", property="details"),
     *              @OA\Property(type="boolean", property="status"),
     *              @OA\Property(type="object", property="createdAt")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createAnnouncement(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AnnouncementCreateRequest::class, (object)$data);

        $request->setSupplier($this->getUserId());

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->announcementService->createAnnouncement($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * Supplier: update an announcement.
     * @Route("announcement", name="updateAnnouncementBySupplier", methods={"PUT"})
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
     *      description="update an announcement request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="number", property="price"),
     *          @OA\Property(type="number", property="quantity"),
     *          @OA\Property(type="string", property="details"),
     *          @OA\Property(type="array", property="images",
     *              @OA\Items(
     *                  @OA\Property(type="string", property="image")
     *              )
     *          )
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the announcement info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="number", property="price"),
     *              @OA\Property(type="number", property="quantity"),
     *              @OA\Property(type="string", property="details"),
     *              @OA\Property(type="boolean", property="status"),
     *              @OA\Property(type="object", property="createdAt")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns announcement does not exist message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9440"),
     *          @OA\Property(type="string", property="msg", example="announcement does not exist Error.")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateAnnouncement(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AnnouncementUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->announcementService->updateAnnouncement($request);

        if ($response === AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ANNOUNCEMENT_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * Supplier: update an announcement status.
     * @Route("announcementstatus", name="updateAnnouncementStatusBySupplier", methods={"PUT"})
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
     *      description="update an announcement status request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="boolean", property="status")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the announcement info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="number", property="price"),
     *              @OA\Property(type="number", property="quantity"),
     *              @OA\Property(type="string", property="details"),
     *              @OA\Property(type="boolean", property="status"),
     *              @OA\Property(type="object", property="createdAt")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns announcement does not exist message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9440"),
     *          @OA\Property(type="string", property="msg", example="announcement does not exist Error.")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateAnnouncementStatus(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AnnouncementStatusUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->announcementService->updateAnnouncementStatus($request);

        if ($response === AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ANNOUNCEMENT_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * Supplier: filter his/her announcements.
     * @Route("filterannouncements", name="filterSupplierAnnouncementsBySupplier", methods={"POST"})
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
     *      description="update an announcement status request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="string", property="status"),
     *          @OA\Property(type="string", property="administrationStatus")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the announcement info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="number", property="price"),
     *                  @OA\Property(type="number", property="quantity"),
     *                  @OA\Property(type="string", property="details"),
     *                  @OA\Property(type="boolean", property="status"),
     *                  @OA\Property(type="boolean", property="administrationStatus"),
     *                  @OA\Property(type="object", property="createdAt"),
     *                  @OA\Property(type="boolean", property="updatedAt"),
     *                  @OA\Property(type="object", property="images",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  )
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterAnnouncementsBySupplier(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AnnouncementFilterBySupplierRequest::class, (object)$data);

        $request->setSupplierId($this->getUserId());

        $response = $this->announcementService->filterAnnouncementsBySupplier($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * Supplier: fetch other suppliers announcements
     * @Route("otherannouncements", name="getOtherSuppliersAnnouncementsBySupplier", methods={"GET"})
     * @IsGranted("ROLE_SUPPLIER")
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
     * @OA\Response(
     *      response=200,
     *      description="Returns other existing suppliers announcements info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="number", property="quantity"),
     *                  @OA\Property(type="string", property="details"),
     *                  @OA\Property(type="boolean", property="status"),
     *                  @OA\Property(type="boolean", property="administrationStatus"),
     *                  @OA\Property(type="object", property="createdAt"),
     *                  @OA\Property(type="boolean", property="updatedAt"),
     *                  @OA\Property(type="object", property="images",
     *                      @OA\Property(type="string", property="imageURL"),
     *                      @OA\Property(type="string", property="image"),
     *                      @OA\Property(type="string", property="baseURL"),
     *                  )
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getOtherSuppliersAnnouncementBySupplier(): JsonResponse
    {
        $response = $this->announcementService->getOtherSuppliersAnnouncementBySupplier($this->getUserId());

        return $this->response($response, self::FETCH);
    }
}