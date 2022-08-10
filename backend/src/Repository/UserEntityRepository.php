<?php

namespace App\Repository;

use App\Constant\User\UserRoleConstant;
use App\Entity\SupplierProfileEntity;
use App\Entity\UserEntity;
use App\Entity\CaptainEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Request\User\UserFilterRequest;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\Security\Core\Exception\UnsupportedUserException;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\PasswordUpgraderInterface;
use Doctrine\ORM\Query\Expr\Join;

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

    public function getUserByUserId($userId): mixed
    {
        return $this->createQueryBuilder('user')
            ->select('user.id', 'user.userId', 'user.roles')

            ->andWhere('user.userId = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserByUserIdAndRole(string $userId, string $role): ?UserEntity
    {
        return $this->createQueryBuilder('userEntity')

            ->andWhere('userEntity.userId = :userId')
            ->setParameter('userId', $userId)

            ->andWhere('userEntity.roles LIKE :roles')
            ->setParameter('roles', '%"'.$role.'"%')

            ->getQuery()
            ->getOneOrNullResult();
    }

    // return user entity
    public function getUserEntityByUserId($userId): mixed
    {
        return $this->createQueryBuilder('userEntity')

            ->andWhere('userEntity.userId = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserRoleByUserId($userId): mixed
    {
        return $this->createQueryBuilder('userEntity')
            ->select('userEntity.roles')

            ->andWhere('userEntity.id = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function filterUsersBySuperAdmin(UserFilterRequest $request): ?array
    {
        $query = $this->createQueryBuilder('userEntity')
            ->select('userEntity.id', 'userEntity.userId', 'userEntity.roles');

        if($request->getUserId()) {
            $query->andWhere('userEntity.userId = :userId');
            $query->setParameter('userId', $request->getUserId());
        }

        if($request->getRole()) {
            $query->andWhere('userEntity.roles LIKE :roles');
            $query->setParameter('roles', '%'.$request->getRole().'%');
        }

        $query->orderBy('userEntity.id', 'DESC');

        $tempQuery = $query->getQuery()->getResult();

        // here we just add "completeAccountStatus" to each user depending on its roles
        if (! empty($tempQuery)) {
            return $this->addCompleteAccountStatusToResult($tempQuery);
        }

        return $query->getQuery()->getResult();
    }

    public function getUserByCaptainProfileId($captainProfileId): mixed
    {
        return $this->createQueryBuilder('userEntity')

            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.captainId = userEntity.id')
           
            ->andWhere('captainEntity.id = :captainProfileId')
           
            ->setParameter('captainProfileId', $captainProfileId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserByStoreProfileId($storeProfileId): ?UserEntity 
    {
        return $this->createQueryBuilder('userEntity')

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.storeOwnerId = userEntity.id')
           
            ->andWhere('storeOwnerProfileEntity.id = :storeProfileId')
           
            ->setParameter('storeProfileId', $storeProfileId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserBySupplierProfileId(int $supplierProfileId): ?UserEntity
    {
        return $this->createQueryBuilder('userEntity')

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.user = userEntity.id')

            ->andWhere('supplierProfileEntity.id = :supplierProfileId')
            ->setParameter('supplierProfileId', $supplierProfileId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserVerificationStatusByUserId(string $userId): ?array
    {
        return $this->createQueryBuilder('userEntity')
            ->select('userEntity.verificationStatus')

            ->andWhere('userEntity.userId = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getSupplierUsersEntitiesBySupplierCategoryId(int $supplierCategoryId): array
    {
        return $this->createQueryBuilder('userEntity')

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.user = userEntity.id'
            )

            ->andWhere('supplierProfileEntity.supplierCategories LIKE :supplierCategoryId')
            ->setParameter('supplierCategoryId', '%"'.$supplierCategoryId.'"%')

            ->getQuery()
            ->getResult();
    }

    // this function just added "completeAccountStatus" field to each user of the "result" array
    public function addCompleteAccountStatusToResult(array $result): array
    {
        foreach ($result as $key => $value) {
            if (in_array(UserRoleConstant::ROLE_CAPTAIN, $value['roles'])) {
                $result[$key]['completeAccountStatus']  = $this->getCaptainAccountStatusByUserId($value['id']);

            } elseif (in_array(UserRoleConstant::ROLE_OWNER, $value['roles'])) {
                $result[$key]['completeAccountStatus']  = $this->getStoreAccountStatusByUserId($value['id']);

            } elseif (in_array(UserRoleConstant::ROLE_SUPPLIER, $value['roles'])) {
                $result[$key]['completeAccountStatus']  = $this->getSupplierAccountStatusByUserId($value['id']);
            }
        }

        return $result;
    }

    public function getCaptainAccountStatusByUserId(int $userId): string
    {
        return $this->createQueryBuilder('userEntity')

            ->select('captainEntity.completeAccountStatus')

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.captainId = userEntity.id'
            )

            ->andWhere('userEntity.id = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function getStoreAccountStatusByUserId(int $userId): string
    {
        return $this->createQueryBuilder('userEntity')

            ->select('storeOwnerProfileEntity.completeAccountStatus')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.storeOwnerId = userEntity.id'
            )

            ->andWhere('userEntity.id = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function getSupplierAccountStatusByUserId(int $userId): string
    {
        return $this->createQueryBuilder('userEntity')

            ->select('supplierProfileEntity.completeAccountStatus')

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.user = userEntity.id'
            )

            ->andWhere('userEntity.id = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getSingleScalarResult();
    }
}
