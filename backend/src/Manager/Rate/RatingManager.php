<?php

namespace App\Manager\Rate;

use App\AutoMapping;
use App\Entity\RateEntity;
use App\Repository\RateEntityRepository;
use App\Request\Rate\RatingCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\User\UserManager;
use App\Manager\Order\OrderManager;


class RatingManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private RateEntityRepository $ratingRepository;
    private UserManager $userManager;
    private OrderManager $orderManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, RateEntityRepository $ratingRepository, UserManager $userManager, OrderManager $orderManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->ratingRepository = $ratingRepository;
        $this->userManager = $userManager;
        $this->orderManager = $orderManager;
    }

    public function createRating(RatingCreateRequest $request): ?RateEntity
    {
        $request->setRater($this->userManager->getUser($request->getRater()));
        $request->setRated($this->userManager->getUserByCaptainProfileId($request->getRated()));

        $entity = $this->autoMapping->map(RatingCreateRequest::class, RateEntity::class, $request);
        $entity->setOrderId($this->orderManager->getOrderById($request->getOrderId()));
       
        $this->entityManager->persist($entity);

        $this->entityManager->flush();

        return $entity;
    }

    public function getAverageRating(int $rated): ?float
    {
       return $this->ratingRepository->getAverageRating($rated);
    }
}
