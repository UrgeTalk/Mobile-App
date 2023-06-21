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



}
