<?php


namespace App\Service\Notification;

use App\AutoMapping;
use App\Entity\NotificationFirebaseTokenEntity;
use App\Manager\Notification\NotificationFirebaseManager;
use App\Response\Notification\NotificationFirebaseTokenResponse;
use Kreait\Firebase\Exception\FirebaseException;
use Kreait\Firebase\Exception\MessagingException;
use Kreait\Firebase\Contract\Messaging;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;
use App\Constant\MessageConstant;
use App\Constant\DeliveryCompanyNameConstant;
use Kreait\Firebase\Messaging\ApnsConfig;
use App\Request\Notification\NotificationFirebaseTokenCreateRequest;
use Kreait\Firebase\Messaging\AndroidConfig;

class NotificationFirebaseService
{
    private $messaging;
    private $notificationFirebaseManager;
    private $autoMapping;

    const URL = '/order_details';
    const URLCHAT = '/chat';

    public function __construct(AutoMapping $autoMapping
    , Messaging $messaging
    , NotificationFirebaseManager $notificationFirebaseManager)
    {
        $this->messaging = $messaging;
        $this->notificationFirebaseManager = $notificationFirebaseManager;
        $this->autoMapping = $autoMapping;
    }

    public function createNotificationFirebaseToken(NotificationFirebaseTokenCreateRequest $request): ?NotificationFirebaseTokenResponse
    {
        $token = $this->notificationFirebaseManager->createNotificationFirebaseToken($request);

        return $this->autoMapping->map(NotificationFirebaseTokenEntity ::class, NotificationFirebaseTokenResponse::class, $token);
    }

    public function notificationToCaptains()
    {

        $config = AndroidConfig::fromArray([
            'ttl' => '3600s',
            'priority' => 'normal',
            'notification' => [
                'title' => '$GOOG up 1.43% on the day',
                'body' => '$GOOG gained 11.80 points to close at 835.67, up 1.43% on the day.',
                'icon' => 'stock_ticker_update',
                'color' => '#f45342',
                'sound' => 'default',
                'restricted_package_name' => 'de.yessoft.c4d_captain'
            ],
        ]);
       
        $message = CloudMessage::new()
        ->withNotification(
            Notification::create("C4D", "TEST"))
        ->withDefaultSounds()
        ->withHighestPossiblePriority();

        $message = $message->withAndroidConfig($config);

        return $config ;
    }


    // public function getCaptainTokens()
    // {
    //     return $this->notificationManager->getCaptainTokens();
    // }

    // public function getAdminsTokens()
    // {
    //     return $this->notificationManager->getAdminsTokens();
    // }

    // public function notificationToCaptains($orderNumber)
    // {
    //     $getTokens = $this->getCaptainTokens();

    //     $tokens = [];

    //     foreach ($getTokens as $token) {
    //         $tokens[] = $token['token'];
    //     }

    //     $payload = [
    //         'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
    //         'navigate_route' => self::URL,
    //         'argument' => $orderNumber,
    //     ];

    //     $message = CloudMessage::new()
    //         ->withNotification(
    //             Notification::create(DeliveryCompanyNameConstant::$Delivery_Company_Name, MessageConstant::$MESSAGE_CAPTAIN_NEW_ORDER))
    //         ->withDefaultSounds()
    //         ->withHighestPossiblePriority()->withData($payload);

    //     $this->messaging->sendMulticast($message, $tokens);
    // }

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
