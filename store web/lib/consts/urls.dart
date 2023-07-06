// Developing Domain ===> 'http://134.209.241.49/';
// Production Domain ===> 'http://46.101.100.62'
// Named Domain ===> ''
// Named Domain ===> ''

const String devDomain = 'http://134.209.241.49';
const String prodDomain = 'http://46.101.100.62';

class Urls {
  static const String DOMAIN = devDomain;
  static const String BASE_API = '$DOMAIN/v1/store';
  static const String BASE_API_USER = '$DOMAIN/v1/user';
  static const String VERSION = '/v1';
  static const String BASE_API_STORE = DOMAIN + VERSION + '/admin';

  static const String IMAGES_ROOT =
      'https://c4d-media.s3.eu-central-1.amazonaws.com' '/upload/';
  static const DELETE_STORE =
      BASE_API_STORE + '/storeowner/deletestoreownerprofilebyadmin';
  static const UPLOAD_API = '$DOMAIN/uploadfile';
  static const UPLOAD_PDF_API = '$DOMAIN/uploadpdffile';
  static const SIGN_UP_API = '$BASE_API/storeownerregister';
  static const OWNER_PROFILE_API = '$BASE_API/storeowner';
  static const GET_OWNER_PROFILE_API = '$BASE_API/storeownerprofilebyid';
  static const CREATE_TOKEN_API = '$DOMAIN/login_check';
  static const VERIFY_CODE_API = '$DOMAIN/v1/verification/verifycode';
  static const CHECK_USER_VERIFIED_API =
      '$DOMAIN/v1/verification/checkverificationstatus';
  static const RESEND_CODE_API =
      '$DOMAIN/v1/verification/resendnewverificationcode';
  static const RESET_PASSWORD = '$DOMAIN/v1/resetpassword/resetpasswordorder';
  static const VERIFY_RESET_PASSWORD_CODE =
      '$DOMAIN/v1/resetpassword/verifyresetpasswordcode';
  static const UPDATE_PASSWORD = '$DOMAIN/v1/resetpassword/updatepassword';
  static const EASY_UPDATE_PASSWORD =
      '$DOMAIN/v1/resetpassword/updatepasswordbyloggedinuser';
  static const REPORT_API = '$BASE_API/report';
  static const CREATE_CUSTOM_PRODUCT_API = '$BASE_API/customproductnotfound';
  static const NOTIFICATION_API =
      '$DOMAIN/v1/notificationtoken/notificationtoken';
  static const COMPANYINFO_API = '$BASE_API/companyinfoforuser';
  static const NOTIFICATIONNEWCHAT_API =
      '$DOMAIN/v1/notificationfirbase/notificationnewchatbyuserid';
  static const NEEDFORSUPPORT = '$BASE_API/updateneedsupport';
  static const NEEDFORSUPPORT_ANYNAMOUS = '$BASE_API/anonymouschat';
  static const NOTIFICATIONTOADMIN_API = '$BASE_API/notificationtoadmin';
  static const NOTIFICATIONNEWCHAT_ANYN_API =
      '$BASE_API/notificationnewchatanonymous';
  static const CREATE_CAPTAIN_PROFILE = '$BASE_API/captainprofile';
  static const CAPTAIN_ACTIVE_STATUS_API = '$BASE_API/captainisactive';
  static const ORDER_STATUS_API = '$DOMAIN/v1/order/storeorder/';
  static const NEARBY_ORDERS_API = '$BASE_API/closestOrders';
  static const CAPTAIN_ACCEPTED_ORDERS_API = '$BASE_API/getAcceptedOrder';
  static const ACCEPT_ORDER_API = '$BASE_API/acceptedOrder';
  static const CAPTAIN_ORDER_UPDATE_API = '$BASE_API/orderUpdateState';
  static const ORDER_UPDATE_BILL_API = '$BASE_API/orderUpdateInvoiceByCaptain';
  static const UPDATES_API = '$BASE_API/updateall';
  static const ORDER_BY_ID = '$BASE_API/orderStatus/';
  static const SEND_TO_RECORD = '$BASE_API/record';
  static const CAPTAIN_PROFILE_API = '$BASE_API/captainprofile';
  static const TERMS_CAPTAIN = '$BASE_API/termscaptain';
  static const LOG_API = '$BASE_API/getRecords';
  static const CAPTAIN_BALANCE_ACCOUNT =
      '$BASE_API/captainfinancialaccountforadmin';
  static const CAPTAIN_BALANCE_LAST_MONTH =
      '$BASE_API/captainFinancialAccountInLastMonthForAdmin';
  static const GET_ORDER_LOGS = '$BASE_API/orderLogs';
  static const GET_CAPTAINS_LOGS = '$BASE_API/ordersandcountbycaptainid/';
  static const GET_STORES_LOGS = '$BASE_API/ordersandcountbystoreprofileid/';
  static const CHECK_USER_ROLE = '$BASE_API_USER/checkUserType';
  static const STORE_CATEGORIES = '$BASE_API/storecategories';
  static const GET_STORE_CATEGORY = '$BASE_API/storecategory/';
  static const GET_PRODUCT_CATEGORY = '$BASE_API/storeproductcategory/';
  static const STORE_CATEGORIES_LINKING_API = '$BASE_API/allstorecategories';
  static const CREATE_STORE_CATEGORIES = '$BASE_API/createstorecategory';
  static const GET_STORES_BY_CATEGORY =
      '$BASE_API/storeownerbycategoryidforadmin';
  static const GET_STORES = '$BASE_API/storeowners';
  static const GET_STORES_INACTIVE = '$BASE_API/storesinactive';
  static const GET_STORES_INACTIVE_FILTER = '$BASE_API/storesinactivefilter/';
  static const GET_STORE_PROFILE = '$BASE_API/storeownerprofilebyid/';
  static const GET_STORE_PROFILE_FOR_ADMIN =
      BASE_API_STORE + '/storeowner/storeownerprofilebyidforadmin/';
  static const CREATE_STORES = '$BASE_API/storeownercreatbyadmin';
  static const CREATE_PAYMENTS_FOR_STORE =
      '$BASE_API/deliverycompanypaymentstostore';
  static const DELETE_PAYMENTS_FOR_STORE = '$BASE_API/paymenttostore';
  static const CREATE_SUB_CATEGORIES = '$BASE_API/storeproductcategorylevelone';
  static const GET_PRODUCTS_CATEGORY = '$BASE_API/storeProductsCategory/';
  static const GET_SUBCATEGORIES_LEVEL_ONE =
      '$BASE_API/storeproductscategorylevelonefroadmin';
  static const GET_ALL_SUBCATEGORIES_LEVEL_ONE =
      '$BASE_API/allproductcategorieslevelone';
  static const GET_ALL_SUBCATEGORIES_LEVEL_ONE_LINKING_API =
      '$BASE_API/allsubcategorieslevelone';
  static const GET_SUBCATEGORIES_LEVEL_TOW =
      '$BASE_API/storeproductscategoryleveltwoforadmin';
  static const GET_ALL_SUBCATEGORIES_LEVEL_TOW =
      '$BASE_API/allproductcategoriesleveltwo';
  static const GET_PRODUCTS = '$BASE_API/productsstorebyprofileid/';
  static const CREATE_PRODUCTS_CATEGORY = '$BASE_API/StoreProductCategory';
  static const CREATE_SUBCATEGORIES_LEVEL_TOW =
      '$BASE_API/storeproductcategoryleveltwo';
  static const CREATE_PRODUCTS = '$BASE_API/createproductbyadmin';
  static const CREATE_PRODUCTS_CATEGORY_FOR_STORE = '/StoreProductCategory';
  static const GET_IN_ACTIVE_CAPTAINS = '$BASE_API/getcaptainsinactive';
  static const CAPTAIN_FILTER = '$BASE_API/captainfilter/';
  static const STORE_FILTER = '$BASE_API/storeFilter/';
  static const CLIENT_FILTER = '$BASE_API/clientfilterbyname/';
  static const ACTIVATE_CAPTAIN = '$BASE_API/captainprofileupdatebyadmin';
  static const ACTIVATE_DISTRO = '$BASE_API/mandobupdatebyadmin';
  static const PAYMENTS_FROM_CAPTAIN =
      '$BASE_API/deliveryCompanyPaymentsFromCaptain';
  static const DELETE_PAYMENTS_FROM_CAPTAIN = '$BASE_API/paymentfromcaptain';
  static const PAYMENTS_TO_CAPTAIN =
      '$BASE_API/deliveryCompanyPaymentsToCaptain';
  static const PAYMENTS_TO_DISTRO =
      '$BASE_API/deliverycompanypaymenttorepresentative';
  static const DELETE_PAYMENTS_TO_CAPTAIN = '$BASE_API/paymenttocaptain';
  static const DELETE_PAYMENTS_TO_DISTRO = '$BASE_API/paymenttorepresentative';
  static const PAYMENTS_LIST = '$BASE_API/electronicpaymentinfo';
  static const GET_CAPTAIN_PROFILE = '$BASE_API/captainProfile/';
  static const GET_DISTRO_PROFILE = '$BASE_API/representativeprofile/';
  static const GET_CLIENT_PROFILE = '$BASE_API/clientprofilebyid/';
  static const UPDATE_STORE_CATEGORY = '$BASE_API/updatestorecategory';
  static const UPDATE_STORE = '$BASE_API/storeownerprofileupdatebyadmin';
  static const UPDATE_PRODUCT_CATEGORY = '$BASE_API/storeProductCategory';
  static const UPDATE_PRODUCT = '$BASE_API/updateProductByAdmin';
  static const GET_PROFILE_COMPANY = '$BASE_API/companyinfoall';
  static const GET_FINANCIAL_COMPANY = '$BASE_API/financialCompensations';
  static const UPDATE_FINANCIAL_COMPANY = '$BASE_API/financialCompensation';
  static const GET_DELIVERY_PRICE_COMPANY =
      '$BASE_API/getDeliveryCompanyFinancialById/1';
  static const UPDATE_DELIVERY_PRICE_COMPANY =
      '$BASE_API/deliveryCompanyFinancial';
  static const CREATE_COMPANY_PROFILE = '$BASE_API/companyinfo';
  static const GET_CAPTAINS_LIST = '$BASE_API/captains';
  static const GET_CLIENTS_LIST = '$BASE_API/clientsprofile';
  static const GET_REPORT = '$BASE_API/countreport';
  static const GET_ACCOUNT_BALANCE_CAPTAIN =
      '$BASE_API/captainfinancialaccountforadmin/';
  static const GET_ACCOUNT_BALANCE_DISTRO =
      '$BASE_API/representativefinancialaccountforadmin/';
  static const GET_ACCOUNT_BALANCE_CAPTAIN_LAST_MONTH =
      '$BASE_API/captainfinancialaccountinlastmonthforadmin/';
  static const GET_ACCOUNT_BALANCE_DISTRO_LAST_MONTH =
      '$BASE_API/representativefinancialaccountinlastmonthforadmin/';
  static const GET_ACCOUNT_BALANCE_CAPTAIN_SPECIFIC =
      '$BASE_API/captainfinancialaccountinspecificdateforadmin/';
  static const GET_ACCOUNT_BALANCE_DISTRO_SPECIFIC =
      '$BASE_API/representativefinancialaccountinspecificdateforadmin/';
  static const GET_UNFINISHED_PAYMENT =
      '$BASE_API/captainsremainingforitamount';
  static const GET_REMAINING_PAYMENT = '$BASE_API/captainsremainingonitamount';
  static const GET_REMAINING_PAYMENT_TO_DISTRO =
      '$BASE_API/representativeremainigforitamount';
  static const GET_PENDING_ORDER = '$BASE_API/getpendingorders';
  static const GET_WITHOUT_PENDING_ORDER = '$BASE_API/getOrdersWithOutPending ';
  static const GET_ONGOING_ORDERS = '$BASE_API/getordersongoing';
  static const GET_SPECIFIC_DATE_ORDERS = '$BASE_API/getordersinspecificdate/';
  static const GET_ORDER_DETAILS = '$BASE_API/orderdetailsforadmin/';
  static const GET_ORDER_TIMELINE = '$BASE_API/orderlogstimeline/';
  static const GET_CAPTAINS_REPORT =
      '$BASE_API/countorderseverycaptaininlastmonth';
  static const GET_CAPTAINS_REPORT_SPECIFIC =
      '$BASE_API/countorderseverycaptaininspecificdate';
  static const GET_STORES_REPORT = '$BASE_API/countOrdersEveryStoreInLastMonth';
  static const GET_STORES_REPORT_SPECIFIC =
      '$BASE_API/countorderseverystoreinspecificdate';
  static const GET_CLIENTS_REPORT =
      '$BASE_API/countorderseveryclientinlastmonth';
  static const GET_CLIENTS_REPORT_SPECIFIC =
      '$BASE_API/countorderseveryclientinspecificdate';
  static const GET_PRODUCTS_REPORT =
      '$BASE_API/countorderseveryproductinlastmonth';
  static const GET_PRODUCTS_REPORT_SPECIFIC =
      '$BASE_API/countorderseveryproductinspecificdate';
  static const DELETE_SUB_CATEGORIES = '$BASE_API/storeproductcategory/';
  static const DELETE_CATEGORIES = '$BASE_API/storecategory/';
  static const UPDATE_PRODUCT_COMMISSION =
      '$BASE_API/updateproductcommissionbyadmin';
  static const GET_DISTRO_API = '$BASE_API/mandobfilterbystatus/';

