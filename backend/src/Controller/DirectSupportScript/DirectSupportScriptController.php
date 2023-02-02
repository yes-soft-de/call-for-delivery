<?php

namespace App\Controller\DirectSupportScript;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\DirectSupportScript\DirectSupportScriptFilterRequest;
use App\Service\DirectSupportScript\DirectSupportScriptService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("v1/directsupportscript/")
 */
class DirectSupportScriptController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private DirectSupportScriptService $directSupportScriptService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * user: filter direct support scripts by store, captain, or supplier
     * @Route("filterdirectsupportscript", name="filterDirectSupportScriptByUser", methods={"POST"})
     * @IsGranted("ROLE_USER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Direct Support Script")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="filter direct support script by user",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="action"),
     *          @OA\Property(type="integer", property="appType"),
     *          @OA\Property(type="string", property="fromDate"),
     *          @OA\Property(type="string", property="toDate"),
     *          @OA\Property(type="string", property="customizedTimezone", example="Asia/Riyadh")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns script of the direct support",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *              @OA\Items(
     *                  ref=@Model(type="App\Response\Admin\DirectSupportScript\DirectSupportScriptDeleteByAdminResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterDirectSupportScript(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, DirectSupportScriptFilterRequest::class, (object) $data);

        $result = $this->directSupportScriptService->filterDirectSupportScript($request);

        return $this->response($result, self::FETCH);
    }
}
