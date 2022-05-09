<?php

namespace App\Repository;

use App\Entity\UserEntity;
use App\Entity\VerificationEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method VerificationEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method VerificationEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method VerificationEntity[]    findAll()
 * @method VerificationEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class VerificationEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, VerificationEntity::class);
    }

    public function getByUserAndCode($user, string $code): ?array
    {
        return $this->createQueryBuilder('verificationEntity')
            ->select('verificationEntity.id', 'verificationEntity.code', 'verificationEntity.createdAt')

            ->andWhere('verificationEntity.code = :verificationCode')
            ->setParameter('verificationCode', $code)

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.id = verificationEntity.user'
            )

            ->andWhere('userEntity.id = :userId')
            ->setParameter('userId', $user)

            ->getQuery()
            ->getOneOrNullResult();
    }

    // return array of verification entities
    public function getVerificationCodeByUserId(string $userId): array
    {
        return $this->createQueryBuilder('verificationEntity')

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.id = verificationEntity.user'
            )

            ->andWhere('userEntity.userId = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getResult();
    }
}
