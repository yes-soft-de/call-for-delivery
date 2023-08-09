<?php

namespace App\Repository;

use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyStatusConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaIsDistanceConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaPaymentConstant;
use App\Entity\ExternalDeliveryCompanyCriteriaEntity;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaCreateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaUpdateByAdminRequest;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method ExternalDeliveryCompanyCriteriaEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ExternalDeliveryCompanyCriteriaEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ExternalDeliveryCompanyCriteriaEntity[]    findAll()
 * @method ExternalDeliveryCompanyCriteriaEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ExternalDeliveryCompanyCriteriaEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ExternalDeliveryCompanyCriteriaEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ExternalDeliveryCompanyCriteriaEntity $entity, bool $flush = true): void
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
    public function remove(ExternalDeliveryCompanyCriteriaEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function getExternalDeliveryCompanyCriteriaBySpecificCriteriaAndCompany(ExternalDeliveryCompanyCriteriaCreateByAdminRequest|ExternalDeliveryCompanyCriteriaUpdateByAdminRequest $request)
    {
        $query = $this->createQueryBuilder('externalDeliveryCompanyCriteriaEntity')

            ->andWhere('externalDeliveryCompanyCriteriaEntity.externalDeliveryCompany != :specificCompanyId')
            ->setParameter('specificCompanyId', $request->getExternalDeliveryCompany()->getId())

            ->andWhere('externalDeliveryCompanyCriteriaEntity.isSpecificDate = :hasSpecificDate')
            ->setParameter('hasSpecificDate', $request->isSpecificDate())

            ->andWhere('externalDeliveryCompanyCriteriaEntity.isDistance = :hasSpecificDistance')
            ->setParameter('hasSpecificDistance', $request->getIsDistance())

            ->andWhere('externalDeliveryCompanyCriteriaEntity.payment = :paymentOption')
            ->setParameter('paymentOption', $request->getPayment())

            ->andWhere('externalDeliveryCompanyCriteriaEntity.isFromAllStores = :isFromAllStoresOption')
            ->setParameter('isFromAllStoresOption', $request->isFromAllStores())

            ->andWhere('externalDeliveryCompanyCriteriaEntity.status = :offStatus')
            ->setParameter('offStatus', ExternalDeliveryCompanyStatusConstant::STATUS_TRUE_CONST);

//        if ($request->getIsDistance() === ExternalDeliveryCompanyCriteriaIsDistanceConstant::IS_DISTANCE_STORE_BRANCH_TO_CLIENT_DISTANCE_CONST) {
//            if (($request->getFromDistance()) && ($request->getToDistance())) {//dd($request->getFromDistance(), $request->getToDistance());
//                $query->andWhere('(externalDeliveryCompanyCriteriaEntity.fromDistance <= :fromDistanceLimit)'
//                    .'OR (externalDeliveryCompanyCriteriaEntity.fromDistance >= :fromDistanceLimit)');
//                $query->andWhere('(externalDeliveryCompanyCriteriaEntity.toDistance <= :toDistanceLimit)'
//                    .'OR (externalDeliveryCompanyCriteriaEntity.toDistance >= :toDistanceLimit)');
//                $query->andWhere('(externalDeliveryCompanyCriteriaEntity.fromDistance < :toDistanceLimit)');
//                $query->andWhere('(externalDeliveryCompanyCriteriaEntity.toDistance > :fromDistanceLimit)');
//
//                $query->setParameter('fromDistanceLimit', $request->getFromDistance());
//
////                $query->andWhere('(externalDeliveryCompanyCriteriaEntity.toDistance <= :toDistanceLimit)'
////                        .'OR (externalDeliveryCompanyCriteriaEntity.toDistance >= :toDistanceLimit)');
//                $query->setParameter('toDistanceLimit', $request->getToDistance());
//
////                $query->andWhere('(externalDeliveryCompanyCriteriaEntity.fromDistance < :toDistanceLimit)');
////                $query->setParameter('toDistanceLimit', $request->getToDistance());
////
////                $query->andWhere('(externalDeliveryCompanyCriteriaEntity.toDistance > :fromDistanceLimit)');
////                $query->setParameter('fromDistanceLimit', $request->getFromDistance());
//            }
//        }

        if (($request->getPayment() === ExternalDeliveryCompanyCriteriaPaymentConstant::PAYMENT_BOTH_CARD_AND_CASH_CONST)
            || ($request->getPayment() === ExternalDeliveryCompanyCriteriaPaymentConstant::PAYMENT_CASH_CONST)) {
            if ($request->getCashLimit()) {
                $query->andWhere('externalDeliveryCompanyCriteriaEntity.cashLimit = :specificLimit')
                    ->setParameter('specificLimit', $request->getCashLimit());
            }
        }

        return $query->getQuery()->getResult();
    }
}
