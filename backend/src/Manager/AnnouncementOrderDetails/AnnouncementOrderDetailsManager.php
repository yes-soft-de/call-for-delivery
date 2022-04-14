<?php

namespace App\Manager\AnnouncementOrderDetails;

use App\AutoMapping;
use App\Entity\AnnouncementOrderDetailsEntity;
use App\Entity\OrderEntity;
use App\Manager\Announcement\AnnouncementManager;
use App\Repository\AnnouncementOrderDetailsEntityRepository;
use App\Request\AnnouncementOrderDetails\AnnouncementOrderPriceOfferValueUpdateRequest;
use App\Request\Order\AnnouncementOrderCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AnnouncementOrderDetailsManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private AnnouncementManager $announcementManager;
    private AnnouncementOrderDetailsEntityRepository $announcementOrderDetailsEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, AnnouncementManager $announcementManager, AnnouncementOrderDetailsEntityRepository $announcementOrderDetailsEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->announcementManager = $announcementManager;
        $this->announcementOrderDetailsEntityRepository = $announcementOrderDetailsEntityRepository;
    }

    public function createAnnouncementOrderDetails(AnnouncementOrderCreateRequest $request, OrderEntity $orderEntity)
    {
        $request->setAnnouncement($this->announcementManager->getAnnouncementEntityById($request->getAnnouncement()));

        $announcementOrderDetailsEntity = $this->autoMapping->map(AnnouncementOrderCreateRequest::class, AnnouncementOrderDetailsEntity::class, $request);

        $announcementOrderDetailsEntity->setOrderId($orderEntity);

        $this->entityManager->persist($announcementOrderDetailsEntity);
        $this->entityManager->flush();

        return $announcementOrderDetailsEntity;
    }

    public function updateAnnouncementOrderDetailsPriceOfferValueBySupplier(AnnouncementOrderPriceOfferValueUpdateRequest $request): ?AnnouncementOrderDetailsEntity
    {
        $announcementOrderDetailsEntity = $this->announcementOrderDetailsEntityRepository->find($request->getId());

        if (! $announcementOrderDetailsEntity) {
            return $announcementOrderDetailsEntity;
        }

        $announcementOrderDetailsEntity = $this->autoMapping->mapToObject(AnnouncementOrderPriceOfferValueUpdateRequest::class, AnnouncementOrderDetailsEntity::class,
            $request, $announcementOrderDetailsEntity);

        $this->entityManager->flush();

        return $announcementOrderDetailsEntity;
    }
}
