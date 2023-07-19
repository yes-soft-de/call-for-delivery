<?php

namespace App\Command\CaptainFinancialSystem;

use App\Service\CaptainFinancialSystem\CaptainFinancialSystemCommand\CaptainFinancialSystemUpdateCommandService;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class CaptainFinancialSystemUpdateCommand extends Command
{
    protected static $defaultName = 'app:update-captain-financial-system';

    public function __construct(
        private CaptainFinancialSystemUpdateCommandService $captainFinancialSystemUpdateCommandService
    )
    {
        parent::__construct();
    }

    protected function configure()
    {
        $this->setDescription('Updates captain financial system to the default financial system')
            ->setHelp('This command updates the captain financial system to all captains to the fourth one ...');
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        // this method must return an integer number with the "exit status code"
        // of the command. You can also use these constants to make code more readable

        $io = new SymfonyStyle($input, $output);

        $message = "Updating captain financial system, please wait..";

        $output->writeln($message);
        $io->newLine();

        $this->captainFinancialSystemUpdateCommandService->updateAllSelectedCaptainFinancialSystemToDefaultFinancialSystem();

        $io->progressAdvance();

        $io->newLine();

        $message = "Captains financial systems had been successfully!";

        $output->writeln($message);

        $io->newLine();

        return 0;
    }
}
