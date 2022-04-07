<?php

namespace App\Manager\Admin\SupplierCategory;

use App\AutoMapping;
use App\Entity\SupplierCategoryEntity;
use App\Request\Admin\SupplierCategory\SupplierCategoryCreateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminSupplierCategoryManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
    }

    public function createSupplierCategoryByAdmin(SupplierCategoryCreateByAdminRequest $request): SupplierCategoryEntity
    {
        $supplierCategoryEntity = $this->autoMapping->map(SupplierCategoryCreateByAdminRequest::class, SupplierCategoryEntity::class, $request);

        $this->entityManager->persist($supplierCategoryEntity);
        $this->entityManager->flush();

        return $supplierCategoryEntity;
    }
}
