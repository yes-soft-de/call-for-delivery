<?php

namespace App\Controller\Admin\DirectSupportScript;

use App\AutoMapping;
use App\Constant\Admin\AdminProfileConstant;
use App\Constant\DirectSupportScript\DirectSupportScriptResultConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptCreateByAdminRequest;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptDeleteByRequest;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptFilterByAdminRequest;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptUpdateByAdminRequest;
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

    /**
     * admin: update direct support script by admin
     * @Route("directsupportscript", name="updateDirectSupportScriptByAdmin", methods={"PUT"})
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
     *      description="update script for direct support by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="integer", property="action"),
     *          @OA\Property(type="string", property="message"),
     *          @OA\Property(type="integer", property="appType"),
     *          @OA\Property(type="integer", property="adminProfile")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the updated script of the direct support",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\DirectSupportScript\DirectSupportScriptUpdateByAdminResponse")
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
     *                   ),
     *                   @OA\Schema(type="object",
     *                          @OA\Property(type="string", property="status_code", description="9450"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function updateDirectSupportScriptByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, DirectSupportScriptUpdateByAdminRequest::class, (object) $data);

        $request->setAdminProfile($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminDirectSupportScriptService->updateDirectSupportScriptByAdmin($request);

        if ($result === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::ADMIN_PROFILE_NOT_EXIST);

        } elseif ($result === DirectSupportScriptResultConstant::DIRECT_SUPPORT_SCRIPT_NOT_EXIST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::DIRECT_SUPPORT_SCRIPT_NOT_EXIST_CONST);
        }

        return $this->response($result, self::UPDATE);
    }

    /**
     * admin: filter direct support scripts by admin
     * @Route("filterdirectsupportscriptbyadmin", name="filterDirectSupportScriptByAdmin", methods={"POST"})
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
     *      description="filter direct support script by admin request",
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
     *                  ref=@Model(type="App\Response\Admin\DirectSupportScript\DirectSupportScriptFilterByAdminResponse")
     *              )
     *      )
     *   )
     * )
     *
     * @Security(name="Bearer")
     */
    public function filterDirectSupportScriptByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, DirectSupportScriptFilterByAdminRequest::class, (object) $data);

        $result = $this->adminDirectSupportScriptService->filterDirectSupportScriptByAdmin($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * admin: delete direct support script by admin
     * @Route("directsupportscript", name="deleteDirectSupportScriptByAdmin", methods={"DELETE"})
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
     *      description="Delete script for direct support by admin request",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id")
     *      )
     * )
     *
     * @OA\Response(
     *      response=204,
     *      description="Returns the deleted script of the direct support",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Admin\DirectSupportScript\DirectSupportScriptDeleteByAdminResponse")
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
     *                          @OA\Property(type="string", property="status_code", description="9450"),
     *                          @OA\Property(type="string", property="msg")
     *                   )
     *              }
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteDirectSupportScriptByAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, DirectSupportScriptDeleteByRequest::class, (object) $data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminDirectSupportScriptService->deleteDirectSupportScriptByAdmin($request);

        if ($result === DirectSupportScriptResultConstant::DIRECT_SUPPORT_SCRIPT_NOT_EXIST_CONST) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::DIRECT_SUPPORT_SCRIPT_NOT_EXIST_CONST);
        }

        return $this->response($result, self::UPDATE);
    }
}
