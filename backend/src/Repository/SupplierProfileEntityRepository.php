<?php

namespace App\Repository;

use App\Entity\SupplierProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method SupplierProfileEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SupplierProfileEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SupplierProfileEntity[]    findAll()
 * @method SupplierProfileEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SupplierProfileEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SupplierProfileEntity::class);
    }
}
