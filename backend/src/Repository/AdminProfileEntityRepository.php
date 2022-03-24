<?php

namespace App\Repository;

use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Entity\AdminProfileEntity;
use App\Entity\ImageEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
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

    public function getAdminProfileByAdminUserId(int $adminUserId): ?AdminProfileEntity
    {
        return $this->createQueryBuilder('profile')

            ->andWhere('profile.adminUserId = :adminUserId')
            ->setParameter('adminUserId', $adminUserId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAdminProfileWithImageByAdminUserId(int $adminUserId): ?array
    {
        return $this->createQueryBuilder('adminProfile')
            ->select('adminProfile.id', 'adminProfile.name', 'adminProfile.phone', 'adminProfile.createdAt', 'adminProfile.updatedAt')
            ->addSelect('imageEntity.imagePath')

            ->andWhere('adminProfile.adminUserId = :adminUserId')
            ->setParameter('adminUserId', $adminUserId)

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = adminProfile.id AND imageEntity.entityType = :adminEntityType AND imageEntity.usedAs = :adminImageProfile'
            )

            ->setParameter('adminEntityType', ImageEntityTypeConstant::ENTITY_TYPE_ADMIN_PROFILE)
            ->setParameter('adminImageProfile', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
