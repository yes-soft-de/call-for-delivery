// Developing Domain ===> 'http://134.209.241.49';
// Production Domain ===> 'http://46.101.100.62';
class Urls {
  /*--------BASES-------------------*/
  static const String DOMAIN = 'http://134.209.241.49';
  static const String BASE_API = DOMAIN + '';
  static const String VERSION = '/v1';
  static const String VERSION_ADMIN = '/v1/admin';
  static const String BASE_API_STORE = DOMAIN + VERSION + '/store';
  static const String BASE_API_CATEGORY =
      DOMAIN + VERSION_ADMIN + '/packagecategory';
  static const String BASE_API_PACKAGE_ADMIN =
      DOMAIN + VERSION_ADMIN + '/package';
  static const String BASE_API_PACKAGE = DOMAIN + VERSION + '/package';
  static const String BASE_API_COMPANY = DOMAIN + VERSION + '/company';
  static const String BASE_API_SUPPLIER_CATE =
      DOMAIN + VERSION_ADMIN + '/suppliercategory';
  static const String BASE_API_SUPPLIER =
      DOMAIN + VERSION_ADMIN + '/supplierprofile';
  static const String BASE_API_ANNOUNCEMENT =
      DOMAIN + VERSION_ADMIN + '/announcement';

  static const String BASE_API_DELIVERY_CAR =
      DOMAIN + VERSION_ADMIN + '/deliverycar';

  static const String BASE_API_BRANCH_ADMIN =
      DOMAIN + VERSION_ADMIN + '/storeownerbranch';
  static const String BASE_API_NOTICE_ADMIN =
      DOMAIN + VERSION_ADMIN + '/notification';
  static const String BASE_API_CHAT_ROM = DOMAIN + VERSION + '/chatroom';
  static const String BASE_API_FIREBASE_NOTIFICATION =
      DOMAIN + VERSION + '/notificationfirbase';
  static const String BASE_API_NOTIFICATION_TOKEN =
      DOMAIN + VERSION + '/notificationtoken';

  static const String BASE_API_CAPTAIN_OFFER_ADMIN =
      DOMAIN + VERSION_ADMIN + '/captainoffer';
  static const String BASE_API_REPORT_ADMIN =
      DOMAIN + VERSION_ADMIN + '/report';
  static const String BASE_API_CAPTAIN = DOMAIN + VERSION_ADMIN + '/captain';

  static const String BASE_API_ORDER = DOMAIN + VERSION_ADMIN + '/order';
  static const String BASE_API_ORDER_CASH_FINANCE =
      DOMAIN + VERSION_ADMIN + '/storeownerduesfromcashorders';
  static const String BASE_API_ORDER_CASH_FINANCE_FOR_CAPTAIN =
      DOMAIN + VERSION_ADMIN + '/captainamountfromordercash';

  static const String BASE_API_STORE_PAYMENTS =
      DOMAIN + VERSION_ADMIN + '/storeownerpayment';
  static const String BASE_API_STORE_PAYMENTS_TO_STORE =
      DOMAIN + VERSION_ADMIN + '/storeownerpaymentfromcompany';
  static const String BASE_API_CAPTAIN_FINANCE_BY_ORDER =
      DOMAIN + VERSION_ADMIN + '/captainfinancialsystemaccordingnorderbyadmin';
  static const String BASE_API_CAPTAIN_FINANCE_BY_HOURS = DOMAIN +
      VERSION_ADMIN +
      '/captainfinancialsystemaccordingtocountofhoursbyadmin';
  static const String BASE_API_CAPTAIN_FINANCE_BY_ORDER_COUNTS = DOMAIN +
      VERSION_ADMIN +
      '/captainfinancialsystemaccordingntocountofordersbyadmin';
  static const BASE_CAPTAIN_PAYMENT =
      DOMAIN + VERSION_ADMIN + '/captainpayment';
  static const BASE_CAPTAIN_PAYMENT_TO_COMPANY =
      DOMAIN + VERSION_ADMIN + '/captainpaymenttocompany';
  static const BASE_CAPTAIN_PAYMENTS =
      DOMAIN + VERSION_ADMIN + '/captainpayments';
  static const BASE_CAPTAIN_ACCOUNT_BALANCE =
      DOMAIN + VERSION_ADMIN + '/captainfinancialsystemdetail';
  static const BASE_CAPTAIN_ACCOUNT_BALANCE_DUES =
      DOMAIN + '/v1/captainfinancialduesforadmin';
  static const BASE_STORE_SUBSCRIPTIONS_FINANCE =
      DOMAIN + VERSION_ADMIN + '/subscription';

