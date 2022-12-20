<?php

namespace App\Constant\Notification;

final class SubscriptionFirebaseNotificationConstant
{
    // STORE actions on subscription
    const STORE_CREATE_NEW_SUBSCRIPTION_CONST = "تم إنشاء اشتراك جديد من قبل المتجر: ";

    const STORE_CREATE_NEW_SUBSCRIPTION_FOR_ONE_DAY_CONST = "تم إنشاء اشتراك جديد ليوم واحد فقط من قبل المتجر: ";

    const STORE_UPDATE_SUBSCRIPTION_CONST = "تم تحديث اشتراك المتجر: ";
    // ---------------------------------------------------------------------
    // Negative values in Store Subscription
    const STORE_SUBSCRIPTION_REMAINING_ORDER_NEGATIVE_VALUE_CONST = "تنبيه! عدد الطلبات المتبقية وصل قيمة سالبة من أجل اشتراك المتجر: ";

    const STORE_SUBSCRIPTION_REMAINING_CARS_NEGATIVE_VALUE_CONST = "تنبيه! عدد السيارات المتبقية وصل قيمة سالبة من أجل اشتراك المتجر: ";
    // ---------------------------------------------------------------------
}
