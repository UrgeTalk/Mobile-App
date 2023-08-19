import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:urge/common/helpers/dialog_box.dart';
import 'package:urge/common/helpers/utils.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/common/widgets/bottom_nav.dart';
import 'package:urge/features/auth/models/login_model.dart';
import 'package:urge/features/auth/services/auth_service.dart';
import 'package:urge/features/auth/views/login.dart';
import 'package:urge/features/auth/views/otp_verification.dart';
import 'package:urge/features/auth/views/password_reset_otp.dart';

import '../../profile/model/profile_model.dart';
import '../../profile/services/profile_service.dart';

class AuthController extends GetxController with BaseController {
  final AuthService _authService = AuthService();
  final ProfileService _profileService = ProfileService();

  var isLoading = false.obs;
  var isSuccess = false.obs;
  final introdata = GetStorage();

  ProfileModel _profileModel = ProfileModel();
  ProfileModel get profileModel => _profileModel;

  LoginModel _loginModel = LoginModel();
  LoginModel get loginModel => _loginModel;

  bool isSpeaker = false;
  bool isMember = false;


  void login({required String email, required String password}) {
    isLoading(true);
    _authService.login(email, password).then((value) {
      introdata.write('access', value['data']['access']);
      introdata.write('id', value['data']['user']['id']);
      if (value['message'] == "Login Successful") {
        print('Hiii');
        print(value['data']['access']);
        print('hello');
        isLoading(false);
        Get.offAll(() => const BottomBar());
      } else if(value['message'] == "Incorrect Password!"){
        showSnackBar(content: "Incorrect Login credentials");
      } else {

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
        //Get.to(() => const Login());
        accountCreatedSuccessful();
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

  void resendOTP({required String email}) {
    isLoading(true);
    _authService.resendOTP(email).then((value){
      if(value['message'] == ""){
        isLoading(false);
        showSnackBar(content: "OTP Sent");
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
      if (value['message'] == "Password Changed Successfully!") {
        isLoading(false);
        //passwordResetSuccessful();
        Get.to(() => const Login());
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
  }

  void changePassword(String currentPassword, String newPassword) {
    isLoading(true);
    _authService.changePassword(currentPassword, newPassword).then((value) {
      isLoading(false);
      if (value['message'] == "Password changed successfully!") {
        isLoading(false);
        passwordChangeSuccessful();
        //Get.to(() => const Login());
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
  }

  getProfile() {
    _profileService.getProfile().then((value) {
      if (value['message'] == "success") {
        isLoading(false);
        _profileModel = ProfileModel.fromMap(value['data']);
        print('Hey');
        print(_profileModel.fullName);
        isLoading(false);
        update(['Profile']);
      }
    }).catchError((e) {
      handleError(e);
      isLoading(false);
    });
  }


}
