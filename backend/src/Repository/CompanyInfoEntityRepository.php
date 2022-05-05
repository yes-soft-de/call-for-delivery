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

    public function getCompanyInfoForUser(string $requiredByUserType): ?array
    {
        $query = $this->createQueryBuilder('companyInfo')
            ->select('companyInfo.id', 'companyInfo.phone', 'companyInfo.phoneTwo', 'companyInfo.email', 'companyInfo.fax', 'companyInfo.whatsapp', 'companyInfo.bankName',
                'companyInfo.stc', 'companyInfo.kilometers', 'companyInfo.maxKilometerBonus', 'companyInfo.minKilometerBonus');

        if ($requiredByUserType === CompanyInfoConstant::COMPANY_INFO_REQUIRED_BY_SUPPLIER) {
            $query->addSelect('companyInfo.supplierProfitMargin');
        }

        if ($requiredByUserType === CompanyInfoConstant::COMPANY_INFO_REQUIRED_BY_STORE_OWNER) {
            $query->addSelect('companyInfo.storeProfitMargin');
        }

        return $query->getQuery()->getOneOrNullResult();
    }
}
