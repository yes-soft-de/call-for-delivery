<?php

namespace App\Controller\Admin\Rate;

use App\Controller\BaseController;
use App\Service\Admin\Rate\AdminRateService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("v1/admin/rate/")
 */
class AdminRateController extends BaseController
{
    private AdminRateService $adminRateService;

    public function __construct(SerializerInterface $serializer, AdminRateService $adminRateService)
    {
        parent::__construct($serializer);
        $this->adminRateService = $adminRateService;
    }

    /**
     * admin: get all ratings by captain profile id
     * @Route("captainratingsforadmin/{captainProfileId}", name="getRatingsByCaptainProfileIdForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param int $captainProfileId
     * @return JsonResponse
     *
     * @OA\Tag(name="Rating")
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
     *      description="Returns ratings",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\Rate\RatingsForCaptainGetByAdminResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllRatingsByCaptainProfileIdForAdmin(int $captainProfileId): JsonResponse
    {
        $result = $this->adminRateService->getAllRatingsByCaptainProfileIdForAdmin($captainProfileId);

        return $this->response($result, self::FETCH);
    }
}
