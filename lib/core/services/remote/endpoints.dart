class EndPoint {
  static String localUrl = "http://192.168.1.10:8000/api";
  static String remoteUrl =
      "https://lmsbackend-production-c2ea.up.railway.app/api";

  static String baseUrl = remoteUrl;

  // auth
  static String login = "/auth/login/"; // done
  static String register = "/auth/register/"; // done
  static String changePassword = "/auth/change-password/"; // done
  static String logout = "/auth/logout/"; // done
  static String forgotPassword = "/auth/forgot-password/"; // done
  static String resendOtp = "/auth/resend-otp/"; // done
  static String resetPassword = "/auth/reset-password/"; // done
  static String refreshToken = "/auth/token/refresh/";
  static String verifyEmail = "/auth/verify-email/"; // done
  static String checkToken = "/auth/check-token/";

  // courses
  static String allCourses = "/courses/all/";
  static String courseBySlug = "/courses/";

  // packages
  static String allPackages = "/packages/all/";

  // student
  static String studentProfile(String slug) => '/students/$slug/';
  static String updateProfile(String slug) => '/students/$slug/';
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
  static String oldPassword = "old_password";
  static String newPassword = "new_password";
  static String image = "image";
}
