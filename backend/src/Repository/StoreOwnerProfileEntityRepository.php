<?php

namespace App\Repository;

use App\Constant\Order\OrderStateConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Entity\ChatRoomEntity;
use App\Entity\OrderEntity;
use App\Entity\StoreOrderDetailsEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\UserEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\Validator\Constraints\Date;

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
                'profile.bankName', 'profile.bankAccountNumber', 'profile.stcPay', 'profile.employeeCount', 'profile.city', 'profile.storeCategoryId', 'profile.storeCategoryId', 'profile.profitMargin')
            ->addSelect('chatRoomEntity.roomId')
           
            ->leftJoin(ChatRoomEntity::class, 'chatRoomEntity', Join::WITH, 'chatRoomEntity.userId = profile.storeOwnerId')
            
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
            ->addSelect('userEntity.status')

            ->andWhere('storeOwnerProfile.storeOwnerId = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.id = storeOwnerProfile.storeOwnerId'
            )

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getStoreOwnersProfilesByStatusForAdmin(string $storeOwnerProfileStatus): ?array
    {
        $query = $this->createQueryBuilder('storeOwnerProfile')
            ->select('storeOwnerProfile.id', 'storeOwnerProfile.storeOwnerName', 'storeOwnerProfile.storeOwnerId', 'storeOwnerProfile.completeAccountStatus', 'storeOwnerProfile.storeCategoryId', 'storeOwnerProfile.bankAccountNumber',
             'storeOwnerProfile.bankName', 'storeOwnerProfile.city', 'storeOwnerProfile.openingTime', 'storeOwnerProfile.closingTime', 'storeOwnerProfile.commission', 'storeOwnerProfile.employeeCount', 'storeOwnerProfile.phone', 'storeOwnerProfile.roomID',
             'storeOwnerProfile.stcPay', 'storeOwnerProfile.status', 'storeOwnerProfile.images')
            ->addSelect('userEntity.userId', 'userEntity.verificationStatus')

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.id = storeOwnerProfile.storeOwnerId'
            );

        if($storeOwnerProfileStatus === StoreProfileConstant::STORE_OWNER_PROFILE_ACTIVE_STATUS || $storeOwnerProfileStatus === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
            $query->andWhere('storeOwnerProfile.status = :storeOwnerProfileStatus');
            $query->setParameter('storeOwnerProfileStatus', $storeOwnerProfileStatus);

        }

        $query->orderBy('storeOwnerProfile.id', 'DESC');

        return $query->getQuery()->getResult();
    }

    public function getStoreOwnerProfileByIdForAdmin(int $storeOwnerProfileId): ?array
    {
        return $this->createQueryBuilder('storeOwnerProfile')
            ->select('storeOwnerProfile.id', 'storeOwnerProfile.storeOwnerName', 'storeOwnerProfile.storeOwnerId', 'storeOwnerProfile.completeAccountStatus', 'storeOwnerProfile.storeCategoryId', 'storeOwnerProfile.bankAccountNumber',
                'storeOwnerProfile.bankName', 'storeOwnerProfile.city', 'storeOwnerProfile.openingTime', 'storeOwnerProfile.closingTime', 'storeOwnerProfile.commission', 'storeOwnerProfile.employeeCount', 'storeOwnerProfile.phone', 'storeOwnerProfile.roomID',
                'storeOwnerProfile.stcPay', 'storeOwnerProfile.status', 'storeOwnerProfile.images', 'storeOwnerProfile.profitMargin', 'storeOwnerProfile.completeAccountStatus')
            ->addSelect('chatRoomEntity.roomId')
            ->addSelect('userEntity.userId', 'userEntity.verificationStatus')

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.id = storeOwnerProfile.storeOwnerId'
            )
           
            ->leftJoin(ChatRoomEntity::class, 'chatRoomEntity', Join::WITH, 'chatRoomEntity.userId = storeOwnerProfile.storeOwnerId')
            
            ->andWhere('storeOwnerProfile.id = :storeOwnerProfileId')
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->orderBy('storeOwnerProfile.id', 'DESC')

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getStoreOwnerBranchesByStoreOwnerProfileIdForAdmin(int $storeOwnerProfileId): ?array
    {
        return $this->createQueryBuilder('storeOwnerProfile')
            ->select('storeOwnerBranchEntity.id as branchId', 'storeOwnerBranchEntity.location', 'storeOwnerBranchEntity.name', 'storeOwnerBranchEntity.city', 'storeOwnerBranchEntity.isActive')

            ->andWhere('storeOwnerProfile.id = :storeOwnerProfileId')
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->leftJoin(
                'storeOwnerProfile.storeOwnerBranchEntities',
                'storeOwnerBranchEntity',
                Join::ON
            )

            ->orderBy('storeOwnerBranchEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function getStoreProfitMarginByStoreOwnerId(int $userId): ?array
    {
        return $this->createQueryBuilder('storeOwnerProfileEntity')
            ->select('storeOwnerProfileEntity.profitMargin')

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.id = storeOwnerProfileEntity.storeOwnerId'
            )

            ->andWhere('userEntity.id = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getLastThreeActiveStoreOwnersProfilesForAdmin(): array
    {
        return $this->createQueryBuilder('storeOwnerProfileEntity')
            ->select('storeOwnerProfileEntity.id', 'storeOwnerProfileEntity.storeOwnerName', 'storeOwnerProfileEntity.images', 'storeOwnerProfileEntity.createdAt')

            ->andWhere('storeOwnerProfileEntity.status = :activeStatus')
            ->setParameter('activeStatus', StoreProfileConstant::STORE_OWNER_PROFILE_ACTIVE_STATUS)

            ->orderBy('storeOwnerProfileEntity.id', 'DESC')
            ->setMaxResults(3)

            ->getQuery()
            ->getResult();
    }

    public function getActiveStoresWithOrdersDuringCurrentMonthForAdmin(): array
    {
        $stores = $this->createQueryBuilder('storeOwnerProfileEntity')
            ->select('storeOwnerProfileEntity.id', 'storeOwnerProfileEntity.storeOwnerName', 'storeOwnerProfileEntity.images')

            ->andWhere('storeOwnerProfileEntity.status = :activeStore')
            ->setParameter('activeStore', StoreProfileConstant::STORE_OWNER_PROFILE_ACTIVE_STATUS)

            ->orderBy('storeOwnerProfileEntity.id', 'DESC')

            ->getQuery()
            ->getResult();

        if (count($stores) > 0) {
            foreach ($stores as $key => $value) {
                $stores[$key]['orders'] = $this->getOrdersDuringThisMonthByStoreOwnerProfileIdForAdmin($value['id']);

                if (count($stores[$key]['orders']) > 0) {
                    $stores[$key]['ordersCount'] = count($stores[$key]['orders']);

                } else {
                    $stores[$key]['ordersCount'] = 0;
                }
            }
        }

        return $stores;
    }

    public function getOrdersDuringThisMonthByStoreOwnerProfileIdForAdmin(int $storeOwnerProfileId): array
    {
        return $this->createQueryBuilder('storeOwnerProfileEntity')
            ->select('orderEntity.id as orderId', 'storeOwnerBranchEntity.id as branchId', 'storeOwnerBranchEntity.name as branchName')

            ->andWhere('storeOwnerProfileEntity.id = :storeOwnerProfileId')
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->leftJoin(
                OrderEntity::class,
                'orderEntity',
                Join::WITH,
                'orderEntity.storeOwner = storeOwnerProfileEntity.id'
            )

            ->leftJoin(
                StoreOrderDetailsEntity::class,
                'storeOrderDetailsEntity',
                Join::WITH,
                'storeOrderDetailsEntity.orderId = orderEntity.id'
            )

            ->leftJoin(
                StoreOwnerBranchEntity::class,
                'storeOwnerBranchEntity',
                Join::WITH,
                'storeOwnerBranchEntity.id = storeOrderDetailsEntity.branch'
            )

            ->andWhere('orderEntity.createdAt BETWEEN :currentMonthStartDate AND :currentMonthEndDate')
            ->setParameter('currentMonthStartDate', (new \DateTime('first day of this month'))->setTime(00, 00, 00))
            ->setParameter('currentMonthEndDate', (new \DateTime('last day of this month'))->setTime(23, 59, 59))

            ->andWhere('orderEntity.state = :deliveredState')
            ->setParameter('deliveredState', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->getQuery()
            ->getResult();
    }
}
