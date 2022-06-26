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

    const ORDER_IS_BEING_HIDDEN = "تم إخفاء الطلب ";

    //for captain
    const STATE_ON_WAY_PICK_ORDER_CAPTAIN = "لقد قبلت الطلب ";

    const STATE_IN_STORE_CAPTAIN = "أنت في المتجر";

    const STATE_PICKED_CAPTAIN = "لقد إلتقطت الطلب";

    const STATE_ONGOING_CAPTAIN = "أنت في طريقك لتسليم الطلب";

    const STATE_DELIVERED_CAPTAIN = "لقد سلمت الطلب ,شكرا لك";

    const MESSAGE_CAPTAIN_NEW_ORDER = "يوجد طلب جديد";

    const DELIVERY_COMPANY_NAME = "C4D";

    const MESSAGE_NEW_CHAT = "لديك رسالة جديدة";

    const NEW_BID_ORDER_CREATED_SUCCESSFULLY = "تم إنشاء طلب مناقصة جديد";

    const NEW_PRICE_OFFER_ADDED = "تم إضافة عرض سعر جديد على الطلب الموافق للرقم المرفق ";

    const PRICE_OFFER_ACCEPTED = "تم قبول عرض السعر المقدم الموافق للرقم ";

    const PRICE_OFFER_REFUSED = "تم رفض عرض السعر المقدم الموافق للرقم ";

    //sub order    
    const RECYCLING_ORDER_TITLE = "تدوير الطلب";

    const RECYCLING_ORDER_SUCCESS = "تم إعادة تدوير الطلب بنجاح و أصبح ظاهرا للكباتن";
       
    const ADD_SUB_ORDER = "تم إضافة طلب فرعي";
    
    const NEW_SUB_ORDER_TITLE = "طلب فرعي جديد";
    
    const CREATE_SUB_ORDER_SUCCESS = "تم إنشاء طلب فرعي جديد بنجاح";
    
    const NON_SUB_ORDER_TITLE = "فك ارتباط طلب";
    
    const NON_SUB_ORDER_BY_CAPTAIN = "تم فك ارتباط الطلب بواسطة الكابتن";
    
    const NON_SUB_ORDER = "تم فك ارتباط الطلب";
    
    const SUB_ORDER_ATTENTION = "تنبيه";
    
    const SUB_ORDER_HIDE_TEMPORARILY = "الطلب لا يظهر للكباتن بسبب عدم توفر سيارات لديك,سيظهر الطلب تلقائيا عند توفر سيارات في باقتك";
       
    const SUB_ORDER_SHOW = "تم إظهار الطلب للكباتن";

    const ORDER_ID = " الطلب رقم";

    const FROM = " من ";

    const ORDER_UPDATE_BY_ADMIN = "تم إجراء تعديلات بواسطة الإدارة على الطلب رقم ";
  
    const ORDER_UPDATE_BY_STORE = "تم إجراء تعديلات بواسطة المتجر على الطلب رقم ";

    const ORDER_ASSIGN_BY_ADMIN = "تم إسناد طلب من قبل الإدارة إليك, يرجى توصيل الطلب رقم ";
    
    const NOTIFICATION_FROM_ADMIN = "يوجد تحديث جديد من الإدارة يرجى الإطلاع ";

    const URL_NOTIFICATION = '/update_screen';
}
