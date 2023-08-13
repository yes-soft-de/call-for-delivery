<?php

namespace App\Repository;

use App\Entity\EPaymentFromStoreLogEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method EPaymentFromStoreLogEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method EPaymentFromStoreLogEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method EPaymentFromStoreLogEntity[]    findAll()
 * @method EPaymentFromStoreLogEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class EPaymentFromStoreLogEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, EPaymentFromStoreLogEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(EPaymentFromStoreLogEntity $entity, bool $flush = true): void
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
    public function remove(EPaymentFromStoreLogEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }
}
