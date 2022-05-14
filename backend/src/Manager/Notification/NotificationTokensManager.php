<?php


namespace App\Manager\Notification;

use App\AutoMapping;
use App\Entity\NotificationFirebaseTokenEntity;
use App\Repository\NotificationFirebaseTokenEntityRepository;
use App\Request\Notification\NotificationTokensCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\User\UserManager;

class NotificationTokensManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private NotificationFirebaseTokenEntityRepository $notificationFirebaseTokenEntityRepository;
    private UserManager $userManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, NotificationFirebaseTokenEntityRepository $notificationFirebaseTokenEntityRepository, UserManager $userManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->notificationFirebaseTokenEntityRepository = $notificationFirebaseTokenEntityRepository;
        $this->userManager = $userManager;
    }

    public function createNotificationToken(NotificationTokensCreateRequest $request): ?NotificationFirebaseTokenEntity
    {
        $notificationFirebaseTokenEntity = $this->notificationFirebaseTokenEntityRepository->findOneBy(['user' => $request->getUserId()]);
      
        if ($notificationFirebaseTokenEntity) {
            $this->entityManager->remove($notificationFirebaseTokenEntity);
            $this->entityManager->flush();
        }

        $notificationFirebaseTokenEntity = $this->autoMapping->map(NotificationTokensCreateRequest::class, NotificationFirebaseTokenEntity::class, $request);

        $notificationFirebaseTokenEntity->setUser($this->userManager->getUser($request->getUserId()));
      
        $this->entityManager->persist($notificationFirebaseTokenEntity);
        $this->entityManager->flush();

        return $notificationFirebaseTokenEntity;
    }

    public function getUsersTokensByAppType(int $appType): ?array
    {
        return $this->notificationFirebaseTokenEntityRepository->getUsersTokensByAppType($appType);
    }

    public function getTokenByUserId(int $userId): ?NotificationFirebaseTokenEntity
    {
        return $this->notificationFirebaseTokenEntityRepository->findOneBy(["user" => $userId]);
    }

    public function getToken(int $userId): ?NotificationFirebaseTokenEntity
    {
        return $this->notificationFirebaseTokenEntityRepository->getToken($userId);
    }

    public function getTokensByUsersArray(array $usersEntities): array
    {
        return $this->notificationFirebaseTokenEntityRepository->getTokensByUsersArray($usersEntities);
    }
}
