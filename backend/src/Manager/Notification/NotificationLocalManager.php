<?php

namespace App\Manager\Notification;

use App\AutoMapping;
use App\Entity\NotificationLocalEntity;
use App\Repository\NotificationLocalEntityRepository;
use App\Request\Notification\NotificationLocalCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use DateTime;

class NotificationLocalManager
{
    private $autoMapping;
    private $entityManager;
    private $notificationLocalRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, NotificationLocalEntityRepository $notificationLocalRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->notificationLocalRepository = $notificationLocalRepository;
    }
    
    /**
     * @param NotificationLocalCreateRequest $request
     */
    public function createNotificationLocal(NotificationLocalCreateRequest $request): ?NotificationLocalEntity
    {
        $entity = $this->autoMapping->map(NotificationLocalCreateRequest::class, NotificationLocalEntity::class, $request);
        $entity->setCreatedAt(new DateTime());

        $this->entityManager->persist($entity);
        $this->entityManager->flush();

        return $entity;
    }

     /**
     * @param integer $userId
     */
    public function getLocalNotifications($userId): ?array
    {
        return $this->notificationLocalRepository->getLocalNotifications($userId);
    }

     /**
     * @param integer $id
     */
    public function deleteLocalNotification($id): ?NotificationLocalEntity
    {
      $entity = $this->notificationLocalRepository->find($id);
      if($entity) {

         $this->entityManager->remove($entity);
         $this->entityManager->flush();
      }

      return $entity;
    }
}
