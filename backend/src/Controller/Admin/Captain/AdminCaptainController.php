<?php

namespace App\Controller\Admin\Captain;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Service\Admin\Captain\AdminCaptainService;
use OpenApi\Annotations as OA;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

/**
 * @Route("v1/admin/captain/")
 */
class AdminCaptainController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminCaptainService $adminCaptainService;

    public function __construct( AutoMapping $autoMapping, SerializerInterface $serializer, ValidatorInterface $validator, AdminCaptainService $adminCaptainService)
    {
        parent::__construct($serializer);
        $this->adminCaptainService = $adminCaptainService;
        $this->validator = $validator;
        $this->autoMapping = $autoMapping;
    }

    /**
     * admin: Get captains' profiles by status.
     * @Route("captainsprofilesbystatus/{captainProfileStatus}", name="getCaptainProfilesByStatusForAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @param string $captainProfileStatus
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain Profile")
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
     *      description="Returns captains' profiles which corresponding with the passed status",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  @OA\Property(type="integer", property="id"),
     *                  @OA\Property(type="string", property="captainName"),
     *                  @OA\Property(type="object", property="location"),
     *                  @OA\Property(type="string", property="age"),
     *                  @OA\Property(type="string", property="car"),
     *                  @OA\Property(type="string", property="city"),
     *                  @OA\Property(type="number", property="salary"),
     *                  @OA\Property(type="string", property="status"),
     *                  @OA\Property(type="number", property="bounce"),
     *                  @OA\Property(type="string", property="phone"),
     *                  @OA\Property(type="string", property="bankName"),
     *                  @OA\Property(type="string", property="bankAccountNumber"),
     *                  @OA\Property(type="string", property="stcPay"),
     *                  @OA\Property(type="string", property="images"),
     *                  @OA\Property(type="boolean", property="isOnline"),
     *                  @OA\Property(type="string", property="mechanicLicense"),
     *                  @OA\Property(type="string", property="identity"),
     *                  @OA\Property(type="string", property="roomId")
     *              )
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getCaptainsProfilesByStatusForAdmin(string $captainProfileStatus): JsonResponse
    {
        $response = $this->adminCaptainService->getCaptainsProfilesByStatusForAdmin($captainProfileStatus);

        return $this->response($response, self::FETCH);
    }
}
