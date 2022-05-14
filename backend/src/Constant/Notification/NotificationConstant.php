<?php

namespace App\Constant\Notification;

final class NotificationConstant
{
    const NEW_ORDER_TITLE = "طلب جديد";

    const CREATE_ORDER_SUCCESS = "تم إنشاء طلب جديد بنجاح";

    const NEW_BID_ORDER_TITLE = "طلب مناقصة جديد";

    const CREATE_BID_ORDER_SUCCESS = "تم إنشاء طلب مناقصة جديد بنجاح";

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

    const APP_TYPE_ALL = "all";
//for captain
    const STATE_ON_WAY_PICK_ORDER_CAPTAIN = "لقد قبلت الطلب ";

    const STATE_IN_STORE_CAPTAIN = "أنت في المتجر";

    const STATE_PICKED_CAPTAIN = "لقد إلتقطت الطلب";

    const STATE_ONGOING_CAPTAIN = "أنت في طريقك لتسليم الطلب";

    const STATE_DELIVERED_CAPTAIN = "لقد سلمت الطلب ,شكرا لك";
    
    const STORE = "store";
    
    const CAPTAIN = "captain";

    const SUPPLIER = "supplier";

    const APP_TYPE_SUPPLIER = "suppliers";
    
    const RECYCLING_ORDER_TITLE = "تدوير الطلب";

    const RECYCLING_ORDER_SUCCESS = "تم إعادة تدوير الطلب بنجاح و أصبح ظاهرا للكباتن";

    // local notifications for supplier
    const STATE_CAPTAIN_ON_WAY_TO_PICK_ORDER = "الكابتن في طريقه إلى المتجر";

    const STATE_CAPTAIN_IN_STORE = "الكابتن في المتجر";

    const STATE_ORDER_PICKED = "الكابتن إلتقط الطلب من المتجر";

    const STATE_ORDER_ONGOING = "الكابتن في طريقه لتسليم الطلب";

    const STATE_ORDER_DELIVERED = "تم تسليم الطلب";

    // price offer
    const NEW_PRICE_OFFER = "عرض سعر جديد";

    const NEW_PRICE_OFFER_ADDED = "تم إنشاء عرض سعر جديد بنجاح";

    const PRICE_OFFER_STATUS_UPDATE = "تحديث حالة عرض السعر";

    const PRICE_OFFER_STATUS_ACCEPTED = "تم قبول عرض السعر من قبل المتجر";

    const PRICE_OFFER_STATUS_REFUSED = "تم رفض عرض السعر من قبل المتجر";
}

