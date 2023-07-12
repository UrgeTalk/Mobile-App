import 'package:get/get.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/features/home/services/home_services.dart';
import 'package:urge/features/home/model/home_model.dart';
import 'package:urge/features/home/views/home.dart';

class HomeController extends GetxController with BaseController {
  final HomeService _homeService = HomeService();

  var isLoading = false.obs;
  var isListLoading = false.obs;
  var errorMessage = ''.obs;
  var videoList = <HomeModel>[].obs;
    final featuredVideos = <HomeModel>[].obs;
  final recommendedVideos = <HomeModel>[].obs;
  var emptyMessage = 'No record available'.obs;

  void getAllVideos() {
    isListLoading(true);
    _homeService.getAllVideos().then((value) {
      print(value['data']);
      print('Now');
      try {
        if (value['message'] == "Ok") {
          var trans = List<HomeModel>.from(
              (value['data']['Featured']).map((x) => HomeModel.fromMap(x)));
          videoList.value = trans;
          print('Here');
          print(videoList.length);
          isListLoading(false);
        }
      } catch (error) {
        print(error);
      }
    }).catchError((error) {
      isListLoading(false);
      handleError(error);
    });
  }
}
