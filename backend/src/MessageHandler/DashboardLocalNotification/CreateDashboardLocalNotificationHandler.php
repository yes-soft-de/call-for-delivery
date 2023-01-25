<?php

namespace App\MessageHandler\DashboardLocalNotification;

use App\Entity\UserEntity;
use App\Message\DashboardLocalNotification\DashboardLocalNotificationCreateMessage;
use App\Repository\OrderEntityRepository;
use App\Repository\UserEntityRepository;
use App\Service\Notification\DashboardLocalNotification\DashboardLocalNotificationMySqlService;
use Symfony\Component\Messenger\Handler\MessageSubscriberInterface;

class CreateDashboardLocalNotificationHandler implements MessageSubscriberInterface
{
    public function __construct(
        private OrderEntityRepository $orderEntityRepository,
        private UserEntityRepository $userEntityRepository,
        private DashboardLocalNotificationMySqlService $dashboardLocalNotificationMySqlService
    )
    {
    }

    public static function getHandledMessages(): iterable
    {
        yield DashboardLocalNotificationCreateMessage::class => [
            'method' => 'handleCreateDashboardLocalNotification'
        ];
    }

    public function handleCreateDashboardLocalNotification(DashboardLocalNotificationCreateMessage $dashboardLocalNotificationCreateMessage)
    {
        $userEntity = $this->userEntityRepository->findOneBy(['id' => $dashboardLocalNotificationCreateMessage->getUser()]);

        if ($userEntity) {
            $this->initializeAndCreateDashboardLocalNotification($dashboardLocalNotificationCreateMessage, $userEntity);
        }
    }

    public function initializeAndCreateDashboardLocalNotification(DashboardLocalNotificationCreateMessage $dashboardLocalNotificationCreateMessage, UserEntity $userEntity)
    {
        if ($dashboardLocalNotificationCreateMessage->getOrderId()) {
            $orderEntity = $this->orderEntityRepository->findOneBy(['id' => $dashboardLocalNotificationCreateMessage->getOrderId()]);
        }

        $this->dashboardLocalNotificationMySqlService->initializeAndCreateDashboardLocalNotification($dashboardLocalNotificationCreateMessage->getTitle(),
            $dashboardLocalNotificationCreateMessage->getMessage(), $userEntity, $dashboardLocalNotificationCreateMessage->getAppType(), $orderEntity);
    }
}
