import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/helpers/utils.dart';
import 'package:urge/common/network/dialog_help.dart';
import 'package:get_storage/get_storage.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/common/widgets/bottom_nav.dart';
import 'package:urge/features/auth/services/auth_service.dart';
import 'package:urge/features/auth/views/login.dart';
import 'package:urge/features/auth/views/otp_verification.dart';
import 'package:urge/common/helpers/dialog_box.dart';
import 'package:urge/features/auth/views/password_reset_otp.dart';

class AuthController extends GetxController with BaseController {
  final AuthService _authService = AuthService();

  var isLoading = false.obs;
  var isSuccess = false.obs;
  final introdata = GetStorage();

  void login({required String email, required String password}) {
    isLoading(true);
    _authService.login(email, password).then((value) {
      introdata.write('access', value['data']['access']);
      introdata.write('id', value['data']['user']['id']);
      if (value['message'] == "Login Successful") {
        Get.off(() => const BottomBar());
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
  }

  void register(
      {required String firstName,
      required String lastName,
      required String emailAddress,
      required String password}) {
    isLoading(true);
    _authService
        .signUp(firstName, lastName, emailAddress, password)
        .then((value) {
      if (value['status'] == 200) {
        Get.to(() => OTPVerification(emailAddress: emailAddress));
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
  }

  void verifyEmail(String email, String otpCode) {
    isLoading(true);
    _authService.verifyEmail(email, otpCode).then((value) {
      isLoading(true);
      if (value['status'] == 200) {
        isLoading(false);
        Get.to(() => const Login());
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
  }

  void forgotPassword({required String email}) {
    isLoading(true);
    _authService.forgotPassword(email).then((value) {
      if (value['message'] == "OTP Sent") {
        isLoading(false);
        Get.to(() => PasswordResetOtpScreen(emailAddress: email));
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
  }

  void resetPassword(String email, String password, String otpCode) {
    isLoading(true);
    _authService.resetPassword(email, password, otpCode).then((value) {
      isLoading(false);
      if (value['status'] == "Password Changed Successfully!") {
        isLoading(false);
        Get.to(() => const Login());
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
  }

}
