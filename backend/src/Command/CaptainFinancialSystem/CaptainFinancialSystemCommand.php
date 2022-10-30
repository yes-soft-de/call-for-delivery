<?php

namespace App\Command\CaptainFinancialSystem;

use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailInterface;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailService;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class CaptainFinancialSystemCommand extends Command
{
    // This command creates financial cycles for orders (created after 8/19/2022) which do not belong to any financial cycle
    protected static $defaultName = 'app:create-financial-cycles-for-specific-orders';

    private AdminCaptainFinancialSystemDetailService $adminCaptainFinancialSystemDetailService;

    public function __construct(AdminCaptainFinancialSystemDetailInterface $adminCaptainFinancialSystemDetail)
    {
        parent::__construct();
        $this->adminCaptainFinancialSystemDetailService = $adminCaptainFinancialSystemDetail;
    }

    protected function configure()
    {
        $this->setDescription('Create financial cycles for orders which do not belong to any one.')
            ->setHelp('This command allows you to create financial cycles for order which do not belong to any financial cycle...');
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        // this method must return an integer number with the "exit status code"
        // of the command. You can also use these constants to make code more readable

        $io = new SymfonyStyle($input, $output);

        $message = "Creating financial cycles, please wait..";

        $output->writeln($message);
        $io->newLine();

        $this->adminCaptainFinancialSystemDetailService->calculateOrdersThatNotBelongToAnyFinancialDues();

        $io->progressAdvance();

        $io->newLine();

        $message = "Financial cycles had been created successfully!";

        $output->writeln($message);

        $io->newLine();

        return 0;
    }
}
