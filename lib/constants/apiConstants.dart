class ApiConstants{

  //dev
  static final String BaseURL = "http://43.231.127.173:3000/homelabz/api/v1/";

  //prod
  // static final String BaseURL = "https://homelabz.com/homelabz/api/v1/";

  static final String LOGIN_API = BaseURL+"user/login";
  static final String VERIFY_OTP_API = BaseURL+"user/verifyOTP";
  static final String GENERATE_OTP_API = BaseURL+"user/generateOTP";
  static final String SIGN_UP_API = BaseURL+"user/signInMobile";
  static final String UPDATE_USER_DETAILS = BaseURL+"user/update";
  static final String GET_ALL_LABS = BaseURL+"lab/findAll";
  static final String GET_ALL_DOCTOR = BaseURL+"user/findAllDoctor";
  static final String BOOKING_LIST_BY_CRITERIA = BaseURL+"booking/findAllByCriteria";
  static final String BOOK_APPOINTMENT = BaseURL+"booking/create";
  static final String PRE_SIGNED_URL = BaseURL+"document/upload";
  static final String NEW_USER = BaseURL+"user/isNewUser";
  static final String SIGN_IN_API = BaseURL+"user/signIn";
  static final String GET_PAYMENT_INFO = BaseURL+"payment/getPaymentInfo";
  static final String SUBMIT_PAYMENT_INFO = BaseURL+"payment/submitPayment";
  static final String CALL_API = BaseURL+"globalParam/findAllRequired";
  static final String GET_USER_DETAILS = BaseURL+"user/findById/";
  static final String GET_DOWNLOAD_URL = BaseURL+"document/download";
  static final String LOGOUT = BaseURL+"user/logout";
  static final String GET_BOOKING_DETAILS = BaseURL+"booking/findById/";//{id}
  static final String GET_NOTIFICATION_LIST = BaseURL+"notification/findAll?userId=";
  static final String DOWNLOAD_ALL_DOCS = BaseURL+"document/findAll?bookingId=";
  static final String GET_ALL_FOLDERS = BaseURL+"vault/findAll?userId=";
  static final String DELETE_VAULT_FOLDER = BaseURL+"vault/delete";// id
  static final String CREATE_VAULT_FOLDER = BaseURL+"vault/create";//
//{"documentList":[{"category":"VAULT","name":"app-icon 1024_1638253522175.png",
// "path":"713/VAULT/app-icon 1024_1638253522175.png",
// "user":{"id":713}}],"id":null,"name":"Labs","noOfFiles":1,"userId":713}

  static final String UPDATE_VAULT_FOLDERS = BaseURL+"vault/update";//
//{"documentList":[{"category":"VAULT","name":"app-icon 1024_1638253522175.png",
// "path":"713/VAULT/app-icon 1024_1638253522175.png",
// "user":{"id":713}}],"id":65,"name":"Labs","noOfFiles":1,"userId":713}

  static final String FIND_BY_VAULT_ID = BaseURL+"vault/findAllByVaultId?vaultId=";
  static final String DELETE_FILE = BaseURL+"vault/deleteFile";

}