class ApiConstants{

  static final String BaseURL = "http://43.231.127.173:3000/homelabz/api/v1/";

  static final String LOGIN_API = BaseURL+"user/login";
  static final String VERIFY_OTP_API = BaseURL+"user/verifyOTP";
  static final String SIGN_UP_API = BaseURL+"user/signInMobile";
  static final String UPDATE_USER_DETAILS = BaseURL+"user/update";
  static final String GET_ALL_LABS = BaseURL+"lab/findAll";
  static final String BOOKING_LIST_BY_CRITERIA = BaseURL+"booking/findAllByCriteria";
  static final String BOOK_APPOINTMENT = BaseURL+"booking/create";
}

//{"oAuthResponse":{"access_token":"246c45ae-f57c-40a6-95f8-cd8d5d761adf",
//"token_type":"bearer","refresh_token":"9c0391f3-bcc1-4920-a436-a02a9fbbfe04","expires_in":996820,"scope":"read write"},
//"userModel":{"id":32,"name":"Patient4","mobileNumber":"1111111110"}}