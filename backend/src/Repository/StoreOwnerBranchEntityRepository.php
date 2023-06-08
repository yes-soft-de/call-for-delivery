<?php

namespace App\Repository;

use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Entity\ImageEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method StoreOwnerBranchEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StoreOwnerBranchEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StoreOwnerBranchEntity[]    findAll()
 * @method StoreOwnerBranchEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StoreOwnerBranchEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StoreOwnerBranchEntity::class);
    }

    public function getActiveBranchesByStoreOwnerId($storeOwnerId): ?array
    {
        return $this->createQueryBuilder('storeOwnerBranch')
            ->select('storeOwnerBranch.id', 'storeOwnerBranch.name', 'storeOwnerBranch.city', 'storeOwnerBranch.location', 'storeOwnerBranch.isActive', 'storeOwnerBranch.branchPhone')

            ->andWhere('storeOwnerBranch.storeOwner = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->andWhere('storeOwnerBranch.isActive = :active')
            ->setParameter('active', StoreOwnerBranch::BRANCH_IS_ACTIVE)

            ->orderBy('storeOwnerBranch.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function getAllStoreBranchesByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->createQueryBuilder('storeOwnerBranch')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = storeOwnerBranch.storeOwner'
            )

            ->andWhere('storeOwnerProfileEntity.storeOwnerId = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->getQuery()
            ->getResult();
    }

    /**
     * Get array of branch id, branch name, store id. store name, and store profile image for admin
     */
    public function getBranchesForAdmin(): array
    {
        return $this->createQueryBuilder('storeOwnerBranchEntity')
            ->select('storeOwnerBranchEntity.id as storeBranchId', 'storeOwnerBranchEntity.name as storeBranchName')
            ->addSelect('storeOwnerProfileEntity.id as id', 'storeOwnerProfileEntity.storeOwnerName', 'storeOwnerProfileEntity.images')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = storeOwnerBranchEntity.storeOwner'
            )

            ->getQuery()
            ->getResult();
    }

    public function getStoreBranchesNamesByIdArray(array $branchesId): array
    {
        return $this->createQueryBuilder('storeOwnerBranchEntity')
            ->select('storeOwnerBranchEntity.id', 'storeOwnerBranchEntity.name')

            ->where('storeOwnerBranchEntity.id IN (:branchesIdArray)')
            ->setParameter('branchesIdArray', $branchesId)

            ->getQuery()
            ->getResult();
    }
}
