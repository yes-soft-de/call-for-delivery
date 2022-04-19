<?php

namespace App\Repository;

use App\Entity\BidOrderEntity;
use App\Entity\ImageEntity;
use App\Entity\PriceOfferEntity;
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
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.supplierCategory = bidOrderEntity.supplierCategory'
            )

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

    public function getBidOrderByIdForSupplier(int $bidOrderId, int $supplierId): ?array
    {
        $query = $this->createQueryBuilder('bidOrderEntity')
            ->select('bidOrderEntity.id', 'bidOrderEntity.openToPriceOffer', 'bidOrderEntity.createdAt', 'bidOrderEntity.title', 'bidOrderEntity.updatedAt', 'bidOrderEntity.description')
            ->addSelect('priceOfferEntity.id as priceOfferId', 'priceOfferEntity.priceOfferValue', 'priceOfferEntity.priceOfferStatus', 'priceOfferEntity.offerDeadline')

            ->andWhere('bidOrderEntity.id = :bidOrderId')
            ->setParameter('bidOrderId', $bidOrderId)

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

            ->getQuery()
            ->getOneOrNullResult();

        if ($query) {
            $query['images'] = $this->getBidOrderImagesByBidOrderId($bidOrderId);
        }

        return $query;
    }

    public function getBidOrderImagesByBidOrderId(int $bidOrderId): array
    {
        return $this->createQueryBuilder('bidOrderEntity')
            ->select('imageEntity.imagePath')

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.bidOrder = :bidOrderId'
            )

            ->setParameter('bidOrderId', $bidOrderId)

            ->andWhere('bidOrderEntity.id = :orderId')
            ->setParameter('orderId', $bidOrderId)

            ->getQuery()
            ->getSingleColumnResult();
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
            ->select('bidOrderEntity.id', 'bidOrderEntity.title', 'bidOrderEntity.description', 'bidOrderEntity.createdAt', 'bidOrderEntity.updatedAt', 'bidOrderEntity.openToPriceOffer')

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
            $query->andWhere('priceOfferEntity.priceOfferStatus = :offerStatus');
            $query->setParameter('offerStatus', $request->getPriceOfferStatus());
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
}
