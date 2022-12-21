<?php

namespace App\Service\Notification;

use App\Constant\Notification\NotificationFirebaseConstant;
use App\Constant\Notification\NotificationTokenConstant;
use Kreait\Firebase\Contract\Messaging;
use Kreait\Firebase\Messaging\AndroidConfig;
use Kreait\Firebase\Messaging\ApnsConfig;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;

class CaptainOfferSubscriptionFirebaseNotificationService
{
    private Messaging $messaging;
    private NotificationTokensService $notificationTokensService;

    public function __construct(Messaging $messaging, NotificationTokensService $notificationTokensService)
    {
        $this->messaging = $messaging;
        $this->notificationTokensService = $notificationTokensService;
    }

    // Send firebase notification to each admin about the subscription of the captain offer
    public function sendFirebaseNotificationToAdmin(string $notificationDescription, string $storeName): array
    {
        $devicesToken = [];
        $sound = NotificationTokenConstant::SOUND;

        $adminsTokens =  $this->notificationTokensService->getUsersTokensByAppType(NotificationTokenConstant::APP_TYPE_ADMIN);

        if (count($adminsTokens) > 0) {
            foreach ($adminsTokens as $token) {
                $devicesToken[] = $token['token'];
            }

            $payload = [
                'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
                'navigate_route' => NotificationFirebaseConstant::URL_CHAT,
                'argument' => null,
            ];

            $config = AndroidConfig::fromArray([
                "notification" => [
                    "channel_id" => "C4d_Notifications_custom_sound_test"
                ]
            ]);

            $apnsConfig = ApnsConfig::fromArray([
                'headers' => [
                    'apns-priority' => '10',
                    'apns-push-type' => 'alert',
                ],
                'payload' => [
                    'aps' => [
                        'sound' => $sound
                    ]
                ]
            ]);

            $msgContent = $notificationDescription.$storeName;

            $message = CloudMessage::new()->withNotification(Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, $msgContent))
                ->withHighestPossiblePriority();

            $message = $message->withData($payload)->withAndroidConfig($config)->withApnsConfig($apnsConfig);

            $this->messaging->sendMulticast($message, $devicesToken);
        }

        return $devicesToken;
    }
}
