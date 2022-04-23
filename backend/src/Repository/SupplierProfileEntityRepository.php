<?php

namespace App\Repository;

use App\Constant\ChatRoom\ChatRoomConstant;
use App\Entity\ChatRoomEntity;
use App\Entity\SupplierCategoryEntity;
use App\Entity\SupplierProfileEntity;
use App\Entity\UserEntity;
use App\Request\Admin\SupplierProfile\SupplierProfileFilterByAdminRequest;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
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

    public function getSupplierProfileEntityByUserId(int $userId): SupplierProfileEntity|null
    {
        return $this->createQueryBuilder('supplierProfileEntity')

            ->andWhere('supplierProfileEntity.user = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getSupplierProfileByUserId(int $userId): ?array
    {
        return $this->createQueryBuilder('supplierProfileEntity')
            ->select('supplierProfileEntity.id', 'supplierProfileEntity.phone', 'supplierProfileEntity.supplierName', 'supplierProfileEntity.completeAccountStatus', 'supplierProfileEntity.createdAt',
                'supplierProfileEntity.status', 'supplierProfileEntity.location', 'supplierProfileEntity.bankName', 'supplierProfileEntity.bankAccountNumber', 'supplierProfileEntity.stcPay', 'supplierProfileEntity.supplierCategories')
            ->addSelect('chatRoomEntity.roomId')
            ->addSelect('supplierCategoryEntity.id as supplierCategoryId', 'supplierCategoryEntity.name as supplierCategoryName')

            ->andWhere('supplierProfileEntity.user = :userEntity')
            ->setParameter('userEntity', $userId)

            ->leftJoin(
                ChatRoomEntity::class,
                'chatRoomEntity',
                Join::WITH,
                'chatRoomEntity.userId = supplierProfileEntity.user'
            )

            ->leftJoin(
                SupplierCategoryEntity::class,
                'supplierCategoryEntity',
                Join::WITH,
                'supplierCategoryEntity.id = supplierProfileEntity.supplierCategory'
            )

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

        if ($request->getSupplierCategoryId() !== null) {
            $query->andWhere('supplierProfileEntity.supplierCategory = :supplierCategoryId');
            $query->setParameter('supplierCategoryId', $request->getSupplierCategoryId());
        }

        return $query->getQuery()->getResult();
    }

    public function getCompleteAccountStatusBySupplierId(int $supplierId): ?array
    {
        return $this->createQueryBuilder('supplierProfileEntity')
            ->select('supplierProfileEntity.completeAccountStatus')

            ->andWhere('supplierProfileEntity.user = :user')
            ->setParameter('user', $supplierId)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
