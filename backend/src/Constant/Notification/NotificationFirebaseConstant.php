<?php

namespace App\Constant\Notification;

final class NotificationFirebaseConstant
{
    const URL = '/order_details';

    const URL_CHAT = '/chat';

    const NEW_ORDER_TITLE = "طلب جديد";
  
    const CREATE_ORDER_SUCCESS = "تم إنشاء طلب جديد بنجاح";

    const UPDATE_ORDER_TITLE = "تعديل طلب";

    const UPDATE_ORDER_SUCCESS = "تم تعديل الطلب بنجاح";

    const STATE_TITLE = "حالة الطلب";

    const STATE_ON_WAY_PICK_ORDER = "الكابتن في طريقه إلى المتجر";

    const STATE_IN_STORE = "الكابتن في المتجر";

    const STATE_PICKED = "الكابتن إلتقط الطلب من المتجر";

    const STATE_ONGOING = "الكابتن في طريقه لتسليم الطلب";

    const STATE_DELIVERED = "تم تسليم الطلب";

    const UPDATE_ORDER_ERROR_CAPTAIN_IN_STORE = "عذرا لا تستطيع تعديل الطلب , الكابتن في المتجر.";

    //for captain
    const STATE_ON_WAY_PICK_ORDER_CAPTAIN = "لقد قبلت الطلب ";

    const STATE_IN_STORE_CAPTAIN = "أنت في المتجر";

    const STATE_PICKED_CAPTAIN = "لقد إلتقطت الطلب";

    const STATE_ONGOING_CAPTAIN = "أنت في طريقك لتسليم الطلب";

    const STATE_DELIVERED_CAPTAIN = "لقد سلمت الطلب ,شكرا لك";

    const MESSAGE_CAPTAIN_NEW_ORDER = "يوجد طلب جديد";

    const DELIVERY_COMPANY_NAME = "C4D";

    const MESSAGE_NEW_CHAT = "لديك رسالة جديدة";
}