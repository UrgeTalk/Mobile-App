import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:urge/common/network/base_client.dart';
import 'package:urge/common/network/base_controller.dart';

class AuthService with BaseController {
  final introdata = GetStorage();
  BaseClient baseClient = BaseClient();

  String getToken() {
    String token = introdata.read("token");
    return token;
  }

    Map<String, String> get headers =>
      {
        "Content-Type": "application/json",
      };


  Future<dynamic> login(String email, String password) async {
    try {
      return await baseClient.post(url, '/login', {
        "email": email,
        "password": password,
      });
    } catch (error) {
      return Future.error(error);
    }
  }

    Future<dynamic> signUp(String firstName, String lastName, String emailAddress, String password) async {
    try {
      return await baseClient.post(url, '/register', {
        "email": emailAddress,
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
      });
    } catch (error) {
      return Future.error(error);
    }
  }

    Future<dynamic> verifyEmail(String email, String otpCode) async {
    try {
      return await baseClient.post(
          url,
          '/verify', {
        "email": email,
        "otp": otpCode,
      });
    } catch (error) {
      return Future.error(error);
    }
  }

    Future<dynamic> forgotPassword(String email) async {
    try {
      return await baseClient.post(url, '/forgotPassword', {
        "email": email,
      });
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<dynamic> resendOTP(String email) async {
    try {
      return await baseClient.post(url, '/resendOTP', {
        "email": email,
      });
    } catch (error) {
      return Future.error(error);
    }
  }

    Future<dynamic> resetPassword(String email, String password, String otpCode) async {
    try {
      return await baseClient.post(
          url,
          '/resetPassword', {
            "email": email,
            "password": password,
            "otp": otpCode,
      });
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<dynamic> changePassword(String currentPassword, String newPassword) async {
    try {
      return await baseClient.post(
          url,
          '/changePassword', {
        "new_password": currentPassword,
        "password": newPassword,
      });
    } catch (error) {
      return Future.error(error);
    }
  }



}
