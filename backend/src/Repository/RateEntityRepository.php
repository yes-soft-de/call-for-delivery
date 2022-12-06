<?php

namespace App\Repository;

use App\Entity\CaptainEntity;
use App\Entity\OrderEntity;
use App\Entity\RateEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\UserEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method RateEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method RateEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method RateEntity[]    findAll()
 * @method RateEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RateEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RateEntity::class);
    }
    
    public function getAverageRating(int $rated): ?float
    {
        return $this->createQueryBuilder('Rating')

               ->select('AVG(Rating.rating) as averageRating')
              
               ->andWhere('Rating.rated = :rated')

               ->setParameter('rated', $rated)

               ->getQuery()
               ->getSingleScalarResult();
    }

    public function getAllRatingsByCaptainProfileIdForAdmin(int $captainProfileId): array
    {
        return $this->createQueryBuilder('rateEntity')
            ->select('rateEntity.id', 'rateEntity.comment', 'rateEntity.rating', 'storeOwnerProfileEntity.storeOwnerName',
                'orderEntity.id as orderId')

            ->leftJoin(
                UserEntity::class,
                'ratedUserEntity',
                Join::WITH,
                'ratedUserEntity.id = rateEntity.rated'
            )

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.captainId = ratedUserEntity.id'
            )

            ->leftJoin(
                UserEntity::class,
                'raterUserEntity',
                Join::WITH,
                'raterUserEntity.id = rateEntity.rater'
            )

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.storeOwnerId = raterUserEntity.id'
            )

            ->leftJoin(
                OrderEntity::class,
                'orderEntity',
                Join::WITH,
                'orderEntity.id = rateEntity.orderId'
            )

            ->andWhere('captainEntity.id = :captainProfileId')
            ->setParameter('captainProfileId', $captainProfileId)

            ->orderBy('rateEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }
}
