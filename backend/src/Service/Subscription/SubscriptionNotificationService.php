<?php

namespace App\Service\Subscription;

use App\Constant\Notification\NotificationFirebaseConstant;
use App\Service\Notification\NotificationFirebaseService;

class SubscriptionNotificationService
{
    private NotificationFirebaseService $notificationFirebaseService;

    public function __construct(NotificationFirebaseService $notificationFirebaseService)
    {
        $this->notificationFirebaseService = $notificationFirebaseService;
    }

    // Now check if we have to inform the store there is new available car
    // A firebase notification will be sent when there wasn't any available cars and a new one is available
    public function checkRemainingCarsAndInformStore(int $oldRemainingCars, int $newRemainingCars, int $storeOwnerUserId): void
    {
        if($oldRemainingCars === 0 && ($newRemainingCars - $oldRemainingCars >= 1)) {
            $this->notificationFirebaseService->notificationToUserWithoutOrderByUserId($storeOwnerUserId,
                NotificationFirebaseConstant::NEW_CAR_AVAILABLE_NOTIFICATION_TO_STORE_CONST);
        }
    }
}
