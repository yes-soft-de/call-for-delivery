<?php

namespace App\Controller\Eraser;

use App\AutoMapping;
use App\Constant\Eraser\EraserResultConstant;
use App\Constant\Main\MainErrorConstant;
use App\Controller\BaseController;
use App\Request\Eraser\DeleteCaptainAccountAndProfileBySuperAdminRequest;
use App\Service\Eraser\EraserService;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\Tools\SchemaTool;
use Nelmio\ApiDocBundle\Annotation\Model;
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
 * @Route("/v1/eraser/")
 */
class EraseController extends BaseController
{
    private AutoMapping $autoMapping;
    private ValidatorInterface $validator;
    private EntityManagerInterface $entityManager;
    private EraserService $eraserService;

    public function __construct(AutoMapping $autoMapping, ValidatorInterface $validator, SerializerInterface $serializer, EntityManagerInterface $entityManager, EraserService $eraserService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->entityManager = $entityManager;
        $this->eraserService = $eraserService;
    }

    /**
     * @Route("dropalltables", name="deleteAllDatabaseTables", methods={"DELETE"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     *
     * @OA\Tag(name="Eraser")
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
     *      description="Returns all data tables were being re-created message",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="401"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data", example="All data tables were being re-created"
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function reCreateNewDatabaseScheme(): JsonResponse
    {
        $entitiesArray = $this->entityManager->getMetadataFactory()->getAllMetadata();

        $tool = new SchemaTool($this->entityManager);

        $tool->dropSchema($entitiesArray);
        $tool->createSchema($entitiesArray);

        if($tool)
        {
            return $this->response("ِAll data tables were being re-created", self::DELETE);
        }
    }

    /**
     * super admin: delete all bid orders and their images and prices offers
     * @Route("deleteallbidordersandrelatedinfo", name="deleteAllBidOrdersAndRelatedInfo", methods={"DELETE"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     *
     * @OA\Tag(name="Eraser")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\Response(
     *      response=401,
     *      description="Returns Bid orders, their images, and their prices offers deleted successfully",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="string", property="Data", example="Bid orders, their images, and their prices offers deleted successfully"
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteAllBidOrdersImagesAndBidOrdersAndPricesOffers(): JsonResponse
    {
        $response = $this->eraserService->deleteAllBidOrdersImagesAndBidOrdersAndPricesOffers();

        return $this->response($response, self::DELETE);
    }

    /**
     * super admin: delete captain account and profile by super admin
     * @Route("deletecaptainprofilebysuperadmin", name="deleteCaptainAccountAndProfileBySuperAdmin", methods={"DELETE"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     *
     * @OA\Tag(name="Eraser")
     *
     * @OA\Parameter(
     *      name="token",
     *      in="header",
     *      description="token to be passed as a header",
     *      required=true
     * )
     *
     * @OA\RequestBody(
     *      description="Create new admin",
     *      @OA\JsonContent(
     *          @OA\Property(type="integer", property="id"),
     *          @OA\Property(type="string", property="password")
     *      )
     * )
     *
     * @OA\Response(
     *      response=401,
     *      description="Returns deleted user info",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              ref=@Model(type="App\Response\Eraser\DeleteCaptainAccountAndProfileBySuperAdminResponse")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function deleteCaptainAccountAndProfileBySuperAdmin(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, DeleteCaptainAccountAndProfileBySuperAdminRequest::class, (object)$data);

        $violations = $this->validator->validate($request);

        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->eraserService->deleteCaptainAccountAndProfileBySuperAdmin($request);

        if ($response === EraserResultConstant::DELETION_USER_PASSWORD_INCORRECT) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::DELETION_USER_PASSWORD_INCORRECT);
        }

        if ($response === EraserResultConstant::CAN_NOT_DELETE_USER_HAS_CASH_ORDER_PAYMENTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAN_NOT_DELETE_USER_HAS_CASH_ORDER_PAYMENTS);
        }

        if ($response === EraserResultConstant::CAN_NOT_DELETE_USER_HAS_ORDERS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAN_NOT_DELETE_USER_HAS_ORDERS);
        }

        if ($response === EraserResultConstant::CAN_NOT_DELETE_USER_HAS_FINANCIAL_DUES) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAN_NOT_DELETE_USER_HAS_FINANCIAL_DUES);
        }

        if ($response === EraserResultConstant::CAN_NOT_DELETE_USER_HAS_PAYMENTS) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAN_NOT_DELETE_USER_HAS_PAYMENTS);
        }

        if ($response === EraserResultConstant::CAN_NOT_DELETE_USER_HAS_PAYMENTS_TO_COMPANY) {
            return $this->response(MainErrorConstant::ERROR_MSG, self::CAN_NOT_DELETE_USER_HAS_PAYMENTS_TO_COMPANY);
        }

        return $this->response($response, self::DELETE);
    }
}
