<?php

namespace App\Manager\SupplierCategory;

use App\Entity\SupplierCategoryEntity;
use App\Repository\SupplierCategoryEntityRepository;

class SupplierCategoryManager
{
    private SupplierCategoryEntityRepository $supplierCategoryEntityRepository;

    public function __construct(SupplierCategoryEntityRepository $supplierCategoryEntityRepository)
    {
        $this->supplierCategoryEntityRepository = $supplierCategoryEntityRepository;
    }

    public function getSupplierCategoryEntityByCategoryId(int $supplierCategoryId): ?SupplierCategoryEntity
    {
        return $this->supplierCategoryEntityRepository->find($supplierCategoryId);
    }

    public function getAllActiveSupplierCategories(): array
    {
        return $this->supplierCategoryEntityRepository->getAllActiveSupplierCategories();
    }

    public function getAllActiveSupplierCategoriesIDs(): array
    {
        return $this->supplierCategoryEntityRepository->getAllActiveSupplierCategoriesIDs();
    }

    public function getSupplierCategoriesNamesBySupplierCategoriesIDs(array $supplierCategoriesIDs): array
    {
        return $this->supplierCategoryEntityRepository->getSupplierCategoriesNamesBySupplierCategoriesIDs($supplierCategoriesIDs);
    }
}
