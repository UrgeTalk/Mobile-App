
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/common/widgets/bottom_nav.dart';
import 'package:urge/features/auth/services/auth_service.dart';

class AuthController extends GetxController with BaseController {

    final AuthService _authService = AuthService();

  var isLoading = false.obs;
  var isSuccess = false.obs;
  final introdata = GetStorage();

  void login({required String email, required String password}) {
    isLoading(true);
    _authService.login(email, password).then((value) {
      introdata.write('token', value['data']['token']);
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

  
}