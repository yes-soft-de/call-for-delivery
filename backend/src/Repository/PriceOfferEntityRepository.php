<?php

namespace App\Repository;

use App\Entity\PriceOfferEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
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

    public function getPriceOffersByBidOrderIdForStoreOwner(int $bidOrderId): array
    {
        return $this->createQueryBuilder('priceOfferEntity')
            ->select('priceOfferEntity.id', 'priceOfferEntity.createdAt', 'priceOfferEntity.updatedAt', 'priceOfferEntity.priceOfferValue', 'priceOfferEntity.priceOfferStatus', 'priceOfferEntity.offerDeadline')

            ->andWhere('priceOfferEntity.bidOrder = :bidOrderId')
            ->setParameter('bidOrderId', $bidOrderId)

            ->orderBy('priceOfferEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }
}
