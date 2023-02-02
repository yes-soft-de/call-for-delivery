<?php

namespace App\Manager\Admin\DirectSupportScript;

use App\AutoMapping;
use App\Constant\DirectSupportScript\DirectSupportScriptResultConstant;
use App\Entity\DirectSupportScriptEntity;
use App\Repository\DirectSupportScriptEntityRepository;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptCreateByAdminRequest;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptDeleteByRequest;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptFilterByAdminRequest;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptUpdateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminDirectSupportScriptManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private DirectSupportScriptEntityRepository $directSupportScriptEntityRepository
    )
    {
    }

    public function createDirectSupportScriptByAdmin(DirectSupportScriptCreateByAdminRequest $request): DirectSupportScriptEntity
    {
        $directSupportScriptEntity = $this->autoMapping->map(DirectSupportScriptCreateByAdminRequest::class, DirectSupportScriptEntity::class,
            $request);

        $this->entityManager->persist($directSupportScriptEntity);
        $this->entityManager->flush();

        return $directSupportScriptEntity;
    }

    public function updateDirectSupportScriptByAdmin(DirectSupportScriptUpdateByAdminRequest $request): int|DirectSupportScriptEntity
    {
        $directSupportScriptEntity = $this->directSupportScriptEntityRepository->findOneBy(['id' => $request->getId()]);

        if (! $directSupportScriptEntity) {
            return DirectSupportScriptResultConstant::DIRECT_SUPPORT_SCRIPT_NOT_EXIST_CONST;
        }

        $directSupportScriptEntity = $this->autoMapping->mapToObject(DirectSupportScriptUpdateByAdminRequest::class,
            DirectSupportScriptEntity::class, $request, $directSupportScriptEntity);

        $this->entityManager->flush();

        return $directSupportScriptEntity;
    }

    public function filterDirectSupportScriptByAdmin(DirectSupportScriptFilterByAdminRequest $request): array
    {
        return $this->directSupportScriptEntityRepository->filterDirectSupportScriptByAdmin($request);
    }

    public function deleteDirectSupportScriptByAdmin(DirectSupportScriptDeleteByRequest $request): DirectSupportScriptEntity|int
    {
        $directSupportScriptEntity = $this->directSupportScriptEntityRepository->findOneBy(['id' => $request->getId()]);

        if (! $directSupportScriptEntity) {
            return DirectSupportScriptResultConstant::DIRECT_SUPPORT_SCRIPT_NOT_EXIST_CONST;
        }

        $this->entityManager->remove($directSupportScriptEntity);
        $this->entityManager->flush();

        return $directSupportScriptEntity;
    }
}
