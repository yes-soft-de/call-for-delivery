<?php

namespace App\Repository;

use App\Entity\PackageEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
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

    public function getActivePackages(): ?array
    {
        return $this->createQueryBuilder('package')
            ->select('package.id, package.name, package.cost, package.note, package.carCount, package.orderCount, 
            package.status, package.city, package.expired, package.type, package.geographicalRange, package.extraCost')

            ->andWhere("package.status = :status")
            
            ->setParameter('status',PackageConstant::PACKAGE_ACTIVE)
            
            ->getQuery()
            ->getResult();
    }

    public function getAllPackages(): ?array
    {
        return $this->createQueryBuilder('package')
            ->select('package.id, package.name, package.cost, package.note, package.carCount, package.orderCount,
                      package.status, package.city, package.expired, package.type, package.geographicalRange, package.extraCost')
            ->getQuery()
            ->getResult();
    }

    public function getPackageById(int $id): ?array
    {
        return $this->createQueryBuilder('package')
            ->select('package.id, package.name, package.cost, package.note, package.carCount, package.orderCount,
                      package.status, package.city, package.expired, package.type, package.geographicalRange, package.extraCost')

            ->andWhere("package.id = :id")
            
            ->setParameter('id',$id)
            
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getPackagesByCategoryIdForAdmin(int $packageCategory): ?array
    {
        return $this->createQueryBuilder('package')
            ->select('IDENTITY(package.packageCategory)')
            ->addSelect('package.id, package.name, package.cost, package.note, package.carCount, package.orderCount, package.status, package.city, package.expired, package.type, package.geographicalRange, package.extraCost')

            ->andWhere("package.packageCategory = :packageCategory")
            ->setParameter('packageCategory',$packageCategory)
            
            ->getQuery()
            ->getResult();
    }

    public function getAllPackagesCategoriesAndPackagesForStore(int $packageCategory): ?array
    {
        return $this->createQueryBuilder('package')
            ->select('IDENTITY(package.packageCategory) as packageCategoryId')
            ->addSelect('package.id, package.name, package.cost, package.note, package.carCount, package.orderCount, package.status, package.city, package.expired, package.type, package.geographicalRange, package.extraCost')

            ->andWhere("package.packageCategory = :packageCategory")
            ->andWhere("package.status = :status")
            
            ->setParameter('status',PackageConstant::PACKAGE_ACTIVE)
            ->setParameter('packageCategory',$packageCategory)
            
            ->getQuery()
            ->getResult();
    }

    public function getPackageActiveById(int $id): ?array
    {
        return $this->createQueryBuilder('package')
            ->select('package.id')

            ->where("package.id = :id")
            ->andWhere("package.status = :status")
           
            ->setParameter('id',$id) 
            ->setParameter('status',PackageConstant::PACKAGE_ACTIVE)
            
            ->getQuery()
            ->getOneOrNullResult();
    }
}
