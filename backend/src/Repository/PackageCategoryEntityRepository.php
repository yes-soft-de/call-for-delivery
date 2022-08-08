<?php

namespace App\Repository;

use App\Constant\Package\PackageCategoryConstant;
use App\Entity\PackageCategoryEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method PackageCategoryEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method PackageCategoryEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method PackageCategoryEntity[]    findAll()
 * @method PackageCategoryEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class PackageCategoryEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, PackageCategoryEntity::class);
    }

    public function getAllPackagesCategories(): ?array
    {
        return $this->createQueryBuilder('PackageCategory')
            ->addSelect('PackageCategory.id, PackageCategory.name, PackageCategory.description', 'PackageCategory.status')
         
            ->getQuery()

            ->getResult();
    }

    public function getAllActivePackagesCategories(): array
    {
        return $this->createQueryBuilder('packageCategory')
            ->addSelect('packageCategory.id, packageCategory.name, packageCategory.description')

            ->andWhere('packageCategory.status = :activeStatus')
            ->setParameter('activeStatus', PackageCategoryConstant::PACKAGE_CATEGORY_ACTIVE_STATUS_CONST)

            ->getQuery()
            ->getResult();
    }
}
