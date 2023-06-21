<?php

namespace App\Controller\Admin\StoreOwnerPreference;

use App\AutoMapping;
use App\Constant\Main\MainErrorConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Controller\BaseController;
use App\Request\Admin\StoreOwnerPreference\StoreOwnerPreferenceCreateByAdminRequest;
use App\Service\Admin\StoreOwnerPreference\AdminStoreOwnerPreferenceService;
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
 * @Route("v1/admin/storeownerpreference/")
 */
class AdminStoreOwnerPreferenceController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private AdminStoreOwnerPreferenceService $adminStoreOwnerPreferenceService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin: create store owner preference by admin
     * @Route("storeownerpreferencebyadmin", name="createStoreOwnerPreferenceByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Preference")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="create new preference for store by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="storeOwnerProfile"),
     *          @OA\Property(type="number", property="subscriptionCostLimit")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns new payment",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Return erorr.",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", description="9157"),
     *          @OA\Property(type="string", property="msg", description="store owner profile not exist! Error."),
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createStoreOwnerPreferenceByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerPreferenceCreateByAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminStoreOwnerPreferenceService->createStoreOwnerPreferenceByAdmin($request);

        if ($result === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::STORE_OWNER_PROFILE_NOT_EXIST);
        }

        return $this->response($result, self::CREATE);
    }
}
