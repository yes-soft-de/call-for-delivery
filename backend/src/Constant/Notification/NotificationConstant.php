<?php

namespace App\Constant\Notification;

final class NotificationConstant
{
    const NEW_ORDER_TITLE = "طلب جديد";
  
    const CREATE_ORDER_SUCCESS = "تم إنشاء طلب جديد بنجاح";

    const UPDATE_ORDER_TITLE = "تعديل طلب";

    const UPDATE_ORDER_SUCCESS = "تم تعديل الطلب بنجاح";

    const NOT_FOUND = "not found";

    const USER_ID_NULL = 0;
   
    const APP_TYPE_STORE = "stores";
    
    const APP_TYPE_CAPTAIN = "captains";

    const STATE_TITLE = "حالة الطلب";

    const STATE_ON_WAY_PICK_ORDER = "الكابتن في طريقه إلى المتجر";

    const STATE_IN_STORE = "الكابتن في المتجر";

    const STATE_PICKED = "الكابتن إلتقط الطلب من المتجر";

    const STATE_ONGOING = "الكابتن في طريقه لتسليم الطلب";

    const STATE_DELIVERED = "تم تسليم الطلب";

    const UPDATE_ORDER_ERROR_CAPTAIN_IN_STORE = "عذرا لا تستطيع تعديل الطلب , الكابتن في المتجر.";

    const CANCEL_ORDER_TITLE = "حذف طلب";

    const CANCEL_ORDER_SUCCESS = "تم حذف الطلب بنجاح.";

    const CANCEL_ORDER_ERROR_TIME = "لا يمكن حذف الطلب, لقد تجاوزت الوقت المسموح به للحذف.";

    const CANCEL_ORDER_ERROR_ACCEPTED = "لا يمكن حذف الطلب, الكابتن استلم الطلب.";
}
