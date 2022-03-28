<?php

namespace App\Controller\Commander;

use App\Controller\BaseController;
use Exception;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Bundle\FrameworkBundle\Console\Application;
use Symfony\Component\Console\Input\ArrayInput;
use Symfony\Component\Console\Output\BufferedOutput;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\KernelInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

/**
 *  @Route("v1/datacommander/")
 */
class DataCommanderController extends BaseController
{
    public function __construct(SerializerInterface $serializer)
    {
        parent::__construct($serializer);
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
}
