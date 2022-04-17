<?php

namespace App\Repository;

use App\Entity\BidOrderEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
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
}
