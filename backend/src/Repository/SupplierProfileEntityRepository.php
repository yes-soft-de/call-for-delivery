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

    public function getSupplierProfileByUserId(int $userId): SupplierProfileEntity|null
    {
        return $this->createQueryBuilder('supplierProfileEntity')
//            ->select('IDENTITY (supplierProfileEntity.id) as id', 'supplierProfileEntity.createdAt', 'supplierProfileEntity.supplierName', 'supplierProfileEntity.phone', 'supplierProfileEntity.imageEntities')
//            ->addSelect('imageEntity.imagePath as image')

            ->andWhere('supplierProfileEntity.user = :userId')
            ->setParameter('userId', $userId)

//            ->leftJoin(
//                ImageEntity::class,
//                'imageEntity',
//                Join::WITH,
//                'imageEntity.itemId = supplierProfileEntity.id'
//            )
//
//            ->andWhere('imageEntity.entityType = :entityType AND imageEntity.usedAs = :usedAs')
//            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_SUPPLIER_PROFILE)
//            ->setParameter('usedAs', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
