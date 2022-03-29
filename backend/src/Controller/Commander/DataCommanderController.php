<?php

namespace App\Controller\Commander;

use App\Controller\BaseController;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\Tools\SchemaTool;
use Exception;
use Nelmio\ApiDocBundle\Annotation\Security;
use OpenApi\Annotations as OA;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Bundle\FrameworkBundle\Console\Application;
use Symfony\Component\Console\Input\ArrayInput;
use Symfony\Component\Console\Output\BufferedOutput;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\KernelInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 *  @Route("v1/datacommander/")
 */
class DataCommanderController extends BaseController
{
    private EntityManagerInterface $entityManager;

    public function __construct(SerializerInterface $serializer, EntityManagerInterface $entityManager)
    {
        parent::__construct($serializer);
        $this->entityManager = $entityManager;
    }

    /**
     * @Route("appendnewdata", name="addNewDataToDB", methods={"POST"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @param KernelInterface $kernel
     * @return Response
     * @throws Exception
     */
    public function appendNewData(KernelInterface $kernel): Response
    {
        $application = new Application($kernel);
        $application->setAutoExit(false);

        $input = new ArrayInput([
            'command' => 'hautelook:fixtures:load',
            // (optional) pass options to the command
            '--append' => true,
        ]);

        // You can use NullOutput() if you don't need the output
        $output = new BufferedOutput();
        $application->run($input, $output);

        // return the output, don't use if you used NullOutput()
        $content = $output->fetch();

        // return new Response(""), if you used NullOutput()
        return new Response($content);
    }

    /**
     * @Route("reenternewdata", name="reenterNewData", methods={"POST"})
     * @IsGranted("ROLE_SUPER_ADMIN")
     * @param KernelInterface $kernel
     * @return Response
     * @throws Exception
     */
    public function createNewData(KernelInterface $kernel): Response
    {
        $application = new Application($kernel);
        $application->setAutoExit(false);

        $input = new ArrayInput([
            'command' => 'hautelook:fixtures:load'
        ]);

        /**
         * running hautelook:fixtures:load asks the following question:
         * Careful, database will be purged. Do you want to continue y/N ?
         * So, to prevent this interaction (in order to run the command correctly) we have to set the following option
         */
        $input->setInteractive(false);

        // You can use NullOutput() if you don't need the output
        $output = new BufferedOutput();
        $application->run($input, $output);

        // return the output, don't use if you used NullOutput()
        $content = $output->fetch();

        // return new Response(""), if you used NullOutput()
        return new Response($content);
    }

    /**
     * @Route("renewdatabasefromscratch", name="deleteAllDatabaseTablesAndInsertNewDate", methods={"POST"})
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
     *      description="Returns messege about successfully new schema was created",
     *      @OA\JsonContent(
     *          @OA\Property(type="string", property="status_code", example="201"),
     *          @OA\Property(type="string", property="msg"),
     *          @OA\Property(type="object", property="Data",
     *              @OA\Property(type="string", property="database"),
     *              @OA\Property(type="string", property="content")
     *          )
     *      )
     * )
     *
     * @Security(name="Bearer")
     */
    public function renewDataBaseFromScratch(KernelInterface $kernel): JsonResponse
    {
        $response = [];

        // First, drop current schema and create a new one
        $entitiesArray = $this->entityManager->getMetadataFactory()->getAllMetadata();

        $tool = new SchemaTool($this->entityManager);

        $tool->dropSchema($entitiesArray);
        $tool->createSchema($entitiesArray);

        if($tool) {
            $response['database'] = "new schema was created";
        }

        // Second, insert fixtures data
        $application = new Application($kernel);
        $application->setAutoExit(false);

        $input = new ArrayInput([
            'command' => 'hautelook:fixtures:load'
        ]);

        $input->setInteractive(false);

        $output = new BufferedOutput();
        $application->run($input, $output);

        $response['content'] = $output->fetch();

        return $this->response($response, self::CREATE);
    }
}
