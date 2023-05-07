<?php

namespace App\Controller\Maintainer;

use App\Controller\BaseController;
use App\Service\Maintainer\MaintainerService;
use OpenApi\Annotations as OA;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

/**
 * For debugging/testing purposes
 *
 * @Route("v1/maintainer/")
 */
class MaintainerController extends BaseController
{
    public function __construct(
        private MaintainerService $maintainerService
    )
    {
    }

    /**
     * admin:Get Store Owner Dues From Cash Orders.
     * @Route("fetchintvalue", name="getIntegerValueOnly", methods={"GET"})
     * @return JsonResponse
     *
     * @OA\Tag(name="Maintainer")
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns Store Owner Dues From Cash Orders By StoreId and Date",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="integer", property="Data")
     *      )
     * )
     */
    public function getIntValue(): JsonResponse
    {
        $result = $this->maintainerService->getIntValue();

        return $this->response($result, self::FETCH);
    }
}