  static const GET_ACCOUNT_BALANCE_STORE =
      '$BASE_API/storefinancialaccountforadmin/';
  static const GET_ACCOUNT_BALANCE_STORE_LAST_MONTH =
      '$BASE_API/captainfinancialaccountinlastmonthforadmin/';
  static const GET_ACCOUNT_BALANCE_STORE_SPECIFIC =
      '$BASE_API/captainfinancialaccountinspecificdateforadmin/';
  static const GET_CUSTOM_PRODUCTS_API = '$BASE_API/customproductsnotfound';
  static const GET_CLIENT_NEED_SUPPORT = '$BASE_API/clientwhoneedsupport';
  static const UPDATE_MAIN_CATEGORIES_LINK =
      '$BASE_API/mainsublevelonecategorieslink';
  static const UPDATE_SUB_CATEGORIES_LINK =
      '$BASE_API/levelonesubleveltwocategorieslink';

  static const CREATE_NEW_TRANS_STORE_CATEGORY =
      '$BASE_API/createstorecategorytranslation';
  static const CREATE_NEW_TRANS_PRODUCT_CATEGORY =
      '$BASE_API/createstoreproductcategorytranslation';
  static const BRANCHES_API = '$DOMAIN/v1/StoreOwnerBranch/branches';
  static const PACKAGES_API = '$DOMAIN/v1/package/packagesactive';
  static const PACKAGES_CATEGORIES_API =
      '$DOMAIN/v1/packagecategory/packagescategoriesforstore';
  static const SUBSCRIPTION_API = '$DOMAIN/v1/subscription/subscription';
  static const CAN_MAKE_ORDER_API = '$DOMAIN/v1/subscription/cancreateorder';
  static const RENEW_SUBSCRIPTION_API = BASE_API;
  static const EXTEND_SUBSCRIPTION_API =
      '$DOMAIN/v1/subscription/extrasubscriptionforday';

