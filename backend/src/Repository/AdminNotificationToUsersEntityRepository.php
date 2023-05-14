<?php

namespace App\Repository;

use App\Entity\AdminNotificationToUsersEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method AdminNotificationToUsersEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method AdminNotificationToUsersEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method AdminNotificationToUsersEntity[]    findAll()
 * @method AdminNotificationToUsersEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AdminNotificationToUsersEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, AdminNotificationToUsersEntity::class);
    }
}
