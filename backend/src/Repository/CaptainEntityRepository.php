<?php

namespace App\Repository;

use App\Constant\Captain\CaptainConstant;
use App\Constant\Order\OrderStateConstant;
use App\Entity\CaptainEntity;
use App\Entity\ImageEntity;
use App\Entity\OrderEntity;
use App\Entity\RateEntity;
use App\Entity\UserEntity;
use App\Request\Admin\Report\CaptainWithDeliveredOrdersDuringSpecificTimeFilterByAdminRequest;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Entity\ChatRoomEntity;
use Doctrine\ORM\Query\Expr\Join;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Image\ImageUseAsConstant;
use App\Entity\CaptainFinancialDuesEntity;
/**
 * @method CaptainEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainEntity[]    findAll()
 * @method CaptainEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainEntity::class);
    }

    public function getCaptainByCaptainId($id): ?array
    {
        return $this->createQueryBuilder('captainEntity')

            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName', 'captainEntity.location', 'captainEntity.age', 'captainEntity.car', 'captainEntity.salary',
                'captainEntity.salary', 'captainEntity.bounce', 'captainEntity.phone', 'captainEntity.isOnline', 'captainEntity.bankName', 'captainEntity.bankAccountNumber', 'captainEntity.stcPay',
                'captainEntity.status', 'captainEntity.address', 'captainEntity.city')
            ->addSelect('chatRoomEntity.roomId')
            ->addSelect('imageEntity.imagePath', 'imageEntity.usedAs')
           
            ->leftJoin(ChatRoomEntity::class, 'chatRoomEntity', Join::WITH, 'chatRoomEntity.userId = captainEntity.captainId')
            ->leftJoin(ImageEntity::class, 'imageEntity', Join::WITH, 'imageEntity.itemId = captainEntity.id and imageEntity.entityType = :entityType')
            
            ->andWhere('captainEntity.captainId = :id')

            ->setParameter('id', $id)
            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)
            
            ->getQuery()
            ->getResult();
    }

    public function getUserProfile($captainId): mixed
    {
        return $this->createQueryBuilder('captainEntity')

            ->andWhere('captainEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCompleteAccountStatusByCaptainId($captainId): ?array
    {
        return $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.completeAccountStatus')
            ->addSelect('userEntity.status')

            ->andWhere('captainEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.id = captainEntity.captainId'
            )

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function captainIsActive($captainId): ?array
    {
        return $this->createQueryBuilder('captainEntity')

            ->select('captainEntity.status', 'captainEntity.isOnline')

            ->andWhere('captainEntity.captainId = :captainId')

            ->setParameter('captainId', $captainId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCaptainsProfilesByStatusForAdmin(string $captainProfileStatus): array
    {
        $query = $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName', 'captainEntity.location', 'captainEntity.age', 'captainEntity.car', 'captainEntity.salary',
                'captainEntity.status', 'captainEntity.bounce', 'captainEntity.phone', 'captainEntity.isOnline', 'captainEntity.bankName', 'captainEntity.bankAccountNumber', 'captainEntity.stcPay',
                'captainEntity.completeAccountStatus', 'captainEntity.address', 'captainEntity.city')
            ->addSelect('userEntity.userId', 'userEntity.verificationStatus')
            ->addSelect('captainFinancialDuesEntity.captainStoppedFinancialCycle')

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.id = captainEntity.captainId'
            );

        if ($captainProfileStatus === CaptainConstant::CAPTAIN_ACTIVE || $captainProfileStatus === CaptainConstant::CAPTAIN_INACTIVE) {
            $query->andWhere('captainEntity.status = :captainProfileStatus');
            $query->setParameter('captainProfileStatus', $captainProfileStatus);
        }

        $query->leftJoin(CaptainFinancialDuesEntity::class, 'captainFinancialDuesEntity', Join::WITH, 'captainFinancialDuesEntity.captain = captainEntity.id');

        $query->orderBy('captainEntity.id', 'DESC');
        $query->groupBy('captainEntity.id');

        return $query->getQuery()->getResult();
    }

    public function getCaptainProfileByIdForAdmin(int $captainProfileId): ?array
    {
        return $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName', 'captainEntity.location', 'captainEntity.age', 'captainEntity.car', 'captainEntity.salary',
                'captainEntity.salary', 'captainEntity.bounce', 'captainEntity.phone', 'captainEntity.isOnline', 'captainEntity.bankName', 'captainEntity.bankAccountNumber', 'captainEntity.stcPay',
                'captainEntity.completeAccountStatus', 'captainEntity.status', 'captainEntity.address', 'captainEntity.city', 'chatRoomEntity.roomId')
            ->addSelect('imageEntity.imagePath', 'imageEntity.usedAs')
            ->addSelect('userEntity.userId', 'userEntity.verificationStatus')

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.id = captainEntity.captainId'
            )

            ->leftJoin(
                ChatRoomEntity::class,
                'chatRoomEntity',
                Join::WITH,
                'chatRoomEntity.userId = captainEntity.captainId')
            
           ->leftJoin(ImageEntity::class, 'imageEntity', Join::WITH, 'imageEntity.itemId = captainEntity.id and imageEntity.entityType = :entityType')

            ->andWhere('captainEntity.id = :captainProfileId')

            ->setParameter('captainProfileId', $captainProfileId)
           
           ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)

            ->getQuery()
            ->getResult();
    }

    public function getCaptain(int $captainProfileId): ?array
    {
        return $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName', 'captainEntity.location', 'captainEntity.age', 'captainEntity.car', 'captainEntity.salary',
                'captainEntity.salary', 'captainEntity.bounce', 'captainEntity.phone', 'captainEntity.isOnline', 'captainEntity.bankName', 'captainEntity.bankAccountNumber', 'captainEntity.stcPay',
                'captainEntity.status')

            ->andWhere('captainEntity.id = :captainProfileId')

            ->setParameter('captainProfileId', $captainProfileId)
           
            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function getCaptainFinancialSystemStatus(int $captainId): ?array
    {
        return $this->createQueryBuilder('captainEntity')

            ->select('captainFinancialSystemDetailEntity.status')
            
            ->leftJoin(CaptainFinancialSystemDetailEntity::class, 'captainFinancialSystemDetailEntity', Join::WITH, 'captainFinancialSystemDetailEntity.captain = captainEntity.id')

            ->andWhere('captainEntity.captainId = :captainId')

            ->setParameter('captainId', $captainId)
            
            ->orderBy('captainFinancialSystemDetailEntity.id', 'DESC')
            
            ->setMaxResults(1)
            
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getReadyCaptainsAndCountOfTheirCurrentOrders(): array
    {
        return $this->createQueryBuilder('captainEntity')

            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName', 'captainEntity.location', 'captainEntity.age', 'captainEntity.car', 'captainEntity.salary',
        'captainEntity.salary', 'captainEntity.bounce', 'captainEntity.phone', 'captainEntity.isOnline', 'captainEntity.bankName', 'captainEntity.bankAccountNumber', 'captainEntity.stcPay',
        'captainEntity.status')
            ->addSelect('imageEntity.imagePath', 'imageEntity.usedAs')
            ->addSelect('chatRoomEntity.roomId')
           
            ->leftJoin(ChatRoomEntity::class, 'chatRoomEntity', Join::WITH, 'chatRoomEntity.userId = captainEntity.captainId')
            ->andWhere('captainEntity.status = :status')
            ->setParameter('status', CaptainConstant::CAPTAIN_ACTIVE)

            ->andWhere('captainEntity.isOnline = :isOnline')
            ->setParameter('isOnline', CaptainConstant::CAPTAIN_ONLINE_TRUE)

            ->leftJoin(CaptainFinancialSystemDetailEntity::class, 'captainFinancialSystemDetailEntity', Join::WITH, 'captainFinancialSystemDetailEntity.captain = captainEntity.id')

            ->andWhere('captainFinancialSystemDetailEntity.status = :financialSystemStatus')
            ->setParameter('financialSystemStatus', CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ACTIVE)
         
            ->leftJoin(ImageEntity::class, 'imageEntity', Join::WITH, 'imageEntity.itemId = captainEntity.id and imageEntity.entityType = :entityType and imageEntity.usedAs = :usedAs')
        
            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)
            ->setParameter('usedAs', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)
            
            ->orderBy('captainEntity.id', 'DESC')
            
            ->getQuery()
            ->getResult();
    }

    public function getLastThreeActiveCaptainsProfilesForAdmin(): array
    {
        return $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.id', 'captainEntity.captainName', 'captainEntity.createdAt')
            ->addSelect('imageEntity.imagePath as images')

            ->andWhere('captainEntity.status = :activeStatus')
            ->setParameter('activeStatus', CaptainConstant::CAPTAIN_ACTIVE)

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = captainEntity.id and imageEntity.entityType = :entityType and imageEntity.usedAs = :usedAs'
            )

            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)
            ->setParameter('usedAs', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)

            ->orderBy('captainEntity.id', 'DESC')
            ->setMaxResults(3)

            ->getQuery()
            ->getResult();
    }

    // get captain specific info for order by id response for admin
    public function getCaptainForAdmin(int $captainProfileId): ?array
    {
        return $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName', 'captainEntity.location', 'captainEntity.age', 'captainEntity.car', 'captainEntity.salary',
                'captainEntity.salary', 'captainEntity.bounce', 'captainEntity.phone', 'captainEntity.isOnline', 'captainEntity.bankName', 'captainEntity.bankAccountNumber', 'captainEntity.stcPay',
                'captainEntity.status')
            ->addSelect('imageEntity.imagePath as images')

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = captainEntity.id and imageEntity.entityType = :entityType and imageEntity.usedAs = :usedAs'
            )

            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)
            ->setParameter('usedAs', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)

            ->andWhere('captainEntity.id = :captainProfileId')
            ->setParameter('captainProfileId', $captainProfileId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByAdmin(): array
    {
        $captainsProfiles = $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName')
            ->addSelect('imageEntity.imagePath', 'imageEntity.usedAs')

            ->where('captainEntity.status = :activeStatus')
            ->setParameter('activeStatus', CaptainConstant::CAPTAIN_ACTIVE)

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = captainEntity.id and imageEntity.entityType = :entityType'
            )

            ->andWhere('imageEntity.usedAs = :captainProfileImage')
            ->setParameter('captainProfileImage', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)

            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE);

        $tempQuery = $captainsProfiles->getQuery()->getResult();

        if (count($tempQuery) > 0) {
            $finalResponse = [];

            foreach ($tempQuery as $key => $value) {
                // get last active financial cycle
                $financialCycle = $this->getLastActiveFinancialCycleByCaptainForAdmin($value['id']);

                if (($financialCycle['startDate']) && ($financialCycle['endDate'])) {
                    $finalResponse[$key] = $value;

                    $ordersCountResult = $this->getCaptainDeliveredOrdersCountDuringSpecificDateForAdmin($value['id'],
                        $financialCycle['startDate'], $financialCycle['endDate']);

                    if(count($ordersCountResult) > 0) {
                        $finalResponse[$key]['ordersCount'] = $ordersCountResult[0];

                    } else {
                        $finalResponse[$key]['ordersCount'] = (string) 0;
                    }
                }
            }

            return $finalResponse;
        }

        return $tempQuery;
    }

    public function getLastActiveFinancialCycleByCaptainForAdmin(int $captainId): ?array
    {
        return $this->createQueryBuilder('captainEntity')
            ->select('captainFinancialDuesEntity.startDate', 'captainFinancialDuesEntity.endDate')

            ->andWhere('captainEntity.id = :captainProfileId')
            ->setParameter('captainProfileId', $captainId)

            ->leftJoin(
                CaptainFinancialDuesEntity::class,
                'captainFinancialDuesEntity',
                Join::WITH,
                "captainFinancialDuesEntity.captain = captainEntity.id AND captainFinancialDuesEntity.state = '1'"
            )

//            ->andWhere('captainFinancialDuesEntity.captainStoppedFinancialCycle != :stopped')
//            ->setParameter('stopped', true)

            ->orderBy('captainFinancialDuesEntity.id', 'DESC')
            ->setMaxResults(1)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCaptainDeliveredOrdersCountDuringSpecificDateForAdmin(int $captainId, \DateTime $startDate, \DateTime $endDate): array
    {
        $query =  $this->createQueryBuilder('captainEntity')
            ->select('COUNT(orderEntity.id)')

            ->andWhere('captainEntity.id = :captainProfileId')
            ->setParameter('captainProfileId', $captainId)

            ->leftJoin(
                OrderEntity::class,
                'orderEntity',
                Join::WITH,
                'orderEntity.captainId = captainEntity.id'
            );

            $query->andWhere('orderEntity.state = :delivered');
            $query->setParameter('delivered', OrderStateConstant::ORDER_STATE_DELIVERED);

            $query->andWhere('orderEntity.createdAt >= :fromDate AND orderEntity.createdAt <= :toDate');
            $query->setParameter('fromDate', $startDate);
            $query->setParameter('toDate', $endDate);

            return $query->getQuery()->getSingleColumnResult();
    }

    public function getCaptainsRatingsForAdmin(): array
    {
        return $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.id', 'captainEntity.captainName', 'AVG(rateEntity.rating) as avgRating')
            ->addSelect('imageEntity.imagePath', 'imageEntity.usedAs')

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = captainEntity.id and imageEntity.entityType = :entityType'
            )

            ->andWhere('imageEntity.usedAs = :captainProfileImage')
            ->setParameter('captainProfileImage', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)

            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)

            ->join(
                RateEntity::class,
                'rateEntity',
                Join::WITH,
                'rateEntity.rated = captainEntity.captainId'
            )

            ->groupBy('captainEntity.id')

            ->getQuery()
            ->getResult();
    }

    public function getCaptainsWhoDeliveredOrdersDuringSpecificTime(CaptainWithDeliveredOrdersDuringSpecificTimeFilterByAdminRequest $request): array
    {
        $captainsProfiles = $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName')
            ->addSelect('imageEntity.imagePath', 'imageEntity.usedAs')

            ->where('captainEntity.status = :activeStatus')
            ->setParameter('activeStatus', CaptainConstant::CAPTAIN_ACTIVE)

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = captainEntity.id and imageEntity.entityType = :entityType'
            )

            ->andWhere('imageEntity.usedAs = :captainProfileImage')
            ->setParameter('captainProfileImage', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)

            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE);

        $tempQuery = $captainsProfiles->getQuery()->getResult();

        if (count($tempQuery) > 0) {
            $finalResponse = [];

            // Iterate on each retrieved captain in order to get specific other values
            foreach ($tempQuery as $key => $value) {
                $finalResponse[$key] = $value;

                // Get delivered orders count of the captain
                $ordersCountResult = $this->getCaptainDeliveredOrdersCountByOptionalDatesForAdmin($value['id'],
                    $request->getFromDate(), $request->getToDate());

                if(count($ordersCountResult) > 0) {
                    $finalResponse[$key]['ordersCount'] = $ordersCountResult[0];

                } else {
                    $finalResponse[$key]['ordersCount'] = (string) 0;
                }
                // ------------------------------------------------

                // Get the count of orders which delivered today
                $todayOrdersCountResult = $this->getCaptainDeliveredOrdersCountDuringSpecificDateForAdmin($value['id'],
                    new \DateTime('today midnight'), new \DateTime('tomorrow midnight'));

                if(count($todayOrdersCountResult) > 0) {
                    $finalResponse[$key]['todayOrdersCount'] = $todayOrdersCountResult[0];

                } else {
                    $finalResponse[$key]['todayOrdersCount'] = (string) 0;
                }
                // ------------------------------------------------

                // Get the count of orders which delivered last 24 hours
                $lastTwentyFourHoursOrdersCountResult = $this->getCaptainDeliveredOrdersCountDuringSpecificDateForAdmin($value['id'],
                    new \DateTime('-24 hour'), new \DateTime('now'));

                if(count($lastTwentyFourHoursOrdersCountResult) > 0) {
                    $finalResponse[$key]['lastTwentyFourOrdersCount'] = $lastTwentyFourHoursOrdersCountResult[0];

                } else {
                    $finalResponse[$key]['lastTwentyFourOrdersCount'] = (string) 0;
                }
                // ------------------------------------------------
            }

            return $finalResponse;
        }

        return $tempQuery;
    }

    // Get the count of delivered orders by captain and via optional dates of type string
    public function getCaptainDeliveredOrdersCountByOptionalDatesForAdmin(int $captainId, ?string $startDate, ?string $endDate): array
    {
        $query = $this->createQueryBuilder('captainEntity')
            ->select('COUNT(orderEntity.id)')

            ->andWhere('captainEntity.id = :captainProfileId')
            ->setParameter('captainProfileId', $captainId)

            ->leftJoin(
                OrderEntity::class,
                'orderEntity',
                Join::WITH,
                'orderEntity.captainId = captainEntity.id'
            )

            ->andWhere('orderEntity.state = :delivered')
            ->setParameter('delivered', OrderStateConstant::ORDER_STATE_DELIVERED);

        if (($startDate) && ($startDate !== "")) {
            $query->andWhere('orderEntity.createdAt >= :fromDate')
                ->setParameter('fromDate', $startDate);
        }

        if (($endDate) && ($endDate !== "")) {
            $query->andWhere('orderEntity.createdAt <= :toDate')
                ->setParameter('toDate', $endDate);
        }

        return $query->getQuery()->getSingleColumnResult();
    }

    // FOR DEBUG ISSUES
    public function getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByTester(?string $customizedTimezone): array
    {
        $captainsProfiles = $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName')
            ->addSelect('imageEntity.imagePath', 'imageEntity.usedAs')

            ->where('captainEntity.status = :activeStatus')
            ->setParameter('activeStatus', CaptainConstant::CAPTAIN_ACTIVE)

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = captainEntity.id and imageEntity.entityType = :entityType'
            )

            ->andWhere('imageEntity.usedAs = :captainProfileImage')
            ->setParameter('captainProfileImage', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)

            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE);

        $tempQuery = $captainsProfiles->getQuery()->getResult();

        if (count($tempQuery) > 0) {
            $finalResponse = [];

            foreach ($tempQuery as $key => $value) {
                // get last active financial cycle
                $financialCycle = $this->getLastActiveFinancialCycleByCaptainForAdmin($value['id']);

                if (($financialCycle['startDate']) && ($financialCycle['endDate'])) {
                    $finalResponse[$key] = $value;

                    $ordersCountResult = $this->getCaptainDeliveredOrdersCountDuringSpecificDateForTester($value['id'],
                        $financialCycle['startDate'], $financialCycle['endDate'], $customizedTimezone);

                    if(count($ordersCountResult) > 0) {
                        $finalResponse[$key]['ordersCount'] = $ordersCountResult[0];

                    } else {
                        $finalResponse[$key]['ordersCount'] = (string) 0;
                    }
                }
            }

            return $finalResponse;
        }

        return $tempQuery;
    }

    public function getCaptainDeliveredOrdersCountDuringSpecificDateForTester(int $captainId, \DateTime $startDate, \DateTime $endDate, ?string $timeZone): array
    {
        $query = $this->createQueryBuilder('captainEntity')
            ->select('orderEntity.id', 'orderEntity.createdAt')

            ->andWhere('captainEntity.id = :captainProfileId')
            ->setParameter('captainProfileId', $captainId)

            ->leftJoin(
                OrderEntity::class,
                'orderEntity',
                Join::WITH,
                'orderEntity.captainId = captainEntity.id'
            );

        $query->andWhere('orderEntity.state = :delivered');
        $query->setParameter('delivered', OrderStateConstant::ORDER_STATE_DELIVERED);

        $tempOrders = $query->getQuery()->getResult();

        if (count($tempOrders) > 0) {
            $filteredOrders = $this->filterOrdersByDates($tempOrders, $startDate->format('Y-m-d'),
                $endDate->format('Y-m-d'), $timeZone);

            if (count($filteredOrders) > 0) {
                return [count($filteredOrders)];
            }

            return $filteredOrders;
        }

        return $tempOrders;
    }

    public function filterOrdersByDates(array $tempOrders, ?string $fromDate, ?string $toDate, ?string $timeZone): array
    {
        $filteredOrders = [];

        if (count($tempOrders) > 0) {
            if (($fromDate != null || $fromDate != "") && ($toDate === null || $toDate === "")) {
                foreach ($tempOrders as $key => $value) {
                    if ($value['createdAt']->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) >=
                        new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) {
                        $filteredOrders[$key] = $value;
                    }
                }

            } elseif (($fromDate === null || $fromDate === "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $key => $value) {
                    if ($value['createdAt']->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) <=
                        new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59'))) {
                        $filteredOrders[$key] = $value;
                    }
                }

            } elseif (($fromDate != null || $fromDate != "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $key => $value) {
                    if (($value['createdAt']->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) >=
                            new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) &&
                        ($value['createdAt']->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) <=
                            new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59')))) {
                        $filteredOrders[$key] = $value;
                    }
                }
            }
        }

        return $filteredOrders;
    }
}
