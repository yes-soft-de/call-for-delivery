<?php

namespace App\Repository;

use App\Entity\AppFeatureEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method AppFeatureEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method AppFeatureEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method AppFeatureEntity[]    findAll()
 * @method AppFeatureEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AppFeatureEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, AppFeatureEntity::class);
    }

    public function getAppFeatureStatusByAppFeatureName(string $featureName): ?array
    {
        return $this->createQueryBuilder('appFeatureEntity')
            ->select('appFeatureEntity.featureStatus')

            ->andWhere('appFeatureEntity.featureName = :name')
            ->setParameter('name', $featureName)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
