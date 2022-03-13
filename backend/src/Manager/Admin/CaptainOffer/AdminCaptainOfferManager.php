<?php

namespace App\Manager\Admin\CaptainOffer;

use App\AutoMapping;
use App\Constant\CaptainOffer\CaptainOfferConstant;
use App\Entity\CaptainOfferEntity;
use App\Repository\CaptainOfferEntityRepository;
use App\Request\Admin\CaptainOffer\CaptainOfferCreateRequest;
use App\Request\Admin\CaptainOffer\CaptainOfferUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminCaptainOfferManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private CaptainOfferEntityRepository $captainOfferEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CaptainOfferEntityRepository $captainOfferEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainOfferEntityRepository = $captainOfferEntityRepository;
    }

    public function createCaptainOfferByAdmin(CaptainOfferCreateRequest $request): CaptainOfferEntity
    {
        $captainOfferEntity = $this->autoMapping->map(CaptainOfferCreateRequest::class, CaptainOfferEntity::class, $request);

        $this->entityManager->persist($captainOfferEntity);
        $this->entityManager->flush();

        return $captainOfferEntity;
    }

    public function updateCaptainOfferByAdmin(CaptainOfferUpdateRequest $request): string|CaptainOfferEntity
    {
        $entity = $this->captainOfferEntityRepository->find($request->getId());

        if (! $entity) {
         
           return CaptainOfferConstant::CAPTAIN_OFFER_NOT_EXIST;
        }
         
        $entity = $this->autoMapping->mapToObject(CaptainOfferUpdateRequest::class, CaptainOfferEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    }

    public function getCaptainOffersByAdmin(): ?array
    {
        return $this->captainOfferEntityRepository->findAll();
    }

    public function getCaptainOfferByAdmin($id): ?CaptainOfferEntity
    {
        return $this->captainOfferEntityRepository->find($id);
    }
}
