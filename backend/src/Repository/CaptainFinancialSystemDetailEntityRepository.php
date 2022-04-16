<?php

namespace App\Repository;

use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Entity\CaptainFinancialSystemAccordingToCountOfHoursEntity;
use App\Entity\CaptainFinancialSystemAccordingOnOrderEntity;
use App\Entity\CaptainFinancialSystemAccordingToCountOfOrdersEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Entity\AdminProfileEntity;

/**
 * @method CaptainFinancialSystemDetailEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainFinancialSystemDetailEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainFinancialSystemDetailEntity[]    findAll()
 * @method CaptainFinancialSystemDetailEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainFinancialSystemDetailEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainFinancialSystemDetailEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(CaptainFinancialSystemDetailEntity $entity, bool $flush = true): void
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
    public function remove(CaptainFinancialSystemDetailEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }
    
    public function getCaptainFinancialSystemDetailCurrent(int $captainId): ?array
    {
        $query = $this->createQueryBuilder('captainFinancialSystemDetailEntity');

        $query->select('captainFinancialSystemDetailEntity.id', 'captainFinancialSystemDetailEntity.createdAt', 'captainFinancialSystemDetailEntity.updatedAt', 'captainFinancialSystemDetailEntity.captainFinancialSystemType');

        $query->where('captainFinancialSystemDetailEntity.captain = :captainId');
        $query->setParameter('captainId', $captainId);
        //TODO remove comments next time
        // $query->andWhere('captainFinancialSystemDetailEntity.status = :status');
        // $query->setParameter('status', CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ACTIVE);
        $item = $query->addSelect('captainFinancialSystemDetailEntity.captainFinancialSystemType')->getQuery()->getOneOrNullResult();
       
        if($item) {
            if ($item['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
            
                $query->addSelect('systemOne.countHours', 'systemOne.compensationForEveryOrder', 'systemOne.salary');
                
                $query->leftJoin(CaptainFinancialSystemAccordingToCountOfHoursEntity::class, 'systemOne', Join::WITH, 'systemOne.id = captainFinancialSystemDetailEntity.captainFinancialSystemId');

                return $query->getQuery()->getOneOrNullResult();
            }

            if ($item['captainFinancialSystemType']  === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {

                $query->addSelect('systemTwo.countOrdersInMonth', 'systemTwo.salary', 'systemTwo.monthCompensation', 'systemTwo.bounceMaxCountOrdersInMonth', 'systemTwo.bounceMinCountOrdersInMonth');
                
                $query->leftJoin(CaptainFinancialSystemAccordingToCountOfOrdersEntity::class, 'systemTwo', Join::WITH, 'systemTwo.id = captainFinancialSystemDetailEntity.captainFinancialSystemId');
                      
                return $query->getQuery()->getOneOrNullResult();     
            }
        }

        return $query->getQuery()->getOneOrNullResult();
    }

    public function getLatestFinancialCaptainSystemDetailsForAdmin(int $captainId): ?array
    {
        $query = $this->createQueryBuilder('captainFinancialSystemDetailEntity');

        $query->select('captainFinancialSystemDetailEntity.id', 'captainFinancialSystemDetailEntity.createdAt', 'captainFinancialSystemDetailEntity.updatedAt', 'captainFinancialSystemDetailEntity.captainFinancialSystemType', 'captainFinancialSystemDetailEntity.status');
       
        $query->addSelect('adminProfileEntity.name as updatedBy');

        $query->leftJoin(AdminProfileEntity::class, 'adminProfileEntity', Join::WITH, 'adminProfileEntity.user = captainFinancialSystemDetailEntity.updatedBy');

        $query->where('captainFinancialSystemDetailEntity.captain = :captainId');
        $query->setParameter('captainId', $captainId);
       
        $item = $query->addSelect('captainFinancialSystemDetailEntity.captainFinancialSystemType')->getQuery()->getOneOrNullResult();
       
        $query->orderBy('captainFinancialSystemDetailEntity.id', 'DESC');
        $query->setMaxResults(1);

        if($item) {
            if ($item['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
            
                $query->addSelect('systemOne.countHours', 'systemOne.compensationForEveryOrder', 'systemOne.salary');
                
                $query->leftJoin(CaptainFinancialSystemAccordingToCountOfHoursEntity::class, 'systemOne', Join::WITH, 'systemOne.id = captainFinancialSystemDetailEntity.captainFinancialSystemId');

                return $query->getQuery()->getOneOrNullResult();
            }

            if ($item['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {
            
                $query->addSelect('systemTwo.countOrdersInMonth', 'systemTwo.salary', 'systemTwo.monthCompensation', 'systemTwo.bounceMaxCountOrdersInMonth', 'systemTwo.bounceMinCountOrdersInMonth');
                
                $query->leftJoin(CaptainFinancialSystemAccordingToCountOfOrdersEntity::class, 'systemTwo', Join::WITH, 'systemTwo.id = captainFinancialSystemDetailEntity.captainFinancialSystemId');
        
                return $query->getQuery()->getOneOrNullResult();     
            }
        
            if ($item['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
                $query->addSelect('systemThree.categoryName', 'systemThree.countKilometersFrom', 'systemThree.countKilometersTo', 'systemThree.amount', 'systemThree.bounce', 'systemThree.bounceCountOrdersInMonth');
                
                $query->leftJoin(CaptainFinancialSystemAccordingOnOrderEntity::class, 'systemThree', Join::WITH, 'systemThree.id = captainFinancialSystemDetailEntity.captainFinancialSystemId');
        
                return $query->getQuery()->getOneOrNullResult();
            }
        }

        return $query->getQuery()->getOneOrNullResult();
    }
}
