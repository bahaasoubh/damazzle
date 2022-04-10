
class ApiURLs {

  static const String BASE_URL = "https://phplaravel-718120-2386003.cloudwaysapps.com/";

  static const String BASICURL = BASE_URL+"api/v1";

  // Auth URLs
  static const String LoginUSER = BASICURL + "/auth/admin-login";
  static const String UpdateUser = BASICURL + "/auth/update";
  static const String LogoutUser = BASICURL + "/auth/logout";
  static const String RefreshToken = BASICURL + "/auth/refresh";
  static const String ME = BASICURL + "/me";



}
