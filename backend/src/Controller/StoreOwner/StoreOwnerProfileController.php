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
}
