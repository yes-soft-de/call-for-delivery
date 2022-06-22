<?php


namespace App\Service\Notification;

use App\AutoMapping;
use App\Entity\NotificationFirebaseTokenEntity;
use App\Manager\Notification\NotificationFirebaseManager;
use App\Request\Notification\NotificationFirebaseBySuperAdminCreateRequest;
use App\Response\Notification\NotificationFirebaseTokenDeleteResponse;
use App\Service\User\UserService;
use Kreait\Firebase\Contract\Messaging;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;
use App\Constant\Notification\NotificationFirebaseConstant;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Order\OrderStateConstant;
use App\Request\Notification\NotificationFirebaseByUserIdRequest;
use App\Request\Notification\NotificationFirebaseFromAdminRequest;
use App\Constant\Notification\NotificationTokenConstant;
use Kreait\Firebase\Messaging\AndroidConfig;
use Kreait\Firebase\Messaging\ApnsConfig;
use App\Service\ChatRoom\OrderChatRoomService;
use App\Service\Captain\CaptainService;
use App\Service\StoreOwner\StoreOwnerProfileService;

class NotificationFirebaseService
{
    private AutoMapping $autoMapping;
    private Messaging $messaging;
    private NotificationFirebaseManager $notificationFirebaseManager;
    private NotificationTokensService $notificationTokensService;
    private UserService $userService;
    private OrderChatRoomService $orderChatRoomService;
    private CaptainService $captainService;
    private StoreOwnerProfileService $storeOwnerProfileService;

    public function __construct(AutoMapping $autoMapping, Messaging $messaging, NotificationFirebaseManager $notificationFirebaseManager, NotificationTokensService $notificationTokensService, UserService $userService, OrderChatRoomService $orderChatRoomService, CaptainService $captainService, StoreOwnerProfileService $storeOwnerProfileService)
    {
        $this->autoMapping = $autoMapping;
        $this->messaging = $messaging;
        $this->notificationFirebaseManager = $notificationFirebaseManager;
        $this->notificationTokensService = $notificationTokensService;
        $this->userService = $userService;
        $this->orderChatRoomService = $orderChatRoomService;
        $this->captainService = $captainService;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
    }

