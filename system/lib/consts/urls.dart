// Developing Domain ===> 'http://134.209.241.49/'
// Named Domain ===> 'https://mandoob.password-please.com'
// Named Domain ===> 'https://api.al-mandob.com'

class Urls {
  static const String DOMAIN = 'http://134.209.241.49';
  static const String API_VERSION = '/v1/main';
  static const String BASE_API_VERSION = DOMAIN + API_VERSION;
  static const String BASE_API_VERSION_COMMANDER = DOMAIN + '/v1/datacommander';
  static const String BASE_API = DOMAIN + '';
  static const String IMAGES_ROOT = DOMAIN + '/upload/';
  static const UPLOAD_API = BASE_API + '/uploadfile';
  static const SIGN_UP_API = BASE_API + '/createAdmin';
  static const CREATE_TOKEN_API = BASE_API + '/login_check';
  static const VERIFY_CODE_API = BASE_API + '/verifycode';
  static const CHECK_USER_VERIFIED_API = BASE_API + '/checkverificationstatus';
  static const RESEND_CODE_API = BASE_API + '/resendnewverificationcode';
  static const RESET_PASSWORD = BASE_API + '/resetpasswordorder';
  static const VERIFY_RESET_PASSWORD_CODE =
      BASE_API + '/verifyresetpasswordcode';
  static const UPDATE_PASSWORD = BASE_API + '/updatepassword';
  static const NOTIFICATION_API = BASE_API + '/notificationtoken';
  static const NOTIFICATIONNEWCHAT_API =
      BASE_API + '/notificationnewchatbyuserid';
  static const NEEDFORSUPPORT_ANYNAMOUS = BASE_API + '/anonymouschat';
  static const NOTIFICATIONNEWCHAT_ANYN_API =
      BASE_API + '/notificationnewchatanonymous';
  static const CHECK_USER_ROLE = BASE_API + '/checkUserType';

  static const CHECK_API_HEALTH = BASE_API_VERSION + '/checkbackendhealth';
  static const GET_USERS = BASE_API_VERSION + '/filterusersbysuperadmin';
  static const UPDATE_USER_PASSWORD = BASE_API_VERSION + '/userpasswordbysuperadmin';
  static const UPDATE_ORDER_STATUS = BASE_API_VERSION + '/updateorderstatebysuperadmin';
  static const REST_DATA_API = BASE_API_VERSION_COMMANDER + '/renewdatabasefromscratch';
}
