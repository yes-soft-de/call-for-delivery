<?php

namespace App\Constant\Notification;

final class NotificationConstant
{
    const NEW_ORDER_TITLE = "طلب جديد";

    const ORDER_RETURNED_PENDING_TITLE = "إلغاء تسليم طلب إلى كابتن";

    const ORDER_RETURNED_PENDING = "تم إلغاء تسليم طلب إلى الكابتن بنجاح";

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

    const ORDER_DESTINATION_DIFFERENT_TITLE_CONST = "اختلاف في موقع المستلم";

    const ORDER_DESTINATION_ADDITION_BY_ADMIN_MESSAGE_CONST = "تم إضافة مسافة من قبل الإدارة على المسافة المحتسبة تلقائيا من أجل الطلب رقم ";

    const ORDER_DESTINATION_ADDITION_BY_CAPTAIN_MESSAGE_CONST = "تم إضافة مسافة من قبل الكابتن على المسافة المحتسبة تلقائيا من أجل الطلب رقم ";

    const ORDER_RETURNED_PENDING_BY_CAPTAIN_TEXT = "تراجع الكابتن عن المتابعة في تسليم الطلب";

    //for captain
    const STATE_ON_WAY_PICK_ORDER_CAPTAIN = "لقد قبلت الطلب ";

    const STATE_IN_STORE_CAPTAIN = "أنت في المتجر";

    const STATE_PICKED_CAPTAIN = "لقد إلتقطت الطلب";

    const STATE_ONGOING_CAPTAIN = "أنت في طريقك لتسليم الطلب";

    const STATE_DELIVERED_CAPTAIN = "لقد سلمت الطلب ,شكرا لك";

    const UN_ACCEPT_ORDER_BY_CAPTAIN_TITLE_CONST = "التراجع عن تسليم الطلب";

    const UN_ACCEPT_ORDER_BY_CAPTAIN_TEXT_CONST = "لقد قمت بالتراجع عن تسليم الطلب";
    
    const STORE = "store";
    
    const CAPTAIN = "captain";

    const SUPPLIER = "supplier";

    const APP_TYPE_SUPPLIER = "suppliers";

    const TITLE_OK = "موافقة";
    
    const PLEASE_RECEIVE_DUES = 'لو سمحت بناء على طلبك تفضل باستلام مستحقاتك بتاريخ ';

    const ORDER_UNASSIGNED_TO_CAPTAIN = "بناء على طلب الإدارة, تم إلغاء إسناد الطلب الموافق للرقم التالي إليك: ";
    
    //sub order    
    const RECYCLING_ORDER_TITLE = "إعادة تدوير الطلب";

    const RECYCLING_ORDER_SUCCESS = "تم إعادة تدوير الطلب بنجاح وأصبح ظاهرا للكباتن";
   
    const ADD_SUB_ORDER = "تم إضافة طلب فرعي إلى الطلب";

    const NEW_SUB_ORDER_TITLE = "طلب فرعي جديد";

    const CREATE_SUB_ORDER_SUCCESS = "تم إنشاء طلب فرعي جديد بنجاح";

    const NON_SUB_ORDER_TITLE = "فك ارتباط طلب";

    const NON_SUB_ORDER_BY_CAPTAIN = "تم فك ارتباط الطلب بواسطة الكابتن";

    const NON_SUB_ORDER = "تم فك ارتباط الطلب";

    const SUB_ORDER_ATTENTION = "تنبيه";

    const SUB_ORDER_HIDE_TEMPORARILY = "الطلب لا يظهر للكباتن بسبب عدم توفر سيارات لديك,سيظهر الطلب تلقائيا عند توفر سيارات في باقتك";
   
    const SUB_ORDER_SHOW = "تم إظهار الطلب للكباتن";

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

    const NEW_NOTIFICATION_BY_ADMIN = "تحديث جديد من قبل الإدارة";

    const NEW_NOTIFICATION_TEXT_BY_ADMIN = "تم إرسال تحديث جديد من قبل الإدارة";

    const HIDE_ORDER_DUE_TO_UNAVAILABLE_CARS_TITLE_CONST = "إخفاء الطلب لعدم توفر سيارات";

    const HIDE_ORDER_DUE_TO_UNAVAILABLE_CARS_TEXT_CONST = "تم إخفاء الطلب الطلب بسبب استنفاذ سيارات اشتراك المتجر";
}

