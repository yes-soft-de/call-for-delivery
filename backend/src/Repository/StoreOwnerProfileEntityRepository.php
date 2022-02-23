<?php

namespace App\Repository;

use App\Constant\StoreOwner\StoreProfileConstant;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
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

    public function getStoreProfileByStoreId($id): mixed
    {
        return $this->createQueryBuilder('profile')

            ->select('profile.id', 'profile.storeOwnerName', 'profile.images', 'profile.status', 'profile.phone', 'profile.openingTime', 'profile.closingTime', 'profile.storeCategoryId', 'profile.commission',
                'profile.bankName', 'profile.bankAccountNumber', 'profile.stcPay', 'profile.employeeCount')
            
            ->andWhere('profile.storeOwnerId = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserProfile($storeOwnerId): mixed
    {
        return $this->createQueryBuilder('profile')

            ->andWhere('profile.storeOwnerId = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getStoreOwnerProfileByStoreOwnerId($storeOwnerId): ?StoreOwnerProfileEntity
    {
        return $this->createQueryBuilder('profile')

            ->andWhere('profile.storeOwnerId = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCompleteAccountStatusByStoreOwnerId($storeOwnerId): ?array
    {
        return $this->createQueryBuilder('storeOwnerProfile')
            ->select('storeOwnerProfile.completeAccountStatus')

            ->andWhere('storeOwnerProfile.storeOwnerId = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getStoreOwnersProfilesByStatusForAdmin(string $storeOwnerProfileStatus): ?array
    {
        $query = $this->createQueryBuilder('storeOwnerProfile')
            ->select('storeOwnerProfile.id', 'storeOwnerProfile.storeOwnerName', 'storeOwnerProfile.storeOwnerId', 'storeOwnerProfile.completeAccountStatus', 'storeOwnerProfile.storeCategoryId', 'storeOwnerProfile.bankAccountNumber',
             'storeOwnerProfile.bankName', 'storeOwnerProfile.city', 'storeOwnerProfile.openingTime', 'storeOwnerProfile.closingTime', 'storeOwnerProfile.commission', 'storeOwnerProfile.employeeCount', 'storeOwnerProfile.phone', 'storeOwnerProfile.roomID',
             'storeOwnerProfile.stcPay', 'storeOwnerProfile.status', 'storeOwnerProfile.images');

        if($storeOwnerProfileStatus === StoreProfileConstant::STORE_OWNER_PROFILE_ACTIVE_STATUS || $storeOwnerProfileStatus === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
            $query->andWhere('storeOwnerProfile.status = :storeOwnerProfileStatus');
            $query->setParameter('storeOwnerProfileStatus', $storeOwnerProfileStatus);

        }

        $query->orderBy('storeOwnerProfile.id', 'DESC');

        return $query->getQuery()->getResult();
    }
}
