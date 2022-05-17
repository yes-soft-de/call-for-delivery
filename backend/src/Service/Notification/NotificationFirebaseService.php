<?php


namespace App\Service\Notification;

use App\Manager\Notification\NotificationFirebaseManager;
use App\Request\Notification\NotificationFirebaseBySuperAdminCreateRequest;
use App\Service\Notification\NotificationTokensService;
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

class NotificationFirebaseService
{
    private Messaging $messaging;
    private NotificationFirebaseManager $notificationFirebaseManager;
    private NotificationTokensService $notificationTokensService;
    private UserService $userService;

    public function __construct(Messaging $messaging, NotificationFirebaseManager $notificationFirebaseManager, NotificationTokensService $notificationTokensService, UserService $userService)
    {
        $this->messaging = $messaging;
        $this->notificationFirebaseManager = $notificationFirebaseManager;
        $this->notificationTokensService = $notificationTokensService;
        $this->userService = $userService;
    }

    public function notificationToCaptains(int $orderId)
    {
        $getTokens = $this->notificationTokensService->getUsersTokensByAppType(NotificationTokenConstant::APP_TYPE_CAPTAIN);

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

        $msg = $text." ".$orderId;

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, $msg))
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
    
    public function notificationNewChatByUserID(NotificationFirebaseByUserIdRequest $request, $userType)
    {
        $devicesToken = [];
       
        if(! $request->getOtherUserID()){
            $adminsTokens =  $this->notificationTokensService->getUsersTokensByAppType(NotificationTokenConstant::APP_TYPE_ADMIN);
       
            foreach ($adminsTokens as $token) {
                $devicesToken[] = $token['token'];
            }
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
        }

        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => NotificationFirebaseConstant::URL_CHAT,
            'argument' => null
        ];
       
        $config = AndroidConfig::fromArray([
            'channel_id' => 'C4d_Notifications_custom_sound_test',
        ]);

        $message = CloudMessage::new()
        ->withNotification(Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, NotificationFirebaseConstant::MESSAGE_NEW_CHAT))
      
        ->withHighestPossiblePriority();
       

        $message = $message->withData($payload)->withAndroidConfig($config);

        $this->messaging->sendMulticast($message, $devicesToken);

        return $devicesToken;
    }
    
    public function notificationNewChatFromAdmin(NotificationFirebaseFromAdminRequest $request)
    {
        $devicesToken = [];

        $token = $this->notificationTokensService->getTokenByUserId($request->getOtherUserID());
       
        $devicesToken[] = $token->getToken();
        
        $payload = [
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            'navigate_route' => NotificationFirebaseConstant::URL_CHAT,
            'argument' => null,
            'channel_id' => 'C4d_Notifications_custom_sound_test',
        ];

        $message = CloudMessage::new()
        ->withNotification(Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, NotificationFirebaseConstant::MESSAGE_NEW_CHAT))
        ->withHighestPossiblePriority();

        $message = $message->withData($payload);

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

                $message = CloudMessage::new()
                    ->withNotification(
                        Notification::create($request->getTitle(), $request->getMessageBody()))
                    ->withHighestPossiblePriority()->withData($payload);

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

                $message = CloudMessage::new()
                    ->withNotification(Notification::create($request->getTitle(), $request->getMessageBody()))
                    ->withHighestPossiblePriority();

                $message = $message->withData($payload);

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

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, NotificationFirebaseConstant::NEW_BID_ORDER_CREATED_SUCCESSFULLY))
            ->withHighestPossiblePriority()->withData($payload);
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

        $msg = NotificationFirebaseConstant::NEW_PRICE_OFFER_ADDED." ".$orderId;

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, $msg))
            ->withHighestPossiblePriority()->withData($payload);

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

        $msg = $text." ".$priceOfferId;

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, $msg))
            ->withHighestPossiblePriority()->withData($payload);

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

        $msg = $text." ".$orderId;

        $message = CloudMessage::new()
            ->withNotification(
                Notification::create(NotificationFirebaseConstant::DELIVERY_COMPANY_NAME, $msg))
            ->withHighestPossiblePriority()->withData($payload);

        $this->messaging->sendMulticast($message, $token);
    }
}
