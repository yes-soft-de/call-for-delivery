<?php

namespace App\Controller\Admin\Announcement;

use App\AutoMapping;
use App\Constant\Announcement\AnnouncementResultConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\Admin\Announcement\AnnouncementAdministrationStatusUpdateRequest;
use App\Request\Admin\Announcement\AnnouncementFilterByAdminRequest;
use App\Service\Admin\Announcement\AdminAnnouncementService;
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
 * @Route("v1/admin/announcement/")
 */
class AdminAnnouncementController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminAnnouncementService $adminAnnouncementService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminAnnouncementService $adminAnnouncementService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminAnnouncementService = $adminAnnouncementService;
    }

    /**
     * admin: update an announcement administration status.
     * @Route("announcementadministrationstatus", name="updateAnnouncementAdministrationStatus", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
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
     *          @OA\Property(type="boolean", property="administrationStatus")
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
     *              @OA\Property(type="boolean", property="administrationStatus"),
     *              @OA\Property(type="object", property="createdAt"),
     *              @OA\Property(type="boolean", property="updatedAt")
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
    public function updateAnnouncementAdministrationStatus(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AnnouncementAdministrationStatusUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminAnnouncementService->updateAnnouncementAdministrationStatus($request);

        if ($response === AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ANNOUNCEMENT_NOT_EXIST);
        }

        return $this->response($response, self::UPDATE);
    }

    /**
     * admin: filter announcements.
     * @Route("filterannouncement", name="filterAnnouncementsByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
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
     *      description="filter announcements by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="integer", property="supplierProfileId"),
     *          @OA\Property(type="integer", property="supplierCategoryId"),
     *          @OA\Property(type="string", property="status"),
     *          @OA\Property(type="string", property="administrationStatus")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns the announcement according to the filtering options",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="integer", property="id"),
     *              @OA\Property(type="number", property="price"),
     *              @OA\Property(type="number", property="quantity"),
     *              @OA\Property(type="string", property="details"),
     *              @OA\Property(type="boolean", property="status"),
     *              @OA\Property(type="boolean", property="administrationStatus"),
     *              @OA\Property(type="object", property="createdAt"),
     *              @OA\Property(type="boolean", property="updatedAt"),
     *              @OA\Property(type="object", property="supplier",
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="supplierName")
     *              ),
     *              @OA\Property(type="object", property="images",
     *                  @OA\Property(type="string", property="imageURL"),
     *                  @OA\Property(type="string", property="image"),
     *                  @OA\Property(type="string", property="baseURL"),
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterAnnouncementsByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AnnouncementFilterByAdminRequest::class, (object)$data);

        $response = $this->adminAnnouncementService->filterAnnouncementsByAdmin($request);

        return $this->response($response, self::FETCH);
    }
}
