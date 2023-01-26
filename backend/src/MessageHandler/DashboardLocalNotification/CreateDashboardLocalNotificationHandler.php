<?php

namespace App\MessageHandler\DashboardLocalNotification;

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
        $this->initializeAndCreateDashboardLocalNotification($dashboardLocalNotificationCreateMessage);
    }

    public function initializeAndCreateDashboardLocalNotification(DashboardLocalNotificationCreateMessage $dashboardLocalNotificationCreateMessage)
    {
        $orderEntity = null;
        $userEntity = null;

        if ($dashboardLocalNotificationCreateMessage->getOrderId()) {
            $orderEntity = $this->orderEntityRepository->findOneBy(['id' => $dashboardLocalNotificationCreateMessage->getOrderId()]);
        }

        if ($dashboardLocalNotificationCreateMessage->getUser()) {
            $userEntity = $this->userEntityRepository->findOneBy(['id' => $dashboardLocalNotificationCreateMessage->getUser()]);
        }

        $this->dashboardLocalNotificationMySqlService->initializeAndCreateDashboardLocalNotification($dashboardLocalNotificationCreateMessage->getTitle(),
            $dashboardLocalNotificationCreateMessage->getMessage(), $dashboardLocalNotificationCreateMessage->getAppType(), $userEntity, $orderEntity);
    }
}
