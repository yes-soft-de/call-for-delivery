<?php

namespace App\Repository\StoreOwner;

use App\Entity\StoreOwnerProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method StoreOwnerProfileEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StoreOwnerProfileEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StoreOwnerProfileEntity[]    findAll()
 * @method StoreOwnerProfileEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StoreOwnerProfileEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StoreOwnerProfileEntity::class);
    }

    public function getStoreProfileByStoreID($id)
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.storeOwnerName', 'profile.image', 'profile.status', 'profile.phone', 'profile.openingTime', 'profile.closingTime', 'profile.storeCategoryId', 'profile.commission', 'profile.bankName', 'profile.bankAccountNumber', 'profile.stcPay')
            
            ->andWhere('profile.storeOwnerID = :id')

            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserProfile($storeOwnerID)
    {
        return $this->createQueryBuilder('profile')

            ->andWhere('profile.storeOwnerID = :storeOwnerID')
            ->setParameter('storeOwnerID', $storeOwnerID)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
