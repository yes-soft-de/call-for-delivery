<?php

namespace App\Manager\Admin\DirectSupportScript;

use App\AutoMapping;
use App\Entity\DirectSupportScriptEntity;
use App\Request\Admin\DirectSupportScript\DirectSupportScriptCreateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminDirectSupportScriptManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager
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
}
