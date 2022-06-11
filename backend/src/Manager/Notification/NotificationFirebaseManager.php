<?php


namespace App\Manager\Notification;

use App\Entity\NotificationFirebaseTokenEntity;
use App\Repository\NotificationFirebaseTokenEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class NotificationFirebaseManager
{
    private EntityManagerInterface $entityManager;
    private NotificationFirebaseTokenEntityRepository $notificationFirebaseTokenEntityRepository;

    public function __construct(EntityManagerInterface $entityManage, NotificationFirebaseTokenEntityRepository $notificationFirebaseTokenEntityRepository)
    {
        $this->entityManager = $entityManage;
        $this->notificationFirebaseTokenEntityRepository = $notificationFirebaseTokenEntityRepository;
    }

    public function deleteTokenByUserAndAppType(int $userId, int $appType): ?NotificationFirebaseTokenEntity
    {
        $tokenEntity = $this->notificationFirebaseTokenEntityRepository->getTokenByUserAndAppType($userId, $appType);

        if ($tokenEntity !== null) {
            $this->entityManager->remove($tokenEntity);
            $this->entityManager->flush();
        }

        return $tokenEntity;
    }
}
