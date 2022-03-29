<?php

namespace App\DataFixtures\Package;

use App\Constant\Package\PackageConstant;
use App\Entity\PackageCategoryEntity;
use App\Entity\PackageEntity;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Persistence\ObjectManager;

class PackageFixtures extends Fixture implements DependentFixtureInterface
{
    public function load(ObjectManager $manager): void
    {
        for($counter = 1; $counter < 11; $counter++) {
            $packageEntity = new PackageEntity();

            $packageEntity->setName("الباقات المتزامنة " . $counter);
            $packageEntity->setCost($counter + 0);
            $packageEntity->setCarCount($counter);
            $packageEntity->setOrderCount($counter);
            $packageEntity->setCity("جدة");
            $packageEntity->setExpired($counter);
            $packageEntity->setNote("تتيح لك الطلب طول فترة دوام المؤسسة/الشركة");
            $packageEntity->setPackageCategory($manager->getRepository(PackageCategoryEntity::class)->find($counter));
            $packageEntity->setStatus(PackageConstant::PACKAGE_ACTIVE);

            $manager->persist($packageEntity);
        }

        $manager->flush();
    }

    // This ensure to load PackageCategoryFixtures before PackageFixture
    public function getDependencies(): array
    {
        return [
            PackageCategoryFixtures::class,
        ];
    }
}
