<?php

namespace App\Controller\Main;

use App\Controller\BaseController;
use App\Service\Main\MainService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use OpenApi\Annotations as OA;

/**
 * @Route("v1/main/")
 */
class MainController extends BaseController
{
    private $mainService;

    public function __construct(SerializerInterface $serializer, MainService $mainService)
    {
        parent::__construct($serializer);
        $this->mainService = $mainService;
    }

    /**
     * check backend health.
     * @Route("checkbackendhealth", name="checkBackendHealth", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Main")
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
     *      description="Returns the new admin's role and the creation date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="string", property="result"),
     *                  @OA\Property(type="string", property="userRole")
     *          )
     *      )
     * )
     */
    public function checkBackendHealth(): JsonResponse
    {
        $response = $this->mainService->checkBackendHealth($this->getUserId());

        return $this->response($response, self::FETCH);
    }
}
