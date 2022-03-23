<?php

namespace App\Repository;

use App\Entity\RateEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
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
}
