<?php

namespace App\Repository;

use App\Entity\PackageEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\NonUniqueResultException;
use Doctrine\Persistence\ManagerRegistry;
use App\Constant\Package\PackageConstant;

/**
 * @method PackageEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method PackageEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method PackageEntity[]    findAll()
 * @method PackageEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class PackageEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, PackageEntity::class);
    }

    /**
     * @return mixed
     */
    public function getActivePackages(): mixed
    {
        return $this->createQueryBuilder('package')
            ->select('package.id, package.name, package.cost, package.note, package.carCount, package.orderCount, 
            package.status, package.city, package.expired')

            ->andWhere("package.status = :status")
            
            ->setParameter('status',PackageConstant::PACKAGE_ACTIVE)
            
            ->getQuery()
            ->getResult();
    }

    /**
     * @return mixed
     */
    public function getAllPackages(): mixed
    {
        return $this->createQueryBuilder('package')
            ->select('package.id, package.name, package.cost, package.note, package.carCount, package.orderCount,
                      package.status, package.city, package.expired')
            ->getQuery()
            ->getResult();
    }

    /**
     * @param $id
     * @return mixed
     * @throws NonUniqueResultException
     */
    public function getPackageById($id): mixed
    {
        return $this->createQueryBuilder('package')
            ->select('package.id, package.name, package.cost, package.note, package.carCount, package.orderCount,
                      package.status, package.city, package.expired')

            ->andWhere("package.id = :id")
            
            ->setParameter('id',$id)
            
            ->getQuery()
            ->getOneOrNullResult();
    }

}
