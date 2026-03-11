import 'package:flutter/material.dart';
import 'package:lms_student/features/auth/data/model/register_request_model.dart';
import 'package:lms_student/features/auth/data/model/login_request_model.dart';
import 'package:lms_student/features/auth/data/model/reset_password_request_model.dart';

mixin FormControllersMixin {
  // Shared between login and register
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Register
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Otp
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  // reset password
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  bool validateResetPasswordForm() {
  return resetPasswordFormKey.currentState?.validate() ?? false;
}

ResetPasswordRequestModel getResetPasswordRequest() {
  return ResetPasswordRequestModel(
    otp: otpController.text.trim(),
    newPassword: newPasswordController.text.trim(),
  );
}

void clearResetPasswordControllers() {
  otpController.clear();
  newPasswordController.clear();
  confirmNewPasswordController.clear();
}

  // Form Keys
  final registerFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  final forgetPasswordFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();

  //Register
  bool validateRegisterForm() {
    return registerFormKey.currentState?.validate() ?? false;
  }

  RegisterRequestModel getRegisterRequest() {
    return RegisterRequestModel(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  void clearRegisterControllers() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  // login
  bool validateLoginForm() {
    return loginFormKey.currentState?.validate() ?? false;
  }

  LoginRequestModel getLoginRequest() {
    return LoginRequestModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  void clearLoginControllers() {
    emailController.clear();
    passwordController.clear();
  }

  //verify email
  String getOtpCode() {
    return otpControllers.map((c) => c.text).join();
  }

  bool validateOtpForm() {
    return otpFormKey.currentState?.validate() ?? false;
  }

  void clearOtpControllers() {
    for (var controller in otpControllers) {
      controller.clear();
    }
  }

  // Dispose all
  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    confirmPasswordController.dispose();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    otpController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
  }
}
