<?php

namespace App\Command\Image;

use App\Constant\Image\ImageAimConstant;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Request\Image\ImageCreateRequest;
use App\Service\Image\ImageServiceInterface;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class ImageCommand extends Command
{
    protected static $defaultName = 'app:create-image';

    public function __construct(private ImageServiceInterface $imageServiceInterface)
    {
        parent::__construct();
    }

    public function imageData(): ImageCreateRequest
    {
        $imageCreateRequest = new ImageCreateRequest();

        $imageCreateRequest->setImagePath('image/original-image/2022-02-20_09-14-59/613ttygjhfl-ac-sx466-6213ca191a3ef.jpg');
        $imageCreateRequest->setEntityType(ImageEntityTypeConstant::ENTITY_TYPE_ORDER);
        $imageCreateRequest->setUsedAs(ImageAimConstant::IMAGE_AIM_ORDER_IMAGE);
        $imageCreateRequest->setItemId(1);

        return $imageCreateRequest;
    }

    protected function configure()
    {
        $this->setDescription('Create a new image.')
            ->setHelp('This command allows you to create a new image...');
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        // this method must return an integer number with the "exit status code"
        // of the command. You can also use these constants to make code more readable

        $io = new SymfonyStyle($input, $output);

        $message = "Creating a new image, please wait..";
        $output->writeln($message);
        $io->newLine();

        $imageCreateRequest = $this->imageData();

        $this->imageServiceInterface->create($imageCreateRequest);

        $io->progressAdvance();

        $io->newLine();

        $message = "An image had been created successfully!";

        $output->writeln($message);

        $io->newLine();

        return 0;
    }
}
