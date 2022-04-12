<?php

namespace App\Controller\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Controller\BaseController;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursCreateRequest;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursService;
use Nelmio\ApiDocBundle\Annotation\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use OpenApi\Annotations as OA;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursUpdateRequest;

/**
 * Create and fetch Captain's Financial System According To Count Of Hours.
 * @Route("v1/admin/captainfinancialsystemaccordingtocountofhoursbyadmin/")
 */
class AdminCaptainFinancialSystemAccordingToCountOfHoursController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private AdminCaptainFinancialSystemAccordingToCountOfHoursService $adminCaptainFinancialSystemAccordingToCountOfHoursService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, AdminCaptainFinancialSystemAccordingToCountOfHoursService $adminCaptainFinancialSystemAccordingToCountOfHoursService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminCaptainFinancialSystemAccordingToCountOfHoursService = $adminCaptainFinancialSystemAccordingToCountOfHoursService;
    }

    /**
     * admin:Create New Captain's Financial System According To Count Of Hours
     * @Route("captainfinancialsystemaccordingtocountofhoursbyadmin", name="createCaptainFinancialSystemAccordingToCountOfHoursByAdmin", methods={"POST"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain's Financial System According To Count Of Hours")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="new Captain's Financial System According To Count Of Hours",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="countHours"),
     *          @OA\Property(type="number", property="compensationForEveryOrder"),
     *          @OA\Property(type="number", property="salary"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns Captain's Financial System According To Count Of Hours",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="integer", property="countHours"),
     *          @OA\Property(type="number", property="compensationForEveryOrder"),
     *          @OA\Property(type="number", property="salary"),
     *      )
     *   )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function createCaptainFinancialSystemAccordingToCountOfHours(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCaptainFinancialSystemAccordingToCountOfHoursCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainFinancialSystemAccordingToCountOfHoursService->createCaptainFinancialSystemAccordingToCountOfHours($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * admin:Get all Captain's Financial System According To Count Of Hours.
     * @Route("captainfinancialsystemaccordingtocountofhoursbyadmin", name="getAllCaptainFinancialSystemAccordingToCountOfHoursByAdmin", methods={"GET"})
     * @IsGranted("ROLE_ADMIN")
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain's Financial System According To Count Of Hours")
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
     *      description="Returns Captain's Financial System According To Count Of Hours",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="array", property="Data",
     *           @OA\Items(
     *               @OA\Property(type="integer", property="id"),
     *               @OA\Property(type="integer", property="countHours"),
     *               @OA\Property(type="number", property="compensationForEveryOrder"),
     *               @OA\Property(type="number", property="salary"),
     *          )
     *       )
     *    )
     * )
     *
     * @Security(name="Bearer")
     */
    public function getAllCaptainFinancialSystemAccordingToCountOfHours(): JsonResponse
    {
        $result = $this->adminCaptainFinancialSystemAccordingToCountOfHoursService->getAllCaptainFinancialSystemAccordingToCountOfHours();

        return $this->response($result, self::FETCH);
    }

     /**
     * admin:Update Captain's Financial System According To Count Of Hours
     * @Route("captainfinancialsystemaccordingtocountofhoursbyadmin", name="updateCaptainFinancialSystemAccordingToCountOfHoursByAdmin", methods={"PUT"})
     * @IsGranted("ROLE_ADMIN")
     * @param Request $request
     * @return JsonResponse
     *
     * @OA\Tag(name="Captain's Financial System According To Count Of Hours")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="update Captain's Financial System According To Count Of Hours",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="integer", property="countHours"),
     *          @OA\Property(type="number", property="compensationForEveryOrder"),
     *          @OA\Property(type="number", property="salary"),
     *      )
     * )
     *
     * @OA\Response(
     *      response=201,
     *      description="Returns Captain's Financial System According To Count Of Hours",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="integer", property="countHours"),
     *          @OA\Property(type="number", property="compensationForEveryOrder"),
     *          @OA\Property(type="number", property="salary"),
     *      )
     *   )
     * )
     * 
     * @Security(name="Bearer")
     */
    public function updateCaptainFinancialSystemAccordingToCountOfHours(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCaptainFinancialSystemAccordingToCountOfHoursUpdateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->adminCaptainFinancialSystemAccordingToCountOfHoursService->updateCaptainFinancialSystemAccordingToCountOfHours($request);

        return $this->response($result, self::CREATE);
    }
}
