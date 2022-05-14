<?php

namespace App\Repository;

use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Constant\SupplierCategory\SupplierCategoryStatusConstant;
use App\Entity\ImageEntity;
use App\Entity\SupplierCategoryEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
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

    public function getAllSupplierCategoriesForAdmin(): array
    {
        return $this->createQueryBuilder('supplierCategoryEntity')
            ->select('supplierCategoryEntity.id', 'supplierCategoryEntity.name', 'supplierCategoryEntity.description', 'supplierCategoryEntity.status')
            ->addSelect('imageEntity.imagePath as image')

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = supplierCategoryEntity.id AND imageEntity.entityType = :entityType AND imageEntity.usedAs = :usedAs'
            )

            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_SUPPLIER_CATEGORY)
            ->setParameter('usedAs', ImageUseAsConstant::IMAGE_USE_AS_SUPPLIER_CATEGORY)

            ->orderBy('supplierCategoryEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function getAllActiveSupplierCategories(): array
    {
        return $this->createQueryBuilder('supplierCategoryEntity')
            ->select('supplierCategoryEntity.id', 'supplierCategoryEntity.name', 'supplierCategoryEntity.description', 'supplierCategoryEntity.status')
            ->addSelect('imageEntity.imagePath as image')

            ->andWhere('supplierCategoryEntity.status = :activeStatus')
            ->setParameter('activeStatus', SupplierCategoryStatusConstant::ACTIVE_SUPPLIER_CATEGORY_STATUS)

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = supplierCategoryEntity.id AND imageEntity.entityType = :entityType AND imageEntity.usedAs = :usedAs'
            )

            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_SUPPLIER_CATEGORY)
            ->setParameter('usedAs', ImageUseAsConstant::IMAGE_USE_AS_SUPPLIER_CATEGORY)

            ->orderBy('supplierCategoryEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function getAllActiveSupplierCategoriesForStoreOwner(): array
    {
        return $this->createQueryBuilder('supplierCategoryEntity')
            ->select('supplierCategoryEntity.id', 'supplierCategoryEntity.name', 'supplierCategoryEntity.description', 'supplierCategoryEntity.status')
            ->addSelect('imageEntity.imagePath as image')

            ->andWhere('supplierCategoryEntity.status = :activeStatus')
            ->setParameter('activeStatus', SupplierCategoryStatusConstant::ACTIVE_SUPPLIER_CATEGORY_STATUS)

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = supplierCategoryEntity.id AND imageEntity.entityType = :entityType AND imageEntity.usedAs = :usedAs'
            )

            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_SUPPLIER_CATEGORY)
            ->setParameter('usedAs', ImageUseAsConstant::IMAGE_USE_AS_SUPPLIER_CATEGORY)

            ->orderBy('supplierCategoryEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function getAllActiveSupplierCategoriesIDs(): array
    {
        return $this->createQueryBuilder('supplierCategoryEntity')
            ->select('supplierCategoryEntity.id')

            ->andWhere('supplierCategoryEntity.status = :status')
            ->setParameter('status', SupplierCategoryStatusConstant::ACTIVE_SUPPLIER_CATEGORY_STATUS)

            ->orderBy('supplierCategoryEntity.id', 'DESC')

            ->getQuery()
            ->getSingleColumnResult();
    }

    public function getSupplierCategoriesNamesBySupplierCategoriesIDs(array $supplierCategoriesIDs): array
    {
        return $this->createQueryBuilder('supplierCategoryEntity')
            ->select('supplierCategoryEntity.id', 'supplierCategoryEntity.name')

            ->andWhere('supplierCategoryEntity.id IN (:supplierCategoriesIDs)')
            ->setParameter('supplierCategoriesIDs', $supplierCategoriesIDs)

            ->orderBy('supplierCategoryEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }
}
