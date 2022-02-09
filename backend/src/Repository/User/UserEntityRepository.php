<?php

namespace App\Repository\User;

use App\Entity\UserEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\Security\Core\Exception\UnsupportedUserException;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\PasswordUpgraderInterface;

/**
 * @method UserEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method UserEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method UserEntity[]    findAll()
 * @method UserEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class UserEntityRepository extends ServiceEntityRepository implements PasswordUpgraderInterface
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, UserEntity::class);
    }

    /**
     * Used to upgrade (rehash) the user's password automatically over time.
     */
    public function upgradePassword(PasswordAuthenticatedUserInterface $user, string $newHashedPassword): void
    {
        if (!$user instanceof UserEntity) {
            throw new UnsupportedUserException(sprintf('Instances of "%s" are not supported.', \get_class($user)));
        }

        $user->setPassword($newHashedPassword);
        $this->_em->persist($user);
        $this->_em->flush();
    }

    public function getUserByUserId($userId)
    {
        return $this->createQueryBuilder('user')
            ->select('user.id', 'user.userId')

            ->andWhere('user.userId = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserByUserIdAndRole($userId, $role)
    {
        return $this->createQueryBuilder('userEntity')
            ->select('userEntity.id', 'userEntity.userId')

            ->andWhere('userEntity.userId = :userId')
            ->setParameter('userId', $userId)

            ->andWhere('userEntity.roles LIKE :roles')
            ->setParameter('roles', '%"'.$role.'"%')

            ->getQuery()
            ->getOneOrNullResult();
    }

    // return user entity
    public function getUserEntityByUserId($userId)
    {
        return $this->createQueryBuilder('userEntity')

            ->andWhere('userEntity.userId = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserRoleByUserId($userId)
    {
        return $this->createQueryBuilder('userEntity')
            ->select('userEntity.roles')

            ->andWhere('userEntity.id = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
