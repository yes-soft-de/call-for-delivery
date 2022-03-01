<?php

namespace App\Repository;

use App\Entity\StoreOwnerBranchEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
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
            ->select('storeOwnerBranch.id', 'storeOwnerBranch.name', 'storeOwnerBranch.city', 'storeOwnerBranch.location', 'storeOwnerBranch.isActive')

            ->andWhere('storeOwnerBranch.storeOwner = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->andWhere('storeOwnerBranch.isActive = :active')
            ->setParameter('active', 1)

            ->orderBy('storeOwnerBranch.id', 'DESC')

            ->getQuery()
            ->getResult();
    }
}
