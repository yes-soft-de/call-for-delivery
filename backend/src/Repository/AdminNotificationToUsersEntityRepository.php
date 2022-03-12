<?php

namespace App\Repository;

use App\Entity\AdminNotificationToUsersEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Constant\Notification\NotificationConstant;

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
    
    public function getAllNotificationsForAdmin(): ?array
     {   
        return $this->createQueryBuilder('adminNotification')
            ->select('adminNotification.id' ,'adminNotification.title', 'adminNotification.msg', 'adminNotification.appType',
            'adminNotification.createdAt', 'adminNotification.updatedAt', 'adminNotification.userId')
            
            ->andWhere('adminNotification.userId = :userIdNull')
            ->setParameter('userIdNull', NotificationConstant::USER_ID_NULL)

            ->getQuery()

            ->getResult();
     }
    
    public function getAllNotificationsFromAdminForStore($userId, $appType): ?array
     {   
        return $this->createQueryBuilder('adminNotification')
            ->select('adminNotification.id' ,'adminNotification.title', 'adminNotification.msg', 'adminNotification.createdAt', 'adminNotification.updatedAt')
            
            ->where('adminNotification.userId = :userId')
            ->orWhere('adminNotification.appType = :appType')
           
            ->setParameter('userId', $userId)
            ->setParameter('appType', $appType)

            ->getQuery()

            ->getResult();
     }
}
