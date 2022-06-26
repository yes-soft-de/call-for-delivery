<?php

namespace App\Repository;

use App\Entity\NotificationFirebaseTokenEntity;
use App\Entity\UserEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;
use App\Constant\Notification\NotificationTokenConstant;
use App\Constant\Captain\CaptainConstant;
use App\Entity\CaptainEntity;

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
            ->select('notificationFirebaseToken.id', 'notificationFirebaseToken.token', 'notificationFirebaseToken.appType', 'notificationFirebaseToken.createdAt', 'notificationFirebaseToken.sound')

            ->where('notificationFirebaseToken.appType = :appType')

            ->setParameter('appType',$appType)

            ->getQuery()
            ->getResult();
    }

    public function getTokensByUsersArray(array $usersEntities): array
    {
        return $this->createQueryBuilder('notificationFirebaseToken')
            ->select('notificationFirebaseToken.token')

            ->where('notificationFirebaseToken.user IN (:usersArray)')
            ->setParameter('usersArray', $usersEntities)

            ->getQuery()
            ->getSingleColumnResult();
    }

    public function getTokenByUserAndAppType(int $userId, int $appType): ?NotificationFirebaseTokenEntity
    {
        return $this->createQueryBuilder('notificationFirebaseTokenEntity')

            ->andWhere('notificationFirebaseTokenEntity.user = :userId')
            ->setParameter('userId', $userId)

            ->andWhere('notificationFirebaseTokenEntity.appType = :captainApp')
            ->setParameter('captainApp', $appType)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getTokenByUserId(int $userId): ?NotificationFirebaseTokenEntity
    {
        return $this->createQueryBuilder('notificationFirebaseTokenEntity')

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.id = notificationFirebaseTokenEntity.user'
            )

            ->andWhere('userEntity.id = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function  getCaptainsOnlineTokens(): ?array
    {
        return $this->createQueryBuilder('notificationFirebaseToken')
            ->select('notificationFirebaseToken.id', 'notificationFirebaseToken.token', 'notificationFirebaseToken.appType', 'notificationFirebaseToken.createdAt', 'notificationFirebaseToken.sound')

            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.captainId = notificationFirebaseToken.user')
          
            ->where('notificationFirebaseToken.appType = :appType')
            ->setParameter('appType', NotificationTokenConstant::APP_TYPE_CAPTAIN)

            ->andWhere('captainEntity.isOnline = :isOnline')
            ->setParameter('isOnline', CaptainConstant::CAPTAIN_ONLINE_TRUE)

            ->getQuery()
            ->getResult();
    }

    public function  getTokens(): ?array
    {
        return $this->createQueryBuilder('notificationFirebaseToken')
            ->select('notificationFirebaseToken.id', 'notificationFirebaseToken.token', 'notificationFirebaseToken.appType', 'notificationFirebaseToken.createdAt', 'notificationFirebaseToken.sound')
          
            ->where('notificationFirebaseToken.appType != :appType')
            ->setParameter('appType', NotificationTokenConstant::APP_TYPE_ADMIN)

            ->getQuery()
            ->getResult();
    }
}
