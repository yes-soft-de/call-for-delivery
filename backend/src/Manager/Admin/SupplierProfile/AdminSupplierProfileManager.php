<?php

namespace App\Manager\Admin\SupplierProfile;

use App\AutoMapping;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Entity\SupplierProfileEntity;
use App\Repository\SupplierProfileEntityRepository;
use App\Request\Admin\SupplierProfile\SupplierProfileFilterByAdminRequest;
use App\Request\Admin\SupplierProfile\SupplierProfileStatusUpdateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminSupplierProfileManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private SupplierProfileEntityRepository $supplierProfileEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, SupplierProfileEntityRepository $supplierProfileEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->supplierProfileEntityRepository = $supplierProfileEntityRepository;
    }

    public function updateSupplierProfileStatusByAdmin(SupplierProfileStatusUpdateByAdminRequest $request): string|SupplierProfileEntity
    {
        $supplierProfileEntity = $this->supplierProfileEntityRepository->find($request->getId());

        if (! $supplierProfileEntity) {
            return SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST;
        }

        $supplierProfileEntity = $this->autoMapping->mapToObject(SupplierProfileStatusUpdateByAdminRequest::class, SupplierProfileEntity::class,
            $request, $supplierProfileEntity);

        $this->entityManager->flush();

        return $supplierProfileEntity;
    }

    public function filterSupplierProfileByAdmin(SupplierProfileFilterByAdminRequest $request): array
    {
        return $this->supplierProfileEntityRepository->filterSupplierProfileByAdmin($request);
    }
}
