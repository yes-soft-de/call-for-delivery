<?php

namespace App\Repository;

use App\Entity\SupplierProfileEntity;
use App\Request\Admin\SupplierProfile\SupplierProfileFilterByAdminRequest;
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

    public function getSupplierProfileByUserId(int $userId): SupplierProfileEntity|null
    {
        return $this->createQueryBuilder('supplierProfileEntity')

            ->andWhere('supplierProfileEntity.user = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function filterSupplierProfileByAdmin(SupplierProfileFilterByAdminRequest $request): array
    {
        $query = $this->createQueryBuilder('supplierProfileEntity')

            ->orderBy('supplierProfileEntity.id', 'DESC');

        if ($request->getSupplierName() != null || $request->getSupplierName() != "") {
            $query->andWhere('supplierProfileEntity.supplierName LIKE :name');
            $query->setParameter('name', '%'.$request->getSupplierName().'%');
        }

        if ($request->getPhone() != null || $request->getPhone() != "") {
            $query->andWhere('supplierProfileEntity.phone LIKE :phone');
            $query->setParameter('phone', '%'.$request->getPhone().'%');
        }

        if ($request->getStatus() !== null) {
            $query->andWhere('supplierProfileEntity.status = :status');
            $query->setParameter('status', $request->getStatus());
        }

        return $query->getQuery()->getResult();
    }
}
