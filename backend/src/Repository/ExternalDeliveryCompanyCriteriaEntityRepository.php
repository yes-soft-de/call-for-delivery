<?php

namespace App\Repository;

use App\Entity\ExternalDeliveryCompanyCriteriaEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method ExternalDeliveryCompanyCriteriaEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ExternalDeliveryCompanyCriteriaEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ExternalDeliveryCompanyCriteriaEntity[]    findAll()
 * @method ExternalDeliveryCompanyCriteriaEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ExternalDeliveryCompanyCriteriaEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ExternalDeliveryCompanyCriteriaEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ExternalDeliveryCompanyCriteriaEntity $entity, bool $flush = true): void
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
    public function remove(ExternalDeliveryCompanyCriteriaEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }
}
