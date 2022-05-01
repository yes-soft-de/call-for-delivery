<?php

namespace App\Repository;

use App\Entity\DeliveryCarEntity;
use App\Entity\PriceOfferEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method PriceOfferEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method PriceOfferEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method PriceOfferEntity[]    findAll()
 * @method PriceOfferEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class PriceOfferEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, PriceOfferEntity::class);
    }

    public function getPriceOffersByBidOrderIdForStoreOwner(int $bidDetailsId): array
    {
        return $this->createQueryBuilder('priceOfferEntity')
            ->select('priceOfferEntity.id', 'priceOfferEntity.createdAt', 'priceOfferEntity.updatedAt', 'priceOfferEntity.priceOfferValue', 'priceOfferEntity.priceOfferStatus', 'priceOfferEntity.offerDeadline',
                'deliveryCarEntity.id as deliveryCarId', 'deliveryCarEntity.deliveryCost', 'deliveryCarEntity.carModel', 'deliveryCarEntity.details')

            ->Join(
                DeliveryCarEntity::class,
                'deliveryCarEntity',
                Join::WITH,
                'deliveryCarEntity.id = priceOfferEntity.deliveryCar'
            )

            ->andWhere('priceOfferEntity.bidDetails = :bidDetailsId')
            ->setParameter('bidDetailsId', $bidDetailsId)

            ->orderBy('priceOfferEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function getAllPricesOffersOfBidOrderExceptedOne(int $bidDetails, int $exceptedPriceOfferId): array
    {
        return $this->createQueryBuilder('priceOfferEntity')

            ->andWhere('priceOfferEntity.bidDetails = :bidDetails')
            ->setParameter('bidDetails', $bidDetails)

            ->andWhere('priceOfferEntity.id != :priceOfferId')
            ->setParameter('priceOfferId', $exceptedPriceOfferId)

            ->orderBy('priceOfferEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }
}
