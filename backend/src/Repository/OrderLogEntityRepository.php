<?php

namespace App\Repository;

use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Entity\ExternalDeliveryCompanyEntity;
use App\Entity\ImageEntity;
use App\Entity\AdminProfileEntity;
use App\Entity\CaptainEntity;
use App\Entity\OrderEntity;
use App\Entity\OrderLogEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SupplierProfileEntity;
use App\Entity\UserEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method OrderLogEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method OrderLogEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method OrderLogEntity[]    findAll()
 * @method OrderLogEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class OrderLogEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, OrderLogEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(OrderLogEntity $entity, bool $flush = true): void
    {
        $this->_em->persist($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function remove(OrderLogEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function getOrderLogsByOrderIdForAdmin(int $orderId): array
    {
        $query = $this->createQueryBuilder('orderLogEntity')
            ->select('orderLogEntity.id', 'orderLogEntity.action', 'orderLogEntity.createdAt', 'orderLogEntity.createdBy', 'orderLogEntity.createdByUserType',
                'orderLogEntity.isCaptainArrivedConfirmation', 'orderLogEntity.isHide', 'orderLogEntity.orderIsMain', 'orderLogEntity.type',
                'orderLogEntity.state')
            ->addSelect('storeOwnerProfileEntity.id as storeOwnerProfileId', 'storeOwnerProfileEntity.storeOwnerName')
            ->addSelect('storeOwnerBranchEntity.id as storeOwnerBranchId', 'storeOwnerBranchEntity.name as storeOwnerBranchName')
            ->addSelect('captainEntity.id as captainProfileId', 'captainEntity.captainName')
            ->addSelect('imageEntity.imagePath', 'imageEntity.usedAs')
            ->addSelect('orderEntity.id as primaryOrderId')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = orderLogEntity.storeOwnerProfile'
            )

            ->leftJoin(
                StoreOwnerBranchEntity::class,
                'storeOwnerBranchEntity',
                Join::WITH,
                'storeOwnerBranchEntity.id = orderLogEntity.storeOwnerBranch'
            )

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = orderLogEntity.captainProfile'
            )
            
            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = captainEntity.id AND imageEntity.entityType = :entityType'
                .' AND imageEntity.usedAs = :profileImage'
            )
            
            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)
            ->setParameter('profileImage', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)

            ->leftJoin(
                OrderEntity::class,
                'orderEntity',
                Join::WITH,
                'orderEntity.id = orderLogEntity.primaryOrder'
            )

            ->andWhere('orderLogEntity.orderId = :orderId')
            ->setParameter('orderId', $orderId)

            ->groupBy('orderLogEntity.id')

            ->orderBy('orderLogEntity.createdAt', 'DESC');

        $tempResult = $query->getQuery()->getResult();

        if (count($tempResult) !== 0) {
            $tempResult = $this->getCreatedByUserName($tempResult);
        }

        return $tempResult;
    }

    public function getCreatedByUserName(array $orderLogs): array
    {
        foreach ($orderLogs as $key => $value) {
            if ($value['createdByUserType'] === OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST) {
                $createdByName = $this->createQueryBuilder('orderLogEntity')
                    ->select('adminProfileEntity.name')

                    ->leftJoin(
                        UserEntity::class,
                        'userEntity',
                        Join::WITH,
                        'userEntity.id = orderLogEntity.createdBy'
                    )

                    ->leftJoin(
                        AdminProfileEntity::class,
                        'adminProfileEntity',
                        Join::WITH,
                        'adminProfileEntity.user = userEntity.id'
                    )

                    ->andWhere('orderLogEntity.id = :id')
                    ->setParameter('id', $value['id'])

                    ->getQuery()
                    ->getSingleColumnResult();

                if (count($createdByName) !== 0) {
                    $orderLogs[$key]['createdBy'] = $createdByName[0];
                }

                $orderLogs[$key]['createdBy'] = (string) $orderLogs[$key]['createdBy'];

            } elseif ($value['createdByUserType'] === OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST) {
                $createdByName = $this->createQueryBuilder('orderLogEntity')
                    ->select('storeOwnerProfileEntity.storeOwnerName')

                    ->leftJoin(
                        UserEntity::class,
                        'userEntity',
                        Join::WITH,
                        'userEntity.id = orderLogEntity.createdBy'
                    )

                    ->leftJoin(
                        StoreOwnerProfileEntity::class,
                        'storeOwnerProfileEntity',
                        Join::WITH,
                        'storeOwnerProfileEntity.storeOwnerId = userEntity.id'
                    )

                    ->andWhere('orderLogEntity.id = :id')
                    ->setParameter('id', $value['id'])

                    ->getQuery()
                    ->getSingleColumnResult();

                if (count($createdByName) !== 0) {
                    $orderLogs[$key]['createdBy'] = $createdByName[0];
                }

                $orderLogs[$key]['createdBy'] = (string) $orderLogs[$key]['createdBy'];

            } elseif ($value['createdByUserType'] === OrderLogCreatedByUserTypeConstant::CAPTAIN_USER_TYPE_CONST) {
                $createdByName = $this->createQueryBuilder('orderLogEntity')
                    ->select('captainEntity.captainName')

                    ->leftJoin(
                        UserEntity::class,
                        'userEntity',
                        Join::WITH,
                        'userEntity.id = orderLogEntity.createdBy'
                    )

                    ->leftJoin(
                        CaptainEntity::class,
                        'captainEntity',
                        Join::WITH,
                        'captainEntity.captainId = userEntity.id'
                    )

                    ->andWhere('orderLogEntity.id = :id')
                    ->setParameter('id', $value['id'])

                    ->getQuery()
                    ->getSingleColumnResult();

                if (count($createdByName) !== 0) {
                    $orderLogs[$key]['createdBy'] = $createdByName[0];
                }

                $orderLogs[$key]['createdBy'] = (string) $orderLogs[$key]['createdBy'];

            } elseif ($value['createdByUserType'] === OrderLogCreatedByUserTypeConstant::SUPPLIER_USER_TYPE_CONST) {
                $createdByName = $this->createQueryBuilder('orderLogEntity')
                    ->select('supplierProfileEntity.supplierName')

                    ->leftJoin(
                        UserEntity::class,
                        'userEntity',
                        Join::WITH,
                        'userEntity.id = orderLogEntity.createdBy'
                    )

                    ->leftJoin(
                        SupplierProfileEntity::class,
                        'supplierProfileEntity',
                        Join::WITH,
                        'supplierProfileEntity.user = userEntity.id'
                    )

                    ->andWhere('orderLogEntity.id = :id')
                    ->setParameter('id', $value['id'])

                    ->getQuery()
                    ->getSingleColumnResult();

                if (count($createdByName) !== 0) {
                    $orderLogs[$key]['createdBy'] = $createdByName[0];
                }

                $orderLogs[$key]['createdBy'] = (string) $orderLogs[$key]['createdBy'];

            } elseif ($value['createdByUserType'] === OrderLogCreatedByUserTypeConstant::MARSOOL_EXTERNAL_DELIVERY_COMPANY_CONST) {
                $createdByName = $this->createQueryBuilder('orderLogEntity')
                    ->select('externalDeliveryCompanyEntity.companyName')

                    ->leftJoin(
                        ExternalDeliveryCompanyEntity::class,
                        'externalDeliveryCompanyEntity',
                        Join::WITH,
                        'externalDeliveryCompanyEntity.id = orderLogEntity.createdBy'
                    )

                    ->andWhere('orderLogEntity.id = :id')
                    ->setParameter('id', $value['id'])

                    ->getQuery()
                    ->getSingleColumnResult();

                if (count($createdByName) !== 0) {
                    $orderLogs[$key]['createdBy'] = $createdByName[0];
                }

                $orderLogs[$key]['createdBy'] = (string) $orderLogs[$key]['createdBy'];
            }
        }

        return $orderLogs;
    }

    public function getOrderLogByCaptainUserId(int $captainUserId): array
    {
        return $this->createQueryBuilder('orderLogEntity')

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = orderLogEntity.captainProfile'
            )

            ->andWhere('captainEntity.captainId = :captainUserId')
            ->setParameter('captainUserId', $captainUserId)

            ->getQuery()
            ->getResult();
    }
}
