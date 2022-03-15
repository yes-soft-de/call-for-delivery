<?php

namespace App\Repository;

use App\Entity\CaptainOfferEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Constant\CaptainOfferConstant\CaptainOfferConstant;

/**
 * @method CaptainOfferEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainOfferEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainOfferEntity[]    findAll()
 * @method CaptainOfferEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainOfferEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainOfferEntity::class);
    }

    public function getCaptainOffers(): array
    {
        return $this->createQueryBuilder('captainOfferEntity')

            ->andWhere('captainOfferEntity.status = :status')

            ->setParameter('status', CaptainOfferConstant::STATUS_ACTIVE)
            
            ->orderBy('captainOfferEntity.id', 'DESC')
            
            ->getQuery()

            ->getResult();
    }

    public function getCaptainOffersForAdmin(): ?array
    {
        return $this->createQueryBuilder('captainOfferEntity')
            ->select('captainOfferEntity.id', 'captainOfferEntity.carCount', 'captainOfferEntity.status' ,'captainOfferEntity.expired', 'captainOfferEntity.price')
            
            ->orderBy('captainOfferEntity.id', 'DESC')
            
            ->getQuery()

            ->getResult();
    }
}
