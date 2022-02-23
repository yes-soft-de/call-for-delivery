<?php

namespace App\Repository;

use App\Constant\CompanyInfo\CompanyInfoConstant;
use App\Entity\CompanyInfoEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method CompanyInfoEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CompanyInfoEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CompanyInfoEntity[]    findAll()
 * @method CompanyInfoEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CompanyInfoEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CompanyInfoEntity::class);
    }

    public function getCompanyInfo(): ?array
    {
        return $this->createQueryBuilder('companyInfo')
            ->select('companyInfo.id', 'companyInfo.phone', 'companyInfo.phoneTwo', 'companyInfo.email', 'companyInfo.fax', 'companyInfo.whatsapp', 'companyInfo.bankName',
             'companyInfo.stc', 'companyInfo.kilometers', 'companyInfo.maxKilometerBonus', 'companyInfo.minKilometerBonus')

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCompanyInfoForUser(string $requiredByUserType, string $userId): ?array
    {
        $query = $this->createQueryBuilder('companyInfo')
            ->select('companyInfo.id', 'companyInfo.phone', 'companyInfo.phoneTwo', 'companyInfo.email', 'companyInfo.fax', 'companyInfo.whatsapp', 'companyInfo.bankName',
                'companyInfo.stc', 'companyInfo.kilometers', 'companyInfo.maxKilometerBonus', 'companyInfo.minKilometerBonus');

        // Another section will be added lately to this function for retrieving the uuid of user's profile according to his/her type

        return $query->getQuery()->getOneOrNullResult();
    }
}
