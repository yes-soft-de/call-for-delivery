<?php


namespace App\Service\Notification;

use App\AutoMapping;
use App\Entity\NotificationFirebaseTokenEntity;
use App\Manager\Notification\NotificationTokensManager;
use App\Response\Notification\NotificationTokenResponse;
use App\Request\Notification\NotificationTokensCreateRequest;
use App\Constant\Notification\NotificationTokenConstant;

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

    public function getCaptainTokens(): ?array
    {
        return $this->notificationTokensManager->getUsersTokensByAppType(NotificationTokenConstant::APP_TYPE_CAPTAIN);
    }

    public function getTokenByUserId(int $userId): ?NotificationFirebaseTokenEntity
    {
        return $this->notificationTokensManager->getTokenByUserId($userId);
    }
}
