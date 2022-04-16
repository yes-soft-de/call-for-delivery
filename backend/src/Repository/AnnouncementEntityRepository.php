<?php

namespace App\Repository;

use App\Entity\AnnouncementEntity;
use App\Entity\SupplierProfileEntity;
use App\Request\Admin\Announcement\AnnouncementFilterByAdminRequest;
use App\Request\Announcement\AnnouncementFilterBySupplierRequest;
use DateTime;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method AnnouncementEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method AnnouncementEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method AnnouncementEntity[]    findAll()
 * @method AnnouncementEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AnnouncementEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, AnnouncementEntity::class);
    }

    public function filterAnnouncementsByAdmin(AnnouncementFilterByAdminRequest $request): array
    {
        $query = $this->createQueryBuilder('announcementEntity')

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.id = announcementEntity.supplier'
            )

            ->orderBy('announcementEntity.id', 'DESC');

        if ($request->getSupplierProfileId()) {
            $query->andWhere('announcementEntity.supplier = :supplierProfileId');
            $query->setParameter('supplierProfileId', $request->getSupplierProfileId());
        }

        if ($request->getSupplierCategoryId()) {
            $query->andWhere('supplierProfileEntity.supplierCategory = :supplierCategoryId');
            $query->setParameter('supplierCategoryId', $request->getSupplierCategoryId());
        }

        if ($request->getStatus() !== null) {
            $query->andWhere('announcementEntity.status = :status');
            $query->setParameter('status', $request->getStatus());
        }

        if ($request->getAdministrationStatus() !== null) {
            $query->andWhere('announcementEntity.administrationStatus = :administrationStatus');
            $query->setParameter('administrationStatus', $request->getAdministrationStatus());
        }

        if (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === "")) {
            $query->andWhere('announcementEntity.createdAt >= :createdAt');
            $query->setParameter('createdAt', $request->getFromDate());

        } elseif (($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('announcementEntity.createdAt <= :createdAt');
            $query->setParameter('createdAt', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));

        } elseif (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('announcementEntity.createdAt >= :fromDate');
            $query->setParameter('fromDate', $request->getFromDate());

            $query->andWhere('announcementEntity.createdAt <= :toDate');
            $query->setParameter('toDate', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));
        }

        return $query->getQuery()->getResult();
    }

    public function filterAnnouncementsBySupplier(AnnouncementFilterBySupplierRequest $request): array
    {
        $query = $this->createQueryBuilder('announcementEntity')

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.id = announcementEntity.supplier'
            )

            ->andWhere('supplierProfileEntity.user = :supplierId')
            ->setParameter('supplierId', $request->getSupplierId())

            ->orderBy('announcementEntity.id', 'DESC');

        if ($request->getStatus() !== null) {
            $query->andWhere('announcementEntity.status = :status');
            $query->setParameter('status', $request->getStatus());
        }

        if ($request->getAdministrationStatus() !== null) {
            $query->andWhere('announcementEntity.administrationStatus = :administrationStatus');
            $query->setParameter('administrationStatus', $request->getAdministrationStatus());
        }

        if (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === "")) {
            $query->andWhere('announcementEntity.createdAt >= :createdAt');
            $query->setParameter('createdAt', $request->getFromDate());

        } elseif (($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('announcementEntity.createdAt <= :createdAt');
            $query->setParameter('createdAt', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));

        } elseif (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('announcementEntity.createdAt >= :fromDate');
            $query->setParameter('fromDate', $request->getFromDate());

            $query->andWhere('announcementEntity.createdAt <= :toDate');
            $query->setParameter('toDate', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));
        }

        return $query->getQuery()->getResult();
    }
}
