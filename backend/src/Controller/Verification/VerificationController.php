<?php

namespace App\Controller\Verification;

use App\AutoMapping;
use App\Constant\Verification\VerificationCodeResultConstant;
use App\Controller\BaseController;
use App\Request\Verification\VerifyCodeRequest;
use App\Service\Verification\VerificationService;
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
 * @Route("v1/verification/")
 */
class VerificationController extends BaseController
{
    private AutoMapping $autoMapping;
    private VerificationService $verificationService;
    private ValidatorInterface $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, VerificationService $verificationService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->verificationService = $verificationService;
        $this->validator = $validator;
    }

    /**
     * @Route("verifycode", name="createVerificationCodeRequest", methods={"POST"})
     * @IsGranted("ROLE_USER")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Verification")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create new verification request",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="code")
     *      )
     * )
     *
     * @OA\Response(
     *      response=200,
     *      description="Returns incorrect entered data message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="9152"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="string", property="resultMessage", description="incorrectEnteredData")
     *          )
     *      )
     * )
     *
     * or
     *
     * @OA\Response(
     *      response="default",
     *      description="Returns activated message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="200"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *                  @OA\Property(type="string", property="resultMessage", description="activated")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     *
     */
    public function checkVerificationCode(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, VerifyCodeRequest::class, (object)$data);

        $request->setUser($this->getUserId());

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->verificationService->checkVerificationCode($request);

        if ($result === VerificationCodeResultConstant::INCORRECT_ENTERED_DATA_RESULT) {
            return $this->response($result, self::INCORRECT_ENTERED_DATA);

        } elseif ($result === VerificationCodeResultConstant::NOT_VALID_CODE_DATE_RESULT) {
            return $this->response($result, self::CODE_DATE_IS_NOT_VALID);

        } elseif ($result === VerificationCodeResultConstant::ACTIVATED_RESULT) {
            return $this->response($result, self::FETCH);
        }
    }
}
