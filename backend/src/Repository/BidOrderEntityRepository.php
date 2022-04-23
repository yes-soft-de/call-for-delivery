<?php

namespace App\Repository;

use App\Entity\BidOrderEntity;
use App\Entity\ImageEntity;
use App\Entity\PriceOfferEntity;
use App\Entity\SupplierCategoryEntity;
use App\Entity\SupplierProfileEntity;
use App\Request\BidOrder\BidOrderFilterBySupplierRequest;
use DateTime;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method BidOrderEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method BidOrderEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method BidOrderEntity[]    findAll()
 * @method BidOrderEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class BidOrderEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, BidOrderEntity::class);
    }

    // This function filter bid orders which the supplier had not provide a price offer for any one of them yet.
    public function filterBidOrdersBySupplier(BidOrderFilterBySupplierRequest $request): array
    {
        $query = $this->createQueryBuilder('bidOrderEntity')
            ->select('bidOrderEntity.id', 'bidOrderEntity.title', 'bidOrderEntity.description', 'bidOrderEntity.createdAt', 'bidOrderEntity.updatedAt')

            ->andWhere('bidOrderEntity.openToPriceOffer = :openToPriceOfferStatus')
            ->setParameter('openToPriceOfferStatus', 1)

            ->leftJoin(
                SupplierCategoryEntity::class,
                'supplierCategoryEntity',
                Join::WITH,
                'supplierCategoryEntity.id = bidOrderEntity.supplierCategory'
            )

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierCategoryEntity.id IN (:supCategory)'
            )

            ->setParameter('supCategory', $this->getSupplierCategoriesBySupplierId($request->getSupplierId()))

            ->andWhere('supplierProfileEntity.user = :supplierId')
            ->setParameter('supplierId', $request->getSupplierId())

            ->orderBy('bidOrderEntity.id', 'DESC');

        //---- Check if bid order is among the orders which the supplier had made a previous offer for it
        $bidOrderIds = $this->getBidOrderIdsBySupplierIdAndThatHavePriceOffers($request->getSupplierId());
        if (! empty($bidOrderIds)) {
            $query->andWhere('bidOrderEntity.id NOT IN (:bidOrderIds)');
            $query->setParameter('bidOrderIds', $bidOrderIds);
        }
        //---- End checking block

        if (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === "")) {
            $query->andWhere('bidOrderEntity.createdAt >= :createdAt');
            $query->setParameter('createdAt', $request->getFromDate());

        } elseif (($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('bidOrderEntity.createdAt <= :createdAt');
            $query->setParameter('createdAt', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));

        } elseif (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('bidOrderEntity.createdAt >= :fromDate');
            $query->setParameter('fromDate', $request->getFromDate());

            $query->andWhere('bidOrderEntity.createdAt <= :toDate');
            $query->setParameter('toDate', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));
        }

        return $query->getQuery()->getResult();
    }

    public function getBidOrderByIdForSupplier(int $bidOrderId): ?BidOrderEntity
    {
        return $this->createQueryBuilder('bidOrderEntity')

            ->andWhere('bidOrderEntity.id = :bidOrderId')
            ->setParameter('bidOrderId', $bidOrderId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    // This function returns array of bid orders Ids that the supplier had made a price offer for them
    public function getBidOrderIdsBySupplierIdAndThatHavePriceOffers(int $supplierId): array
    {
        return $this->createQueryBuilder('bidOrderEntity')
            ->select('bidOrderEntity.id')

            ->andWhere('bidOrderEntity.openToPriceOffer = :openToPriceOfferStatus')
            ->setParameter('openToPriceOfferStatus', 1)

            ->leftJoin(
                PriceOfferEntity::class,
                'priceOfferEntity',
                Join::WITH,
                'priceOfferEntity.bidOrder = bidOrderEntity.id'
            )

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.id = priceOfferEntity.supplierProfile'
            )

            ->andWhere('supplierProfileEntity.user = :supplierId')
            ->setParameter('supplierId', $supplierId)

            ->orderBy('bidOrderEntity.id', 'DESC')

            ->getQuery()
            ->getSingleColumnResult();
    }

    // This function filter bid orders which have price offers made by the supplier (who request the filter).
    public function filterBidOrdersThatHavePriceOffersBySupplier(BidOrderFilterBySupplierRequest $request): array
    {
        $query = $this->createQueryBuilder('bidOrderEntity')
            ->select('DISTINCT(bidOrderEntity.id) as id', 'bidOrderEntity.title', 'bidOrderEntity.description', 'bidOrderEntity.createdAt', 'bidOrderEntity.updatedAt', 'bidOrderEntity.openToPriceOffer')

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.supplierCategory = bidOrderEntity.supplierCategory'
            )

            ->andWhere('supplierProfileEntity.user = :supplierId')
            ->setParameter('supplierId', $request->getSupplierId())

            ->leftJoin(
                PriceOfferEntity::class,
                'priceOfferEntity',
                Join::WITH,
                'priceOfferEntity.bidOrder = bidOrderEntity.id'
            )

            ->andWhere('priceOfferEntity.supplierProfile = supplierProfileEntity.id')

            ->orderBy('bidOrderEntity.id', 'DESC');

        if ($request->getPriceOfferStatus()) {
            $pricesOffersIdsArray = $this->getLastPriceOfferIdsArrayBySupplierIdAndPriceOfferStatus($request->getSupplierId(), $request->getPriceOfferStatus());

            $query->andWhere('priceOfferEntity.id IN (:pricesOffersIdsArray)');
            $query->setParameter('pricesOffersIdsArray', $pricesOffersIdsArray);
        }

        if ($request->getOpenToPriceOffer() !== null) {
            $query->andWhere('bidOrderEntity.openToPriceOffer = :openToPriceOffer');
            $query->setParameter('openToPriceOffer', $request->getOpenToPriceOffer());
        }

        if (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === "")) {
            $query->andWhere('bidOrderEntity.createdAt >= :createdAt');
            $query->setParameter('createdAt', $request->getFromDate());

        } elseif (($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('bidOrderEntity.createdAt <= :createdAt');
            $query->setParameter('createdAt', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));

        } elseif (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('bidOrderEntity.createdAt >= :fromDate');
            $query->setParameter('fromDate', $request->getFromDate());

            $query->andWhere('bidOrderEntity.createdAt <= :toDate');
            $query->setParameter('toDate', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));
        }

        return $query->getQuery()->getResult();
    }

    // This function return last id of the price offer which made by the supplier and its status equal specific one
    public function getLastPriceOfferIdsArrayBySupplierIdAndPriceOfferStatus(int $supplierID, string $status): array
    {
        return $this->createQueryBuilder('bidOrderEntity')
            ->select('priceOfferEntity.id')

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.supplierCategory = bidOrderEntity.supplierCategory'
            )

            ->andWhere('supplierProfileEntity.user = :supplierId')
            ->setParameter('supplierId', $supplierID)

            ->leftJoin(
                PriceOfferEntity::class,
                'priceOfferEntity',
                Join::WITH,
                'priceOfferEntity.bidOrder = bidOrderEntity.id'
            )

            ->andWhere('priceOfferEntity.supplierProfile = supplierProfileEntity.id')

            ->andWhere('priceOfferEntity.priceOfferStatus = :offerStatus')
            ->setParameter('offerStatus', $status)

            ->orderBy('priceOfferEntity.id', 'DESC')
            ->setMaxResults(1)

            ->getQuery()
            ->getSingleColumnResult();
    }

    public function getSupplierCategoriesBySupplierId(int $supplierId): array
    {
        $query = $this->createQueryBuilder('bidOrder')
            ->select('DISTINCT(supplierProfileEntity.supplierCategories)')

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.user = :userId'
            )

            ->setParameter('userId', $supplierId)

            ->getQuery()
            ->getSingleColumnResult();

        if (empty($query)) {
            return $query;
        }

        return json_decode($query[0]);
    }
}
