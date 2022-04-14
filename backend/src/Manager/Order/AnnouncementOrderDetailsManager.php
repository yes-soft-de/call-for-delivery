<?php

namespace App\Manager\Order;

use App\AutoMapping;
use App\Entity\AnnouncementOrderDetailsEntity;
use App\Entity\OrderEntity;
use App\Manager\Announcement\AnnouncementManager;
use App\Request\Order\AnnouncementOrderCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AnnouncementOrderDetailsManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private AnnouncementManager $announcementManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, AnnouncementManager $announcementManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->announcementManager = $announcementManager;
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
}