    public function notificationToCaptains(int $orderId)
    {
        $getTokens = $this->notificationTokensService->getCaptainsOnlineTokens();
        if (! empty($getTokens)) {

            $payload = [
                'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
                'navigate_route' => NotificationFirebaseConstant::URL,
                'argument' => $orderId,
            ];

            $config = AndroidConfig::fromArray([
                "notification" => [
                    "channel_id" => "C4d_Notifications_custom_sound_test"
                ]
            ]);

            foreach ($getTokens as $token) {
                if ($token['token'] !== null) {
                    $deviceToken = [];

                    $deviceToken[] = $token['token'];

                    $sound = $token['sound'];

                    if (! $sound) {
                        $sound = NotificationTokenConstant::SOUND;
                    }

                    $apnsConfig = ApnsConfig::fromArray([
                        'headers' => [
                            'apns-priority' => '10',
                            'apns-push-type' => 'alert'
                        ],
                        'payload' => [
                            'aps' => [
                                'sound' => $sound
                            ]
                        ]
                    ]);

                    $message = CloudMessage::new()->withNotification(Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME,
                        NotificationFirebaseConstant::MESSAGE_CAPTAIN_NEW_ORDER))
                        ->withHighestPossiblePriority()
                        ->withData($payload)
                        ->withAndroidConfig($config)
                        ->withApnsConfig($apnsConfig);

                    $this->messaging->sendMulticast($message, $deviceToken);
                }
            }
        }
    }

    public function notificationOrderStateForUser(int $userId, int $orderId, string $orderState, string $userType)
    {
        if($userType === NotificationConstant::STORE) {
            $text = $this->getOrderStateForStore($orderState);
        }

        if($userType === NotificationConstant::CAPTAIN) {
            $text = $this->getOrderStateForCaptain($orderState);
        }

        $token = [];

        $deviceToken = $this->notificationTokensService->getTokenByUserId($userId);
        if(! $deviceToken) {
            return NotificationTokenConstant::TOKEN_NOT_FOUND;
        }

        $token[] = $deviceToken->getToken();

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => NotificationFirebaseConstant::URL,
            'argument' => $orderId,
        ];

        $config = AndroidConfig::fromArray([
            "notification" => [
                "channel_id" => "C4d_Notifications_custom_sound_test"
            ]
        ]);

        $msg = $text." ".$orderId;

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, $msg))
            ->withHighestPossiblePriority()->withData($payload)->withAndroidConfig($config);

        $this->messaging->sendMulticast($message, $token);
    }

    //TODO Move to a separate service
    public function getOrderStateForStore($state): string
    {
        if ($state === OrderStateConstant::ORDER_STATE_PENDING){
            $state = NotificationFirebaseConstant::CREATE_ORDER_SUCCESS;
        }
        if ($state === OrderStateConstant::ORDER_STATE_ON_WAY){
            $state = NotificationFirebaseConstant::STATE_ON_WAY_PICK_ORDER;
        }
        if ($state === OrderStateConstant::ORDER_STATE_IN_STORE){
            $state =  NotificationFirebaseConstant::STATE_IN_STORE;
        }
        if ($state === OrderStateConstant::ORDER_STATE_PICKED){
            $state =  NotificationFirebaseConstant::STATE_PICKED;
        }
        if ($state === OrderStateConstant::ORDER_STATE_ONGOING){
            $state =  NotificationFirebaseConstant::STATE_ONGOING;
        }
        if ($state === OrderStateConstant::ORDER_STATE_DELIVERED){
            $state =  NotificationFirebaseConstant::STATE_DELIVERED;
        }

        return $state;
    }

    //TODO Move to a separate service
    public function getOrderStateForCaptain($state): string
    {
        if ($state === OrderStateConstant::ORDER_STATE_ON_WAY){
            $state = NotificationFirebaseConstant::STATE_ON_WAY_PICK_ORDER_CAPTAIN;
        }
        if ($state === OrderStateConstant::ORDER_STATE_IN_STORE){
            $state =  NotificationFirebaseConstant::STATE_IN_STORE_CAPTAIN;
        }
        if ($state === OrderStateConstant::ORDER_STATE_PICKED){
            $state =  NotificationFirebaseConstant::STATE_PICKED_CAPTAIN;
        }
        if ($state === OrderStateConstant::ORDER_STATE_ONGOING){
            $state =  NotificationFirebaseConstant::STATE_ONGOING_CAPTAIN;
        }
        if ($state === OrderStateConstant::ORDER_STATE_DELIVERED){
            $state =  NotificationFirebaseConstant::STATE_DELIVERED_CAPTAIN;
        }

        return $state;
    }

    public function notificationNewChatByUserID(NotificationFirebaseByUserIdRequest $request, $userType, int $sendByUser)
    {
        $devicesToken = [];
        $sound = NotificationTokenConstant::SOUND;

        $orderId = $this->orderChatRoomService->getOrderIdByRoomId($request->getRoomId());

        if(! $request->getOtherUserID()){
            $this->notificationNewChatToAdmin($request, $sendByUser);
        }

        if($request->getOtherUserID()){

            if($userType ===  NotificationTokenConstant::APP_TYPE_CAPTAIN) {
                $user = $this->userService->getUserByCaptainProfileId($request->getOtherUserID());
            }

            if($userType ===  NotificationTokenConstant::APP_TYPE_STORE) {
                $user = $this->userService->getUserByStoreProfileId($request->getOtherUserID());
            }

            if ($userType === NotificationTokenConstant::APP_TYPE_SUPPLIER) {
                $user = $this->userService->getUserBySupplierProfileId($request->getOtherUserID());
            }

            $token = $this->notificationTokensService->getTokenByUserId($user->getId());

            $devicesToken[] = $token->getToken();

            $sound = $token->getSound();
            if(! $sound) {
                $sound = NotificationTokenConstant::SOUND;
            }
        }

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => NotificationFirebaseConstant::URL_CHAT,
            'argument' => null,
            'chatNotification' => json_encode([
                'roomId' => $request->getRoomId(),
                'userId' => (string) $request->getUserID()
            ])
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
                'aps' =>[
                    'sound' => $sound
                ]
            ]
        ]);

        if ($orderId !== null || (! empty($orderId))) {
            $msgContent = NotificationFirebaseConstant::MESSAGE_NEW_CHAT." -".NotificationFirebaseConstant::ORDER_ID." ".$orderId;

        } else {
            $msgContent = NotificationFirebaseConstant::MESSAGE_NEW_CHAT;
        }

        $message = CloudMessage::new()->withNotification(Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, $msgContent))
            ->withHighestPossiblePriority();

        $message = $message->withData($payload)->withAndroidConfig($config)->withApnsConfig($apnsConfig);

        $this->messaging->sendMulticast($message, $devicesToken);

        return $devicesToken;
    }

    public function notificationNewChatFromAdmin(NotificationFirebaseFromAdminRequest $request)
    {
        $devicesToken = [];
        $sound = NotificationTokenConstant::SOUND;

        $token = $this->notificationTokensService->getTokenByUserId($request->getOtherUserID());

        $devicesToken[] = $token->getToken();

        $sound = $token->getSound();
        if(! $sound) {
            $sound = NotificationTokenConstant::SOUND;
        }

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => NotificationFirebaseConstant::URL_CHAT,
            'argument' => null,
            'chatNotification' => json_encode([
                'roomId' => $request->getRoomId(),
                'userId' => (string) $request->getOtherUserID()
            ])
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
                'aps' =>[
                    'sound' => $sound
                ]
            ]
        ]);

        $message = CloudMessage::new()
            ->withNotification(Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, NotificationFirebaseConstant::MESSAGE_NEW_CHAT))
            ->withHighestPossiblePriority();

        $message = $message->withData($payload)->withAndroidConfig($config)->withApnsConfig($apnsConfig);

        $this->messaging->sendMulticast($message, $devicesToken);

        return $devicesToken;
    }

    /**
     * This function for sending customizable firebase notification via System Control App
     */
    public function sendNotificationBySuperAdmin(NotificationFirebaseBySuperAdminCreateRequest $request): array
    {
        $devicesToken = [];

        if (! $request->getOtherUserId() && $request->getAppType() !== null) {
            // send notification for all captains or all store owners
            $usersTokens = $this->notificationTokensService->getUsersTokensByAppType($request->getAppType());

            if ($usersTokens) {
                foreach ($usersTokens as $userToken) {
                    $devicesToken[] = $userToken['token'];
                }

                $payload = [
                    'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
                    'navigate_route' => NotificationFirebaseConstant::URL,
                    'argument' => null,
                ];

                $config = AndroidConfig::fromArray([
                    "notification" => [
                        "channel_id" => "C4d_Notifications_custom_sound_test"
                    ]
                ]);

                $message = CloudMessage::new()->withNotification(Notification::create($request->getTitle(), $request->getMessageBody()))
                    ->withHighestPossiblePriority()
                    ->withData($payload)
                    ->withAndroidConfig($config);

                $this->messaging->sendMulticast($message, $devicesToken);
            }

        } elseif ($request->getOtherUserId() !== null && $request->getAppType() === null) {
            // send notification for all captains or all store owners
            $token = $this->notificationTokensService->getTokenByUserId($request->getOtherUserID());

            if ($token != null) {
                $devicesToken[] = $token->getToken();

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

                $message = CloudMessage::new()->withNotification(Notification::create($request->getTitle(), $request->getMessageBody()))
                    ->withHighestPossiblePriority();

                $message = $message->withData($payload)->withAndroidConfig($config);

                $this->messaging->sendMulticast($message, $devicesToken);
            }
        }

        return $devicesToken;
    }

    /**
     * send firebase notification to supplier (who belong to the same category that the order relates to), when
     * new bid order is created.
     */
    public function sendNotificationToSpecificSuppliers(int $orderId, int $supplierCategoryId)
    {
        // First, get all suppliers who belong to the same category
        $users = $this->userService->getSupplierUsersEntitiesBySupplierCategoryId($supplierCategoryId);

        // Then, call creating firebase notification function
        $tokens = $this->notificationTokensService->getTokensByUsersArray($users);

        if(! $tokens) {
            return NotificationTokenConstant::TOKEN_NOT_FOUND;
        }

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => NotificationFirebaseConstant::URL,
            'argument' => $orderId,
        ];

        $config = AndroidConfig::fromArray([
            "notification" => [
                "channel_id" => "C4d_Notifications_custom_sound_test"
            ]
        ]);

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, NotificationFirebaseConstant::NEW_BID_ORDER_CREATED_SUCCESSFULLY))
            ->withHighestPossiblePriority()->withData($payload)->withAndroidConfig($config);
        $this->messaging->sendMulticast($message, $tokens);
    }

    public function sendNotificationToStoreOwnerOfNewPriceOffer(int $userId, int $orderId)
    {
        $token = [];

        $deviceToken = $this->notificationTokensService->getTokenByUserId($userId);

        if (! $deviceToken) {
            return NotificationTokenConstant::TOKEN_NOT_FOUND;
        }

        $token[] = $deviceToken->getToken();

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => NotificationFirebaseConstant::URL,
            'argument' => $orderId,
        ];

        $config = AndroidConfig::fromArray([
            "notification" => [
                "channel_id" => "C4d_Notifications_custom_sound_test"
            ]
        ]);

        $msg = NotificationFirebaseConstant::NEW_PRICE_OFFER_ADDED." ".$orderId;

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, $msg))
            ->withHighestPossiblePriority()->withData($payload)->withAndroidConfig($config);

        $this->messaging->sendMulticast($message, $token);
    }

    public function sendNotificationOfPriceOfferStatusUpdateToSupplier(int $userId, int $priceOfferId, string $text)
    {
        $token = [];

        $deviceToken = $this->notificationTokensService->getTokenByUserId($userId);

        if (! $deviceToken) {
            return NotificationTokenConstant::TOKEN_NOT_FOUND;
        }

        $token[] = $deviceToken->getToken();

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => NotificationFirebaseConstant::URL,
            'argument' => $priceOfferId,
        ];

        $config = AndroidConfig::fromArray([
            "notification" => [
                "channel_id" => "C4d_Notifications_custom_sound_test"
            ]
        ]);

        $msg = $text." ".$priceOfferId;

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, $msg))
            ->withHighestPossiblePriority()->withData($payload)->withAndroidConfig($config);

        $this->messaging->sendMulticast($message, $token);
    }

    public function notificationSubOrderForUser(int $userId, int $orderId, string $text)
    {
        $token = [];

        $deviceToken = $this->notificationTokensService->getTokenByUserId($userId);
        if(! $deviceToken) {
            return NotificationTokenConstant::TOKEN_NOT_FOUND;
        }

        $token[] = $deviceToken->getToken();

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => NotificationFirebaseConstant::URL,
            'argument' => $orderId,
        ];

        $config = AndroidConfig::fromArray([
            "notification" => [
                "channel_id" => "C4d_Notifications_custom_sound_test"
            ]
        ]);

        $msg = $text." ".$orderId;

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, $msg))
            ->withHighestPossiblePriority()->withData($payload)->withAndroidConfig($config);

        $this->messaging->sendMulticast($message, $token);
    }

    public function deleteTokenByUserAndAppType(int $userId, int $appType): ?NotificationFirebaseTokenEntity
    {
        return $this->notificationFirebaseManager->deleteTokenByUserAndAppType($userId, $appType);
    }

    public function deleteTokenByUserId(int $userId): ?NotificationFirebaseTokenDeleteResponse
    {
        $tokenResult = $this->notificationFirebaseManager->deleteTokenByUserId($userId);

        return $this->autoMapping->map(NotificationFirebaseTokenEntity::class, NotificationFirebaseTokenDeleteResponse::class, $tokenResult);
    }

    public function notificationNewChatToAdmin(NotificationFirebaseByUserIdRequest $request, int $sendByUser)
    {
        $devicesToken = [];
        $sound = NotificationTokenConstant::SOUND;
        $userName ="";

        if($sendByUser === NotificationTokenConstant::APP_TYPE_STORE) {
            $user = $this->storeOwnerProfileService->getStoreByUserId($request->getUserID());
            $userName = $user->getStoreOwnerName();
        }

        if ($sendByUser === NotificationTokenConstant::APP_TYPE_CAPTAIN) {
            $user = $this->captainService->getCaptainProfileByUserId($request->getUserID());
            $userName = $user->getCaptainName();
        }

        $adminsTokens =  $this->notificationTokensService->getUsersTokensByAppType(NotificationTokenConstant::APP_TYPE_ADMIN);

        foreach ($adminsTokens as $token) {
            $devicesToken[] = $token['token'];
        }

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => NotificationFirebaseConstant::URL_CHAT,
            'argument' => null,
            'chatNotification' => json_encode([
                'roomId' => $request->getRoomId(),
                'userId' => (string) $request->getUserID()
            ])
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
                'aps' =>[
                    'sound' => $sound
                ]
            ]
        ]);

        $msgContent = NotificationFirebaseConstant::MESSAGE_NEW_CHAT.NotificationFirebaseConstant::FROM." ".$userName;

        $message = CloudMessage::new()->withNotification(Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, $msgContent))
            ->withHighestPossiblePriority();

        $message = $message->withData($payload)->withAndroidConfig($config)->withApnsConfig($apnsConfig);

        $this->messaging->sendMulticast($message, $devicesToken);

        return $devicesToken;
    }

    public function notificationToUser(int $userId, int $orderId, string $text)
    {
        $token = [];
        $sound = NotificationTokenConstant::SOUND;

        $deviceToken = $this->notificationTokensService->getTokenByUserId($userId);
        if(! $deviceToken) {
            return NotificationTokenConstant::TOKEN_NOT_FOUND;
        }

        $token[] = $deviceToken->getToken();

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => NotificationFirebaseConstant::URL,
            'argument' => $orderId,
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
                'aps' =>[
                    'sound' => $sound
                ]
            ]
        ]);

        $msg = $text." ".$orderId;

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, $msg))
            ->withHighestPossiblePriority()->withData($payload)->withAndroidConfig($config)->withApnsConfig($apnsConfig);

        $this->messaging->sendMulticast($message, $token);
    }

    public function orderVisibilityNotificationToUser(int $userId, int $orderId, string $text)
    {
        $sound = NotificationTokenConstant::SOUND;

        $deviceToken = $this->notificationTokensService->getTokenByUserId($userId);

        if(! $deviceToken) {
            return NotificationTokenConstant::TOKEN_NOT_FOUND;
        }

        $token = [];
        $token[] = $deviceToken->getToken();

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => NotificationFirebaseConstant::URL,
            'argument' => $orderId,
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
                'aps' =>[
                    'sound' => $sound
                ]
            ]
        ]);

        $msg = $text." ".$orderId;

        $message = CloudMessage::new()->withNotification(Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, $msg))
            ->withHighestPossiblePriority()->withData($payload)->withAndroidConfig($config)->withApnsConfig($apnsConfig);

        $this->messaging->sendMulticast($message, $token);
    }
}