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
        //$response = [];

        $result = $this->verificationEntityRepository->getByUserAndCode($request->getUser(), $request->getCode());
        //dd($result);
        if (! $result) {
            //$response['resultMessage'] = 'incorrectEnteredData';
            //return $response;
            return VerificationCodeResultConstant::INCORRECT_ENTERED_DATA_RESULT;

        } else {
            $interval = date_diff(new \DateTime('now') , $result['createdAt']);

            $different_days = $interval->format('%d');

            if ($different_days == 0) {
                $different_hours = $interval->format('%h');

                if ($different_hours <= 1) {
                    //$response['resultMessage'] = 'activated';
                    //return $response;
                    return VerificationCodeResultConstant::ACTIVATED_RESULT;
                }

            } else {
                //$response['resultMessage'] = 'codeDateIsNotValid';
                //return $response;
                return VerificationCodeResultConstant::NOT_VALID_CODE_DATE_RESULT;
            }
        }
    }

    public function generateVerificationCode(): string
    {
        $verificationCode = "";

        for ($i = 0; $i < 6; $i++) {
            $verificationCode .= random_int(0, 9);
        }

        return $verificationCode;
    }
}
