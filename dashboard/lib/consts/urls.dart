// Developing Domain ===> 'http://138.197.186.138/';

class Urls {
  /*--------BASES-------------------*/
  static const String DOMAIN = 'http://134.209.241.49';
  static const String BASE_API = DOMAIN + '';
  static const String VERSION = '/v1';
  static const String VERSION_ADMIN = '/v1/admin';
  static const String BASE_API_STORE = DOMAIN + VERSION + '/store';
  static const String BASE_API_CATEGORY = DOMAIN + VERSION_ADMIN + '/packagecategory';
  static const String BASE_API_PACKAGE_ADMIN = DOMAIN + VERSION_ADMIN + '/package';
  static const String BASE_API_PACKAGE = DOMAIN + VERSION + '/package';

  /*--------Auth-------------------*/
  static const String IMAGES_ROOT = DOMAIN + '/upload/';
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
  static const GET_REPORT = BASE_API + '/report';

  /*--------Notification-------------------*/
  static const NEEDFORSUPPORT_ANYNAMOUS = BASE_API + '/anonymouschat';
  static const NOTIFICATIONTOADMIN_API = BASE_API + '/notificationtoadmin';
  static const NOTIFICATIONNEWCHAT_ANYN_API =
      BASE_API + '/notificationnewchatanonymous';
  static const NOTIFICATION_API = BASE_API + '/notificationtoken';
  static const NOTIFICATIONNEWCHAT_API =
      BASE_API + '/notificationnewchatbyuserid';
  static const NEEDFORSUPPORT = BASE_API + '/updateneedsupport';

  /*--------Store-------------------*/
  static const GET_STORES = BASE_API_STORE + '/storeownersprofilesbystatusforadmin/';
  static const GET_STORE_PROFILE = BASE_API_STORE + '/storeownersprofilesbyidforadmin/';
  static const ACTIVATE_STORE = BASE_API_STORE + '/storeownerprofilestatus';
  static const UPDATE_STORE_INFO = BASE_API_STORE + '/storeownerprofilebyadmin';

  /*------------------Package Category's ----------------*/
  static const GET_PACKAGE_CATEGORY = BASE_API_CATEGORY + '/categories';
  static const CREATE_PACKAGE_CATEGORY = BASE_API_CATEGORY + '/category';

  /*-----------------------Package--------------------------------*/
  static const GET_PACKAGE_BY_CATEGORY = BASE_API_PACKAGE_ADMIN + '/packagesbycategoryid/';
  static const CREATE_PACKAGE = BASE_API_PACKAGE_ADMIN + '/package';
  static const ACTIVE_PACKAGE = BASE_API_PACKAGE_ADMIN + '/packagestatus';

}
