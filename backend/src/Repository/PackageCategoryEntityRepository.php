<?php

namespace App\Repository;

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
    
    
     /**
     * @return array|null
     */
    public function getAllPackagesCategories(): ?array
    {
        return $this->createQueryBuilder('PackageCategory')
            ->addSelect('PackageCategory.id, PackageCategory.name, PackageCategory.description')
         
            ->getQuery()

            ->getResult();
    }
}
