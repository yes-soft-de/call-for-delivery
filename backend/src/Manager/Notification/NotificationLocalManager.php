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
    public function __construct(private AutoMapping $autoMapping, private EntityManagerInterface $entityManager, private NotificationLocalEntityRepository $notificationLocalRepository)
    {
    }
    
    /**
     * @param NotificationLocalCreateRequest $request
     * @return NotificationLocalEntity|null
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
     * @return array|null
     */
    public function getLocalNotifications($userId): ?array
    {
        return $this->notificationLocalRepository->getLocalNotifications($userId);
    }

     /**
     * @param integer $id
     * @return NotificationLocalEntity|null
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
