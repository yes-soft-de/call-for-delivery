<?php

namespace App\Controller\Admin\AnnouncementImage;

use App\Constant\Admin\AnnouncementImage\AnnouncementImageResultConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Service\Admin\AnnouncementImage\AdminAnnouncementImageService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("v1/admin/announcementimage/")
 */
class AdminAnnouncementImageController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AdminAnnouncementImageService $adminAnnouncementImageService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin: delete announcement image by id
     * @Route("announcementimage/{id}", name="deleteAnnouncementImageById", methods={"DELETE"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $id
     * @return JsonResponse
     *
     * @OA\Tag(name="Announcement Image")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=401,
     *      description="Returns deleted announcement image info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Notification\AdminNotificationToUser\AnnouncementImageDeleteByAdminResponse")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns no announcement image exist constant",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9500"),
     *          @OA\Property(type="string", property="msg")
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteAnnouncementImageById(int $id): JsonResponse
    {
        $result = $this->adminAnnouncementImageService->deleteAnnouncementImageById($id);

        if ($result === AnnouncementImageResultConstant::ANNOUNCEMENT_IMAGE_NOT_FOUND_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ANNOUNCEMENT_IMAGE_NOT_EXIST_CONST);
        }

        return $this->response($result, self::DELETE);
    }
}
