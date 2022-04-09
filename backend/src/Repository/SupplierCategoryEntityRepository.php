<?php

namespace App\Repository;

use App\Entity\SupplierCategoryEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method SupplierCategoryEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SupplierCategoryEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SupplierCategoryEntity[]    findAll()
 * @method SupplierCategoryEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SupplierCategoryEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SupplierCategoryEntity::class);
    }
}
