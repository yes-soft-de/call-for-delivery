<?php

namespace App\Command\Order;

use App\Service\SuperAdmin\Order\SuperAdminServiceInterface;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class OrderHasPayConflictAnswersUpdateCommand extends Command
{
    protected static $defaultName = 'app:update-has-pay-conflict-answers';

    private SuperAdminServiceInterface $superAdminService;

    public function __construct(SuperAdminServiceInterface $superAdminService)
    {
        parent::__construct();
        $this->superAdminService = $superAdminService;
    }

    protected function configure()
    {
        $this->setDescription('Update hasPayConflictAnswers field for orders before specific dates.')
            ->setHelp('This command allows you to update hasPayConflictAnswers field...');
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        // this method must return an integer number with the "exit status code"
        // of the command. You can also use these constants to make code more readable

        $io = new SymfonyStyle($input, $output);

        $message = "Updating hasPayConflictAnswers field, please wait..";

        $output->writeln($message);
        $io->newLine();

        $this->superAdminService->updateOrderHasPayConflictAnswersByCommand();

        $io->progressAdvance();

        $io->newLine();

        $message = "hasPayConflictAnswers field had been updated successfully!";

        $output->writeln($message);

        $io->newLine();

        return Command::SUCCESS;
    }
}
