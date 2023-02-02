<?php

namespace App\Repository;

use App\Entity\DirectSupportScriptEntity;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptFilterByAdminRequest;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method DirectSupportScriptEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method DirectSupportScriptEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method DirectSupportScriptEntity[]    findAll()
 * @method DirectSupportScriptEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DirectSupportScriptEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DirectSupportScriptEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(DirectSupportScriptEntity $entity, bool $flush = true): void
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
    public function remove(DirectSupportScriptEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function filterDirectSupportScriptByAdmin(DirectSupportScriptFilterByAdminRequest $request): array
    {
        $query = $this->createQueryBuilder('directSupportScriptEntity')

            ->orderBy('directSupportScriptEntity.id', 'DESC');

        if ($request->getAppType()) {
            $query->andWhere('directSupportScriptEntity.appType = :specificAppType')
                ->setParameter('specificAppType', $request->getAppType());
        }

        if ($request->getAction()) {
            $query->andWhere('directSupportScriptEntity.action = :specificAction')
                ->setParameter('specificAction', $request->getAction());
        }

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
            || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterDirectSupportScriptEntitiesByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
        }

        return $query->getQuery()->getResult();
    }

    public function filterDirectSupportScriptEntitiesByDates(array $tempArrayResult, ?string $fromDate, ?string $toDate, ?string $timeZone): array
    {
        $filteredResult = [];

        if (count($tempArrayResult) > 0) {
            if (($fromDate != null || $fromDate != "") && ($toDate === null || $toDate === "")) {
                foreach ($tempArrayResult as $key => $value) {
                    if ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) >=
                        new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) {
                        $filteredResult[$key] = $value;
                    }
                }

            } elseif (($fromDate === null || $fromDate === "") && ($toDate != null || $toDate != "")) {
                foreach ($tempArrayResult as $key => $value) {
                    if ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) <=
                        new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59'))) {
                        $filteredResult[$key] = $value;
                    }
                }

            } elseif (($fromDate != null || $fromDate != "") && ($toDate != null || $toDate != "")) {
                foreach ($tempArrayResult as $key => $value) {
                    if (($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) >=
                            new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) &&
                        ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) <=
                            new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59')))) {
                        $filteredResult[$key] = $value;
                    }
                }
            }
        }

        return $filteredResult;
    }
}
