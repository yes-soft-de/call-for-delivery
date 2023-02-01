<?php

namespace App\Controller\Admin\DirectSupportScript;

use App\AutoMapping;
use App\Constant\Admin\AdminProfileConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptCreateByAdminRequest;
use App\Service\Admin\DirectSupportScript\AdminDirectSupportScriptService;
use Nelmio\ApiDocBundle\Annotation\Model;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

/**
 * @Route("v1/admin/directsupportscript/")
 */
class AdminDirectSupportScriptController extends BaseController
{
    public function __construct(
        SerializerInterface $serializer,
        private AutoMapping $autoMapping,
        private ValidatorInterface $validator,
        private AdminDirectSupportScriptService $adminDirectSupportScriptService
    )
    {
        parent::__construct($serializer);
    }

    /**
     * admin: create direct support script by admin
     * @Route("directsupportscript", name="createDirectSupportScriptByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
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
     *      description="create new script for direct support by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="action"),
     *          @OA\Property(type="string", property="message"),
     *          @OA\Property(type="integer", property="appType"),
     *          @OA\Property(type="integer", property="adminProfile")
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns the newly created script of the direct support",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\DirectSupportScript\DirectSupportScriptCreateByAdminResponse")
     *      )
     *   )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response=200,
     *      description="Return error.",
     *      @OA\JsonContent(
     *          oneOf={
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9410"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function createDirectSupportScriptByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, DirectSupportScriptCreateByAdminRequest::class, (object) $data);

        $request->setAdminProfile($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminDirectSupportScriptService->createDirectSupportScriptByAdmin($request);

        if ($result === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ADMIN_PROFILE_NOT_EXIST);
        }

        return $this->response($result, self::CREATE);
    }
}
