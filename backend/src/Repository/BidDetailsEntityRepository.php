<?php

namespace App\Repository;

use App\Entity\BidDetailsEntity;
use App\Entity\PriceOfferEntity;
use App\Entity\SupplierProfileEntity;
use App\Request\Order\BidOrderFilterBySupplierRequest;
use DateTime;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method BidDetailsEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method BidDetailsEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method BidDetailsEntity[]    findAll()
 * @method BidDetailsEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class BidDetailsEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, BidDetailsEntity::class);
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
