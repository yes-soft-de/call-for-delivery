<?php

namespace App\Repository;

use App\Entity\NotificationFirebaseTokenEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method NotificationFirebaseTokenEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method NotificationFirebaseTokenEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method NotificationFirebaseTokenEntity[]    findAll()
 * @method NotificationFirebaseTokenEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class NotificationFirebaseTokenEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, NotificationFirebaseTokenEntity::class);
    }
    
    public function  getUsersTokensByAppType(int $appType): ?array
    {
        return $this->createQueryBuilder('notificationFirebaseToken')
            ->select('notificationFirebaseToken.id', 'notificationFirebaseToken.token', 'notificationFirebaseToken.appType', 'notificationFirebaseToken.createdAt')

            ->where('notificationFirebaseToken.appType = :appType')

            ->setParameter('appType',$appType)

            ->getQuery()
            ->getResult();
    }
}
