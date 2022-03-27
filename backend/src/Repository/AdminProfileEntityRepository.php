<?php

namespace App\Repository;

use App\Entity\AdminProfileEntity;
use App\Entity\UserEntity;
use App\Request\Admin\AdminProfile\FilterAdminProfilesRequest;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method AdminProfileEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method AdminProfileEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method AdminProfileEntity[]    findAll()
 * @method AdminProfileEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AdminProfileEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, AdminProfileEntity::class);
    }

    public function getAdminProfileByAdminUserId(UserEntity $userEntity): ?AdminProfileEntity
    {
        return $this->createQueryBuilder('profile')

            ->andWhere('profile.user = :userEntity')
            ->setParameter('userEntity', $userEntity)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAdminProfileByUserId(int $userId): ?AdminProfileEntity
    {
        return $this->createQueryBuilder('profile')

            ->andWhere('profile.user = :userId')
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function filterAdminProfiles(FilterAdminProfilesRequest $request): array
    {
        $query = $this->createQueryBuilder('adminProfile')

            ->orderBy('adminProfile.id', 'DESC');

        if ($request->getName() != null || $request->getName() != "") {
            $query->andWhere('adminProfile.name LIKE :name');
            $query->setParameter('name', '%'.$request->getName().'%');
        }

        if ($request->getPhone() != null || $request->getPhone() != "") {
            $query->andWhere('adminProfile.phone LIKE :phone');
            $query->setParameter('phone', '%'.$request->getPhone().'%');
        }

        return $query->getQuery()->getResult();
    }
}