  /*--------Auth-------------------*/
  static const String IMAGES_ROOT =
      'https://c4d-media.s3.eu-central-1.amazonaws.com' + '/upload/';
  static const UPLOAD_API = BASE_API + '/uploadfile';
  static const SIGN_UP_API = BASE_API + '/createAdmin';
  static const OWNER_PROFILE_API = BASE_API + '/userprofile';
  static const CREATE_TOKEN_API = BASE_API + '/login_check';
  static const VERIFY_CODE_API = BASE_API + '/verifycode';
  static const CHECK_USER_VERIFIED_API = BASE_API + '/checkverificationstatus';
  static const RESEND_CODE_API = BASE_API + '/resendnewverificationcode';
  static const RESET_PASSWORD = BASE_API + '/resetpasswordorder';
  static const VERIFY_RESET_PASSWORD_CODE =
      BASE_API + '/verifyresetpasswordcode';
  static const UPDATE_PASSWORD = BASE_API + '/updatepassword';
  static const CHECK_USER_ROLE = BASE_API + '/checkUserType';

  /*--------home-------------------*/
  static const GET_REPORT = BASE_API_REPORT_ADMIN + '/getstatistics';

  /*--------Notification-------------------*/
  static const NEEDFORSUPPORT_ANYNAMOUS = BASE_API + '/anonymouschat';
  static const NOTIFICATIONTOADMIN_API = BASE_API + '/notificationtoadmin';
  static const NOTIFICATIONNEWCHAT_ANYN_API =
      BASE_API_FIREBASE_NOTIFICATION + '/notificationnewchatanonymous';
  static const NOTIFICATION_API =
      BASE_API_NOTIFICATION_TOKEN + '/notificationtoken';
  static const NOTIFICATIONNEWCHAT_API =
      BASE_API_FIREBASE_NOTIFICATION + '/notificationnewchatfromadmin';
  static const NEEDFORSUPPORT = BASE_API + '/updateneedsupport';

  /*--------Store-------------------*/
  static const GET_STORES =
      BASE_API_STORE + '/storeownersprofilesbystatusforadmin/';
  static const GET_STORE_PROFILE =
      BASE_API_STORE + '/storeownersprofilesbyidforadmin/';
  static const ACTIVATE_STORE = BASE_API_STORE + '/storeownerprofilestatus';
  static const UPDATE_STORE_INFO = BASE_API_STORE + '/storeownerprofilebyadmin';

  static const FILTER_OWNER_ORDERS_API =
      BASE_API_ORDER + '/filterordersbyadmin';
  static const ORDERS_PENDING_API = BASE_API_ORDER + '/orderpending';
  static const FILTER_CASH_ORDERS_FINANCES_API =
      BASE_API_ORDER_CASH_FINANCE + '/storeownerduesfromcashorders';
  static const FILTER_CASH_ORDERS_FINANCES_CAPTAIN_API =
      BASE_API_ORDER_CASH_FINANCE_FOR_CAPTAIN + '/captainamountfromordercash';
  static const GET_ORDERS_DETAILS = BASE_API_ORDER + '/orderbyidforadmin/';
  static const FILTER_CAPTAIN_NOT_ARRIVED =
      BASE_API_ORDER + '/filtercaptainnotarrivedorders';

