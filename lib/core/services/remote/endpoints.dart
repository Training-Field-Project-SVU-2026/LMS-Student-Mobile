
class EndPoint {

  static String localUrl = "http://lcoalhost/api/";
  static String remoteUrl = "https://lmsbackend-production-c2ea.up.railway.app/api";

  static String baseUrl = remoteUrl;  
  
    // auth 
  static String login = "/login";
  static String register = "/register/student/";  // 
  static String logout = "auth/logout";
  static String forgotPassword = "auth/forgot-password";


  static String getUserDataEndPoint(String id) {
    return "user/get-user/$id";
  }

}

class ApiKey {
  static String message = "message";
  static String firstName = "first_name";
  static String lastName = "last_name";
  static String email = "email";
  static String password = "password";

  static String role = "role";
  static String slug = "slug";
  static String isActive = "is_active";
  static String isVerified = "is_verified";

  static String student = "student";
  static String accessToken = "access";
  static String refreshToken = "refresh";
  static String user = "user";
  // static String student = "student";
  // static String student = "student";
  // static String student = "student";
}