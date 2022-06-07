<?php

namespace App\Repository;

use App\Constant\Image\ImageEntityTypeConstant;
use App\Entity\CaptainEntity;
use App\Entity\ImageEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method ImageEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ImageEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ImageEntity[]    findAll()
 * @method ImageEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ImageEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ImageEntity::class);
    }

    public function getImagesByItemIdAndEntityTypeAndImageAim(int $itemId, int $entityType, int $usedAs): ?array
    {
        return $this->createQueryBuilder('image')

            ->andWhere('image.itemId = :itemId')
            ->setParameter('itemId', $itemId)

            ->andWhere('image.entityType = :entityType')
            ->setParameter('entityType', $entityType)

            ->andWhere('image.usedAs = :usedAs')
            ->setParameter('usedAs', $usedAs)

            ->orderBy('image.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function getOneImageByItemIdAndEntityTypeAndImageAim(int $itemId, int $entityType, int $usedAs): ?ImageEntity
    {
        return $this->createQueryBuilder('image')

            ->andWhere('image.itemId = :itemId')
            ->setParameter('itemId', $itemId)

            ->andWhere('image.entityType = :entityType')
            ->setParameter('entityType', $entityType)

            ->andWhere('image.usedAs = :usedAs')
            ->setParameter('usedAs', $usedAs)

            ->orderBy('image.id', 'DESC')

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getImagesByItemIdAndEntityType(int $itemId, int $entityType): ?array
    {
        return $this->createQueryBuilder('image')

            ->andWhere('image.itemId = :itemId')
            ->setParameter('itemId', $itemId)

            ->andWhere('image.entityType = :entityType')
            ->setParameter('entityType', $entityType)

            ->orderBy('image.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function getAllBidOrderImages()
    {
        return $this->createQueryBuilder('imageEntity')

            ->andWhere('imageEntity.bidOrder IS NOT NULL')

            ->orderBy('imageEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function getAllCaptainProfileImagesEntitiesByCaptainId(int $captainId): array
    {
        return $this->createQueryBuilder('imageEntity')

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = imageEntity.itemId'
            )

            ->andWhere('captainEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->andWhere('imageEntity.entityType = :captainProfileType')
            ->setParameter('captainProfileType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)

            ->getQuery()
            ->getResult();
    }
}
