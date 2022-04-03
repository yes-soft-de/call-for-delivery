<?php


namespace App\Manager\Notification;

use App\AutoMapping;
use Doctrine\ORM\EntityManagerInterface;

class NotificationFirebaseManager
{
    private $autoMapping;
    private $entityManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManage)
    {
        $this->autoMapping = $autoMapping;
    }
}
