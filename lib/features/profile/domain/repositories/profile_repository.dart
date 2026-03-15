import 'package:lms_student/features/profile/data/model/logout_request_model.dart';

abstract class ProfileRepository {
  
    Future<void> logout(LogoutRequestModel request);

}