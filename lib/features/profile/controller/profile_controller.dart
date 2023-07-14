import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/features/auth/views/login.dart';
import 'package:urge/features/profile/services/profile_service.dart';
import 'package:urge/features/profile/model/profile_model.dart';

class ProfileController extends GetxController with BaseController {
  final ProfileService _profileService = ProfileService();

  final introdata = GetStorage();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  //var image = ImageModel().obs;
  // File? image;

  ProfileModel _profileModel = ProfileModel();
  ProfileModel get profileModel => _profileModel;

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

    void logOut() async {
    Get.offAll(() => const Login());
    introdata.remove('access');
  }
}
