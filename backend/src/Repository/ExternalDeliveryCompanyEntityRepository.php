<?php

namespace App\Repository;

use App\Entity\ExternalDeliveryCompanyEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method ExternalDeliveryCompanyEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ExternalDeliveryCompanyEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ExternalDeliveryCompanyEntity[]    findAll()
 * @method ExternalDeliveryCompanyEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ExternalDeliveryCompanyEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ExternalDeliveryCompanyEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ExternalDeliveryCompanyEntity $entity, bool $flush = true): void
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
    public function remove(ExternalDeliveryCompanyEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function getAllExternalDeliveryCompaniesExceptSpecificOneById(int $externalDeliveryCompanyId): array
    {
        return $this->createQueryBuilder('externalDeliveryCompanyEntity')

            ->andWhere('externalDeliveryCompanyEntity.id != :companyId')
            ->setParameter('companyId', $externalDeliveryCompanyId)

            ->getQuery()
            ->getResult();
    }
}
