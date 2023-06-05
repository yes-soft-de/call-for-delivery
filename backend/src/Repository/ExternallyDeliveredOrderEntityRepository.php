<?php

namespace App\Repository;

use App\Entity\ExternallyDeliveredOrderEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method ExternallyDeliveredOrderEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ExternallyDeliveredOrderEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ExternallyDeliveredOrderEntity[]    findAll()
 * @method ExternallyDeliveredOrderEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ExternallyDeliveredOrderEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ExternallyDeliveredOrderEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ExternallyDeliveredOrderEntity $entity, bool $flush = true): void
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
    public function remove(ExternallyDeliveredOrderEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }
}
