<?php

namespace App\DataFixtures\Package;

use App\Entity\PackageCategoryEntity;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class PackageCategoryFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        for($counter = 1; $counter < 11; $counter++) {
            $packageCategoryEntity = new PackageCategoryEntity();

            $packageCategoryEntity->setName("الباقات المتزامنة " . $counter);
            $packageCategoryEntity->setDescription("تصنيف الباقات المتزامنة " . $counter);

            $manager->persist($packageCategoryEntity);
        }

        $manager->flush();
    }
}
