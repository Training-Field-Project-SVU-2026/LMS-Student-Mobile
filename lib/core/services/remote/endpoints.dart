class EndPoint {
  static String localUrl = "http://192.168.1.10:8000/api";
  static String remoteUrl =
      "https://lmsbackend-production-c2ea.up.railway.app/api";

  static String baseUrl = localUrl;

  // auth
  static String login = "/auth/login/"; // done
  static String register = "/auth/register/"; // done
  static String changePassword = "/auth/change-password/";
  static String logout = "/auth/logout/"; // 
  static String forgotPassword = "/auth/forgot-password/"; // done
  static String resendOtp = "/auth/resend-otp/"; // done
  static String resetPassword = "/auth/reset-password/"; // done
  static String refreshToken = "/auth/token/refresh/";
  static String verifyEmail = "/auth/verify-email/";
  static String checkToken = "/auth/check-token/";

  // courses
  static String allCourses = "/courses/all/";

  // packages
  static String allPackages = "/packages/all/";
  
  // student profile 
  static String updateProfile = "";
}

class ApiKey {
  static String message = "message";
  static String authorization = "Authorization";
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
  static String isLoggedIn = "is_logged_in";
}