  /*------------------Package Category's ----------------*/
  static const GET_PACKAGE_CATEGORY = BASE_API_CATEGORY + '/categories';
  static const CREATE_PACKAGE_CATEGORY = BASE_API_CATEGORY + '/packagecategory';

  /*-----------------------Package--------------------------------*/
  static const GET_PACKAGE_BY_CATEGORY =
      BASE_API_PACKAGE_ADMIN + '/packagesbycategoryid/';
  static const CREATE_PACKAGE = BASE_API_PACKAGE_ADMIN + '/package';
  static const ACTIVE_PACKAGE = BASE_API_PACKAGE_ADMIN + '/packagestatus';

  /*-------------------------------Company-----------------------------------*/
  static const COMPANY_INFO = BASE_API_COMPANY + '/companyinfo';

  /*----------------------------branch----------------*/
  static const UPDATE_BRANCH_API = BASE_API_BRANCH_ADMIN + '/branch';
  static const CREATE_BRANCH_LIST_API =
      BASE_API_BRANCH_ADMIN + '/multiplebranches';
  static const DELETE_BRANCH_API = BASE_API_BRANCH_ADMIN + '/deletebranch';
  static const GET_BRANCHES_API = BASE_API_BRANCH_ADMIN + '/branches/';

  /*------------------notice----------------*/
  static const GET_NOTICE = BASE_API_NOTICE_ADMIN + '/adminnotifications';
  static const UPDATE_NOTICE = BASE_API_NOTICE_ADMIN + '/adminnotification';
  static const CREATE_NOTICE = BASE_API_NOTICE_ADMIN + '/notificationtoapp';

  /*-------------------chatroom--------------*/
  static const GET_CHAT_ROOMS_STORES =
      BASE_API_CHAT_ROM + '/chatroomswithstores';
  static const GET_CHAT_ROOMS_CAPTAINS =
      BASE_API_CHAT_ROM + '/chatroomswithcaptains';
  static const GET_CHAT_ROOMS_SUPPLIER =
      BASE_API_CHAT_ROM + '/chatroomswithsuppliers';

  /*-------------------captainsOffer--------------*/
  static const GET_CAPTAIN_OFFERS =
      BASE_API_CAPTAIN_OFFER_ADMIN + '/captainoffers';
  static const CREATE_CAPTAIN_OFFERS = BASE_API_CAPTAIN_OFFER_ADMIN + '/create';
  static const UPDATE_CAPTAIN_OFFERS = BASE_API_CAPTAIN_OFFER_ADMIN + '/update';
  static const ACTIVE_CAPTAIN_OFFERS =
      BASE_API_CAPTAIN_OFFER_ADMIN + '/updatecaptainofferstatusbyadmin';

  /*------------------------CAPTAINS------------------------*/
  static const GET_CAPTAINS = BASE_API_CAPTAIN + '/captainsprofilesbystatus/';
  static const GET_CAPTAIN_PROFILE = BASE_API_CAPTAIN + '/captainprofilebyid/';
  static const ACTIVATE_CAPTAIN = BASE_API_CAPTAIN + '/captainprofilestatus';
  static const UPDATE_CAPTAIN = BASE_API_CAPTAIN + '/captainprofile';
  /*------------------------STORE PAYMENTS------------------------*/
  static const CREATE_STORE_PAYMENTS =
      BASE_API_STORE_PAYMENTS + '/storeownerpayment';
  static const CREATE_STORE_PAYMENTS_TO_STORE =
      BASE_API_STORE_PAYMENTS_TO_STORE + '/storeownerpaymentfromcompany';
  static const GET_STORE_PAYMENTS = BASE_API_STORE_PAYMENTS + '/storepayments';
  static const GET_STORE_SUBSCRIPTIONS_FINANCE =
      BASE_STORE_SUBSCRIPTIONS_FINANCE + '/subscriptionswithpayment';

