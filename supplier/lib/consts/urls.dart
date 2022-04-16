class Urls {
  static const String DOMAIN = 'http://134.209.241.49';
  static const String BASE_API = DOMAIN + '/v1/supplier';
  static const String BASE_API_USER = DOMAIN + '/v1/user';
  static const String BASE_API_CATEGORY = DOMAIN + '/v1/suppliercategory';

  static const String IMAGES_ROOT = DOMAIN + '/upload/';
  static const UPLOAD_API = DOMAIN + '/uploadfile';


  static const SIGN_UP_API = BASE_API + '/registersupplier';
  static const CREATE_TOKEN_API = DOMAIN + '/login_check';
  static const VERIFY_CODE_API = BASE_API + '/verifycode';
  static const CHECK_USER_VERIFIED_API = BASE_API + '/checkverificationstatus';
  static const RESEND_CODE_API = BASE_API + '/resendnewverificationcode';
  static const RESET_PASSWORD = BASE_API + '/resetpasswordorder';
  static const VERIFY_RESET_PASSWORD_CODE =
      BASE_API + '/verifyresetpasswordcode';
  static const UPDATE_PASSWORD = BASE_API + '/updatepassword';
  /*-------------------------------------------*/
  static const OWNER_PROFILE_API = BASE_API + '/supplierprofile';


  static const REPORT_API = BASE_API + '/report';
  /* ------------------notifications------------------- */
   static const NOTIFICATION_API = BASE_API + '/notificationtoken';
   static const NOTIFICATIONNEWCHAT_API =
      BASE_API + '/notificationnewchatbyuserid';
  static const NEEDFORSUPPORT = BASE_API + '/updateneedsupport';
  static const NEEDFORSUPPORT_ANYNAMOUS = BASE_API + '/anonymouschat';
  static const NOTIFICATIONTOADMIN_API = BASE_API + '/notificationtoadmin';
  static const NOTIFICATIONNEWCHAT_ANYN_API =
      BASE_API + '/notificationnewchatanonymous';

  static const ACCOUNT_STATUS =
      DOMAIN + '/v1/account/profilecompleteaccountstatus';
  static const CHECK_USER_ROLE = BASE_API_USER + '/checkUserType';
  static const COMPANY_API = DOMAIN + '/v1/company/companyinfoforuser';
  static const GET_CATEGORIES = BASE_API_CATEGORY + '/activesuppliercategories';


}
