<?php

namespace App\Repository;

use App\Entity\ImageEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
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

    public function getImagesByItemIdAndEntityTypeAndImageAim(int $itemId, string $entityType, string $imageAim): ?array
    {
        return $this->createQueryBuilder('image')
            ->select('image.id', 'image.entityType', 'image.imageAim', 'image.imagePath', 'image.itemId')

            ->andWhere('image.itemId = :itemId')
            ->setParameter('itemId', $itemId)

            ->andWhere('image.entityType = :entityType')
            ->setParameter('entityType', $entityType)

            ->andWhere('image.imageAim = :imageAim')
            ->setParameter('imageAim', $imageAim)

            ->orderBy('image.id', 'DESC')

            ->getQuery()
            ->getResult();
    }
}
