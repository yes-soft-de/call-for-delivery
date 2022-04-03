<?php


namespace App\Service\Notification;

use App\Manager\Notification\NotificationFirebaseManager;
use App\Service\Notification\NotificationTokensService;
use Kreait\Firebase\Exception\FirebaseException;
use Kreait\Firebase\Exception\MessagingException;
use Kreait\Firebase\Contract\Messaging;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;
use App\Constant\Notification\NotificationFirebaseConstant;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Order\OrderStateConstant;

class NotificationFirebaseService
{
    private Messaging $messaging;
    private NotificationFirebaseManager $notificationFirebaseManager;
    private NotificationTokensService $notificationTokensService;

    public function __construct(Messaging $messaging, NotificationFirebaseManager $notificationFirebaseManager, NotificationTokensService $notificationTokensService)
    {
        $this->messaging = $messaging;
        $this->notificationFirebaseManager = $notificationFirebaseManager;
        $this->notificationTokensService = $notificationTokensService;
    }

    public function notificationToCaptains(int $orderId)
    {
        $getTokens = $this->notificationTokensService->getCaptainTokens();

        $tokens = [];

        foreach ($getTokens as $token) {
            $tokens[] = $token['token'];
        }

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => NotificationFirebaseConstant::URL,
            'argument' => $orderId,
        ];

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, NotificationFirebaseConstant::MESSAGE_CAPTAIN_NEW_ORDER))
            ->withDefaultSounds()
            ->withHighestPossiblePriority()->withData($payload);
        $this->messaging->sendMulticast($message, $tokens);
    }

    public function notificationOrderStateForUser(int $userId, int $orderId, string $orderState, string $userType)
    { 
        if($userType === NotificationConstant::STORE) {
           $text = $this->getOrderStateForStore($orderState);
        }

        if($userType === NotificationConstant::CAPTAIN) {
           $text = $this->getOrderStateForCaptain($orderState);
        }

        $deviceToken = $this->notificationTokensService->getTokenByUserId($userId);
        $token[] = $deviceToken->getToken();

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => NotificationFirebaseConstant::URL,
            'argument' => $orderId,
        ];

        $msg = $text." ".$orderId;

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, $msg))
            ->withDefaultSounds()
            ->withHighestPossiblePriority()->withData($payload);

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
    
    // /**
    //  * @throws MessagingException
    //  * @throws FirebaseException
    //  */
    // public function notificationOrderUpdateForUser($userID, $orderNumber, $msg)
    // {
    //     $token = $this->getNotificationTokenByUserID($userID);

    //     $devicesToken[] = $token;

    //     $payload = [
    //         'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
    //         'navigate_route' => self::URL,
    //         'argument' => $orderNumber,
    //     ];

    //     $msg = $msg." ".$orderNumber;

    //     $message = CloudMessage::new()
    //         ->withNotification(
    //             Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name, $msg))
    //         ->withDefaultSounds()
    //         ->withHighestPossiblePriority()->withData($payload);

    //     $this->messaging->sendMulticast($message, $devicesToken);
    // }

    // public function getStoreTokens($storeIDs)
    // {
    //     return $this->notificationManager->getStoreTokens($storeIDs);
    // }

    // /**
    //  * @throws MessagingException
    //  * @throws FirebaseException
    //  */
    // public function notificationOrderUpdateForStores($storeIds, $orderNumber, $msg)
    // {
    //     $storeIDs = array_unique($storeIds);

    //     $tokens = [];

    //     $getTokens = $this->getStoreTokens($storeIDs);

    //     foreach ($getTokens as $token) {
    //         $tokens[] = $token['token'];
    //     }
    //     $payload = [
    //         'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
    //         'navigate_route' => self::URL,
    //         'argument' => $orderNumber,
    //     ];

    //     $msg = $msg." ".$orderNumber;

    //     $message = CloudMessage::new()
    //         ->withNotification(
    //             Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name, $msg))
    //         ->withDefaultSounds()
    //         ->withHighestPossiblePriority()->withData($payload);

    //     $this->messaging->sendMulticast($message, $tokens);
    // }

    // public function notificationNewChatAnonymous(NotificationNewChatAnonymousRequest $request)
    // {
    //     $payload = [
    //         'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
    //         'navigate_route' => self::URLCHAT,
    //         'argument' => null,
    //     ];

    //     $devicesToken = [];
    //     $userToken = $this->notificationManager->getAnonymousToken($request->getAnonymousChatID());
    //     if( $userToken) {
    //         $devicesToken[] = $userToken['token'];
    //     }

    //     $message = CloudMessage::new()
    //             ->withNotification(Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name, MessageConstant::$MESSAGE_NEW_CHAT))->withDefaultSounds()
    //             ->withHighestPossiblePriority();

    //     $message = $message->withData($payload);

    //     try {
    //         $this->messaging->sendMulticast($message, $devicesToken);
    //     }
    //     catch (\Exception $e) {
    //         error_log($e);
    //     }

    //     return $devicesToken;
    // }

    // public function notificationNewChatToAdmins($chatRoomID = null, $userID = null){

    //     if($userID) {
    //         $client = $this->notificationManager->getClientNameByUserID($userID);

    //         if($client){
    //             $clientName = $client['clientName'];
    //         }
    //     }
    //     else {
    //         $anonymouseName = $this->notificationManager->getAnonymouseNameByChaRoomID($chatRoomID);

    //         if($anonymouseName) {
    //             $clientName = $anonymouseName['name'];
    //         }

    //         else {
    //             $clientName = "anonymouse";
    //         }
    //     }

    //     $msg =  MessageConstant::$MESSAGE_NEW_CHAT_TO_ADMIN;
    //     if(isset($clientName)){
    //         $msg =  MessageConstant::$MESSAGE_NEW_CHAT_TO_ADMIN.$clientName;
    //     }

    //     $getTokens = $this->getAdminsTokens();

    //     $devicesToken = [];

    //     foreach ($getTokens as $token) {
    //         $devicesToken[] = $token['token'];
    //     }

    //     $payload = [
    //         'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
    //         'navigate_route' => self::URLCHAT,
    //         'argument' => "",
    //     ];

    //     $message = CloudMessage::new()
    //             ->withNotification(Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name, $msg))->withDefaultSounds()
    //             ->withHighestPossiblePriority();

    //     $message = $message->withData($payload);

    //     try{
    //         $this->messaging->sendMulticast($message, $devicesToken);
    //     }
    //     catch (\Exception $e){
    //         error_log($e);
    //     }

    //     return $devicesToken;
    // }

    // public function getNotificationTokenByUserID($userID)
    // {
    //     return $this->notificationManager->getNotificationTokenByUserID($userID);
    // }

    // public function notificationNewChatByUserID(NotificationTokenByUserIDRequest $request)
    // {
    //     if(!$request->getOtherUserID()){
    //         return $this->notificationNewChatToAdmins($request->getChatRoomID(), $request->getUserID());
    //     }

    //     $payload = [
    //         'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
    //         'navigate_route' => self::URLCHAT,
    //         'argument' => null,
    //     ];

    //     $devicesToken = [];

    //     $userToken = $this->notificationManager->getNotificationTokenByUserID($request->getOtherUserID());

    //     $devicesToken[] = $userToken;

    //     $message = CloudMessage::new()
    //     ->withNotification(Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name, MessageConstant::$MESSAGE_NEW_CHAT))->withDefaultSounds()
    //     ->withHighestPossiblePriority();

    //     $message = $message->withData($payload);

    //     $this->messaging->sendMulticast($message, $devicesToken);

    //     return $devicesToken;
    // }
}
