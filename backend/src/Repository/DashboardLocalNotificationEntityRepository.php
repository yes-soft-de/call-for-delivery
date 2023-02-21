<?php

namespace App\Repository;

use App\Entity\DashboardLocalNotificationEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method DashboardLocalNotificationEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method DashboardLocalNotificationEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method DashboardLocalNotificationEntity[]    findAll()
 * @method DashboardLocalNotificationEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DashboardLocalNotificationEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DashboardLocalNotificationEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(DashboardLocalNotificationEntity $entity, bool $flush = true): void
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
    public function remove(DashboardLocalNotificationEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }
}
