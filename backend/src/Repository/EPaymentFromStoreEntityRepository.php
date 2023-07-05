<?php

namespace App\Repository;

use App\Entity\EPaymentFromStoreEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method EPaymentFromStoreEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method EPaymentFromStoreEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method EPaymentFromStoreEntity[]    findAll()
 * @method EPaymentFromStoreEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class EPaymentFromStoreEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, EPaymentFromStoreEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(EPaymentFromStoreEntity $entity, bool $flush = true): void
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
    public function remove(EPaymentFromStoreEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }
}