  static const UPDATE_BRANCH_API = '$DOMAIN/v1/StoreOwnerBranch/branch';
  static const CREATE_BRANCH_API = '$DOMAIN/v1/StoreOwnerBranch/branch';
  static const CREATE_BRANCH_LIST_API =
      '$DOMAIN/v1/StoreOwnerBranch/multiplebranches';
  static const NEW_ORDER_API = '$DOMAIN/v1/order/create';
  static const RECYCLE_ORDER_API = '$DOMAIN/v1/order/recyclingorcancelorder';
  static const NEW_ORDER_API_LINK = '$DOMAIN/v1/order/createsuborder';
  static const ORDER_NONSUB_API_LINK = '$DOMAIN/v1/order/ordernonsubbyowner';
  static const OWNER_ORDERS_API = '$DOMAIN/v1/order/storeorders';
  static const OWNER_HIDDEN_ORDERS_API =
      '$DOMAIN/v1/order/getordershiddenduetoexceedingdeliverytime';
  static const FILTER_OWNER_ORDERS_API = '$DOMAIN/v1/order/filterorders';
  static const FILTER_OWNER_CASH_ORDERS_API =
      '$DOMAIN/v1/order/notansweredcashordersbystore';
  static const DELETE_ORDER = '$DOMAIN/v1/order/ordercancel';
  static const DELETE_BRANCH_API = '$DOMAIN/v1/StoreOwnerBranch/deletebranch';
  static const ACCOUNT_STATUS =
      '$DOMAIN/v1/account/profilecompleteaccountstatus';
  static const DELETE_USER = '$DOMAIN/v1/userstatus/userstatus';
  static const GET_MY_NOTIFICATION =
      '$DOMAIN/v1/notificationlocal/notificationsLocal';
  static const GET_UPDATES =
      '$DOMAIN/v1/notificationfromadmin/notificationsfromadminforstore';
  static const DELETE_MY_NOTIFICATION =
      '$DOMAIN/v1/notificationlocal/notificationLocal';
  static const GET_SUBSCRIPTION_BALANCE =
      '$DOMAIN/v1/subscription/packagebalance';
  static const GET_NEW_SUBSCRIPTION_BALANCE =
      '$DOMAIN/v1/subscription/currentstoresubscriptionbalance';
  static const GET_SUBSCRIPTIONS_FINANCE =
      '$DOMAIN/v1/subscription/subscriptionswithpayment';
  static const RATING_CAPTAIN = '$DOMAIN/v1/rating/ratingbystore';
  static const COMPANY_API = '$DOMAIN/v1/company/companyinfoforuser';
  static const CAPTAIN_OFFERS = '$DOMAIN/v1/captainoffer/captainoffers';
  static const CREATE_CAPTAIN_OFFERS =
      '$DOMAIN/v1/subscription/subscriptioncaptainoffer/create';
  static const GET_CHAT_ROOMS_API =
      '$DOMAIN/v1/orderchatroom/orderchatroomsforstorebeforeorderaccepted';
  static const GET_ONGOING_CHAT_ORDER =
      '$DOMAIN/v1/orderchatroom/ongoingorderschatroomsforstore';
  static const CONFIRM_CAPTAIN_LOCATION_API =
      '$DOMAIN/v1/order/orderupdatecaptainarrived';
  static const GET_STORE_PAYMENTS = '$DOMAIN/v1/storepayment/storepayment';
  static const PAYMENTS_BY_STORE = '$DOMAIN/v1/epayment/epaymentbystore';
  static const UPDATE_ORDER_API = '$DOMAIN/v1/order/orderupdate';
  static const UPDATE_ORDER_CASH_FINANCE =
      '$DOMAIN/v1/order/confirmcashpaymentbystore';
  static const HIDE_ORDER_API = '$DOMAIN/v1/order/updateordertohidden';

  /*----------------------------bidorders-----------------------------*/
  static const GET_SUPPLIER_CATEGORY =
      '$DOMAIN/v1/suppliercategory/activesuppliercategoriesforstore';

  static const GET_BID_ORDER = '$DOMAIN/v1/order/filterbidorders';
  static const ADD_BID_ORDER = '$DOMAIN/v1/order/bidorder';
  static const BID_ORDER_DETAILS = '$DOMAIN/v1/order/storebidorder/';

  static const GET_ORDER_OFFERS =
      '$DOMAIN/v1/priceoffer/priceoffersbybidorderidforstore/';
  static const UPDATE_OFFER_STATE = '$DOMAIN/v1/priceoffer/priceofferstatus';
  static const CANCEL_BID_ORDER = '$DOMAIN/v1/order/bidordercancel/';
  static const GEO_DISTANCE = '$DOMAIN/v1/geodistance/geodistance';
  static const GEO_DISTANCE_WITH_DELIVERY_COST =
      '$DOMAIN/v1/geodistance/geodistanceandcostdelivered';
}
