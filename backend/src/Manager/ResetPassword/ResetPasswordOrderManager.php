<?php

namespace App\Manager\ResetPassword;

use App\AutoMapping;
use App\Entity\ResetPasswordOrderEntity;
use App\Entity\UserEntity;
use App\Repository\ResetPasswordOrderEntityRepository;
use App\Request\ResetPassword\ResetPasswordOrderCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class ResetPasswordOrderManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private ResetPasswordOrderEntityRepository $resetPasswordOrderEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ResetPasswordOrderEntityRepository $resetPasswordOrderEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->resetPasswordOrderEntityRepository = $resetPasswordOrderEntityRepository;
    }

    public function createResetPasswordOrder(ResetPasswordOrderCreateRequest $request, UserEntity $userEntity): ResetPasswordOrderEntity
    {
        $request->setCode($this->generateCode());

        $resetPasswordOrderEntity = $this->autoMapping->map(ResetPasswordOrderCreateRequest::class, ResetPasswordOrderEntity::class, $request);

        $resetPasswordOrderEntity->setUser($userEntity);

        $this->entityManager->persist($resetPasswordOrderEntity);
        $this->entityManager->flush();

        return $resetPasswordOrderEntity;
    }

    public function getResetPasswordOrderByCode($code): ?array
    {
        return $this->resetPasswordOrderEntityRepository->getResetPasswordOrderByCode($code);
    }

    public function getResetPasswordOrderByActiveCode(string $code): ?ResetPasswordOrderEntity
    {
        return $this->resetPasswordOrderEntityRepository->getResetPasswordOrderByActiveCode($code);
    }

    public function generateCode(): string
    {
        do {
            // keep generating code while it is exist
            $found = false;
            $code = "";
            $result = "";

            for ($i = 0; $i < 6; $i++) {
                $code .= random_int(0, 9);
            }

            // Check if it is exist
            $result = $this->getResetPasswordOrderByCode($code);

            if ($result) {
                $found = true;
            }

        }
        while($found);

        return $code;
    }
}
