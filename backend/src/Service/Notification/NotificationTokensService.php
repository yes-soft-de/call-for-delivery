<?php


namespace App\Service\Notification;

use App\AutoMapping;
use App\Entity\NotificationFirebaseTokenEntity;
use App\Manager\Notification\NotificationTokensManager;
use App\Response\Notification\NotificationTokenResponse;
use App\Request\Notification\NotificationTokensCreateRequest;

class NotificationTokensService
{
    private NotificationTokensManager $notificationTokensManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, NotificationTokensManager $notificationTokensManager)
    {
        $this->notificationTokensManager = $notificationTokensManager;
        $this->autoMapping = $autoMapping;
    }

    public function createNotificationToken(NotificationTokensCreateRequest $request): ?NotificationTokenResponse
    {
        $token = $this->notificationTokensManager->createNotificationToken($request);

        return $this->autoMapping->map(NotificationFirebaseTokenEntity ::class, NotificationTokenResponse::class, $token);
    }

    public function getUsersTokensByAppType(int $appType): ?array
    {
        return $this->notificationTokensManager->getUsersTokensByAppType($appType);
    }

    public function getTokenByUserId(int $userId): ?NotificationFirebaseTokenEntity
    {
        return $this->notificationTokensManager->getTokenByUserId($userId);
    }
}