  /*------------------------CAPTAIN PAYMENTS------------------------*/
  static const CREATE_CAPTAIN_PAYMENTS =
      BASE_CAPTAIN_PAYMENT + '/captainpayment';
  static const CREATE_CAPTAIN_PAYMENTS_TO_COMPANY =
      BASE_CAPTAIN_PAYMENT_TO_COMPANY + '/captainpaymenttocompany';
  static const GET_CAPTAIN_PAYMENTS = BASE_CAPTAIN_PAYMENT + '/captainpayments';
  static const CREATE_CAPTAIN_FINANCE =
      DOMAIN + '/v1/captainfinancialsystemdetail/captainfinancialsystemdetail';

  /*------------------------CAPTAIN FINANCE------------------------*/
  static const GET_CAPTAIN_FINANCE_BY_ORDERS =
      BASE_API_CAPTAIN_FINANCE_BY_ORDER +
          '/captainfinancialsystemaccordingonorderbyadmin';
  static const GET_CAPTAIN_FINANCE_BY_HOURS =
      BASE_API_CAPTAIN_FINANCE_BY_HOURS +
          '/captainfinancialsystemaccordingtocountofhoursbyadmin';
  static const GET_CAPTAIN_FINANCE_BY_ORDER_COUNTS =
      BASE_API_CAPTAIN_FINANCE_BY_ORDER_COUNTS +
          '/captainfinancialsystemaccordingtocountofordersbyadmin';
  static const GET_CAPTAIN_ACCOUNT_BALANCE =
      BASE_CAPTAIN_ACCOUNT_BALANCE + '/captainbalancedetailforcaptainspecific';
  static const UPDATE_CAPTAIN_FINANCE_PLAN =
      BASE_CAPTAIN_ACCOUNT_BALANCE + '/captainfinancialsystemdetailstatus';
  static const CHANGE_CAPTAIN_FINANCE_PLAN =
      BASE_CAPTAIN_ACCOUNT_BALANCE + '/captainfinancialsystemdetailupdate';
  static const GET_CAPTAIN_FINANCE_DUES =
      BASE_CAPTAIN_ACCOUNT_BALANCE_DUES + '/captainfinancialduesforadmin';
  /*-----------------Supplier--Categories---------------*/
  static const GET_SUPPLIER_CATEGORIES =
      BASE_API_SUPPLIER_CATE + '/suppliercategories';
  static const CREATE_SUPPLIER_CATEGORY =
      BASE_API_SUPPLIER_CATE + '/suppliercategory';
  static const ENABLE_SUPPLIER_CATEGORY =
      BASE_API_SUPPLIER_CATE + '/suppliercategorystatus';

  /*-----------------Supplier-------------------------------*/
  static const GET_SUPPLIERS = BASE_API_SUPPLIER + '/filtersuppliersprofiles';
  static const ACTIVE_SUPPLIER = BASE_API_SUPPLIER + '/supplierprofilestatus';
  static const GET_SUPPLIER_PROFILE =
      BASE_API_SUPPLIER + '/supplierprofilebyid/';

  /*-----------------Supplier--announcement-----------------------------*/
  static const GET_ANNOUNCEMENT = BASE_API_ANNOUNCEMENT + '/filterannouncement';
  static const ACTIVE_ANNOUNCEMENT =
      BASE_API_ANNOUNCEMENT + '/announcementadministrationstatus';

  /*-----------------cars_delivery-----------------------------*/
  static const GET_DELIVERY_CARS =
      BASE_API_DELIVERY_CAR + '/deliverycarsforadmin';
  static const ADD_DELIVERY_CARS = BASE_API_DELIVERY_CAR + '/deliverycar';

  /*-----------------------------bid order----------------------------*/
  static const GET_BID_ORDER = BASE_API_ORDER + '/filterbidordersbyadmin';
  static const GET_BID_ORDER_DETAILS =
      BASE_API_ORDER + '/bidorderbyidforadmin/';
}
