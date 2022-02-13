<?php

namespace App\Controller\StoreOwner;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Controller\BaseController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use App\Service\StoreOwner\StoreOwnerProfileService;
use Symfony\Component\HttpFoundation\Request;
use stdClass;
use App\Request\User\UserRegisterRequest;
use Symfony\Component\HttpFoundation\Response;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Nelmio\ApiDocBundle\Annotation\Security;
use App\Request\StoreOwner\StoreOwnerProfileUpdateRequest;
class StoreOwnerProfileController extends BaseController
{
    private $storeOwnerProfileService;

    public function __construct( AutoMapping $autoMapping, SerializerInterface $serializer, ValidatorInterface $validator, StoreOwnerProfileService $storeOwnerProfileService)
    {
        parent::__construct($serializer);
        $this->storeOwnerProfileService = $storeOwnerProfileService;
        $this->validator = $validator;
        $this->autoMapping = $autoMapping;

    }

    /**
     * Create new store .
     * @Route("storeownerregister", name="storeOwnerRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     * *
     * @OA\Tag(name="Store Owner Profile")
     *
     * @OA\RequestBody(
     *      description="Create new store owner",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="userName"),
     *          @OA\Property(type="string", property="userID"),
     *          @OA\Property(type="string", property="password"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the new store owner's role and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="array", property="roles",
     *                      @OA\Items(example="user")),
     *                  @OA\Property(type="object", property="createdAt")
     *          )
     *      )
     * )
     *
     */
    public function storeOwnerRegister(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        
        $request = $this->autoMapping->map(stdClass::class, UserRegisterRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->storeOwnerRegister($request);
        if($response->found == 1)
        {
            return $this->response($response, self::ERROR_USER_FOUND);
        }

        return $this->response($response, self::CREATE);
    }

    /**
     * store: Update store profile.
     * @Route("/storeowner", name="storeOwnerProfileUpdate", methods={"PUT"})
     * @IsGranted("ROLE_OWNER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Store Owner Profile")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Update Store Owner Profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="storeOwnerName"),
     *          @OA\Property(type="string", property="image"),
     *          @OA\Property(type="string", property="phone"),
     *          @OA\Property(type="string", property="openingTime"),
     *          @OA\Property(type="string", property="closingTime"),
     *          @OA\Property(type="string", property="bankName"),
     *          @OA\Property(type="string", property="bankAccountNumber"),
     *          @OA\Property(type="string", property="stcPay"),
     *          @OA\Property(type="integer", property="employeeCount"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the store owner's profile",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="storeOwnerName"),
     *              @OA\Property(type="string", property="image"),
     *              @OA\Property(type="string", property="phone"),
     *              @OA\Property(type="integer", property="storeCategoryId"),
     *              @OA\Property(type="boolean", property="privateOrders"),
     *              @OA\Property(type="boolean", property="hasProducts"),
     *              @OA\Property(type="string", property="branchName"),
     *              @OA\Property(type="string", property="openingTime"),
     *              @OA\Property(type="string", property="closingTime"),
     *              @OA\Property(type="object", property="location",
     *                   @OA\Property(type="string", property="lat"),
     *                   @OA\Property(type="string", property="lon")
     *
     *          )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function storeOwnerProfileUpdate(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, StoreOwnerProfileUpdateRequest::class, (object)$data);
        $request->setUserID($this->getUserId());

        $violations = $this->validator->validate($request);
        if(\count($violations) > 0)
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->storeOwnerProfileService->storeOwnerProfileUpdate($request);
        return $this->response($response, self::UPDATE);
    }

}
