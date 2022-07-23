<?php

namespace App\Manager\Verification;

use App\AutoMapping;
use App\Constant\Verification\VerificationCodeResultConstant;
use App\Entity\VerificationEntity;
use App\Repository\VerificationEntityRepository;
use App\Request\Verification\VerificationCreateRequest;
use App\Request\Verification\VerifyCodeRequest;
use Doctrine\ORM\EntityManagerInterface;

class VerificationManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private VerificationEntityRepository $verificationEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, VerificationEntityRepository $verificationEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->verificationEntityRepository = $verificationEntityRepository;
    }

    public function createVerificationCode(VerificationCreateRequest $request): VerificationEntity
    {
        $request->setCode($this->generateVerificationCode());

        $verificationEntity = $this->autoMapping->map(VerificationCreateRequest::class, VerificationEntity::class, $request);

        $this->entityManager->persist($verificationEntity);
        $this->entityManager->flush();

        return $verificationEntity;
    }

    public function checkVerificationCode(VerifyCodeRequest $request): string
    {
        $result = $this->verificationEntityRepository->getByUserAndCode($request->getUser(), $request->getCode());

        if (! $result) {
            return VerificationCodeResultConstant::INCORRECT_ENTERED_DATA_RESULT;

        } else {
            $interval = date_diff(new \DateTime('now') , $result['createdAt']);

            $different_days = $interval->format('%d');

            if ($different_days == 0) {
                $different_hours = $interval->format('%h');

                if ($different_hours <= 1) {
                    return VerificationCodeResultConstant::ACTIVATED_RESULT;
                }

            } else {
                return VerificationCodeResultConstant::NOT_VALID_CODE_DATE_RESULT;
            }
        }
    }

    public function deleteAllVerificationCodesByUserId(string $userId): array
    {
        $verificationCodesResults = $this->verificationEntityRepository->getVerificationCodeByUserId($userId);

        if (! empty($verificationCodesResults)) {
            foreach ($verificationCodesResults as $verificationCodeResult) {
                $this->entityManager->remove($verificationCodeResult);
                $this->entityManager->flush();
            }
        }

        return $verificationCodesResults;
    }

    public function getAllVerificationCodeByUserId(string $userID): array
    {
        return $this->verificationEntityRepository->getVerificationCodeByUserId($userID);
    }

    public function generateVerificationCode(): string
    {
        $verificationCode = "";

        for ($i = 0; $i < 6; $i++) {
            $verificationCode .= random_int(0, 9);
        }

        return $verificationCode;
    }

    public function deleteAllVerificationCodesByIdOfUser(string $userId): array
    {
        $verificationCodesResults = $this->verificationEntityRepository->getVerificationCodeByIdOfUser($userId);

        if (! empty($verificationCodesResults)) {
            foreach ($verificationCodesResults as $verificationCodeResult) {
                $this->entityManager->remove($verificationCodeResult);
                $this->entityManager->flush();
            }
        }

        return $verificationCodesResults;
    }
}
