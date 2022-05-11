<?php

namespace App\Repository;

use App\Entity\ResetPasswordOrderEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method ResetPasswordOrderEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ResetPasswordOrderEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ResetPasswordOrderEntity[]    findAll()
 * @method ResetPasswordOrderEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ResetPasswordOrderEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ResetPasswordOrderEntity::class);
    }

    public function getResetPasswordOrderByCode(string $code): ?array
    {
        return $this->createQueryBuilder('resetPasswordOrderEntity')
            ->select('resetPasswordOrderEntity.id', 'resetPasswordOrderEntity.code', 'resetPasswordOrderEntity.createdAt')

            ->andWhere('resetPasswordOrderEntity.code = :code')
            ->setParameter('code', $code)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getResetPasswordOrderByActiveCode(string $code): ?ResetPasswordOrderEntity
    {
        return $this->createQueryBuilder('resetPasswordOrderEntity')

            ->andWhere('resetPasswordOrderEntity.code = :code')
            ->setParameter('code', $code)

            ->andWhere('resetPasswordOrderEntity.codeStatus = :activeStatus')
            ->setParameter('activeStatus', 1)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
