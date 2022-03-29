<?php

namespace App\Command\SuperAdmin;

use App\Request\Admin\AdminRegisterRequest;
use App\Service\Admin\AdminServiceInterface;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class SuperAdminCommand extends Command
{
    protected static $defaultName = 'app:create-super-admin';

    private AdminServiceInterface $adminService;

    public function __construct(AdminServiceInterface $adminService)
    {
        $this->adminService = $adminService;

        parent::__construct();
    }

    public function superAdminData(): AdminRegisterRequest
    {
        $adminRegisterRequest = new AdminRegisterRequest();

        $adminRegisterRequest->setUserId('superadmin1');
        $adminRegisterRequest->setUserName("superAdmin1");
        $adminRegisterRequest->setPassword('super123Admin');
        $adminRegisterRequest->setRoles(['ROLE_SUPER_ADMIN', 'ROLE_SUPER_USER']);

        return $adminRegisterRequest;
    }

    protected function configure()
    {
        $this->setDescription('Create a new super admin user.')
            ->setHelp('This command allows you to create a new super admin user...');
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        // this method must return an integer number with the "exit status code"
        // of the command. You can also use these constants to make code more readable

        $io = new SymfonyStyle($input, $output);

        $message = "Creating a user with super admin privileges, please wait..";
        $output->writeln($message);
        $io->newLine();

        $superAdminRegisterRequest = $this->superAdminData();

        $this->adminService->adminRegister($superAdminRegisterRequest);

        $io->progressAdvance();

        $io->newLine();

        $message = "Super Admin had been created successfully!";

        $output->writeln($message);

        $io->newLine();

        return 0;
    }
}
