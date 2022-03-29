<?php

namespace App\Controller\Eraser;

use App\Controller\BaseController;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\Tools\SchemaTool;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("/v1/eraser/")
 */
class EraseController extends BaseController
{
    private EntityManagerInterface $entityManager;

    public function __construct(SerializerInterface $serializer, EntityManagerInterface $entityManager)
    {
        parent::__construct($serializer);
        $this->entityManager = $entityManager;
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
}
