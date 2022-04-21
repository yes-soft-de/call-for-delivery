<?php

namespace App\Repository;

use App\Entity\DeliveryCarEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method DeliveryCarEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method DeliveryCarEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method DeliveryCarEntity[]    findAll()
 * @method DeliveryCarEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DeliveryCarEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DeliveryCarEntity::class);
    }
}
