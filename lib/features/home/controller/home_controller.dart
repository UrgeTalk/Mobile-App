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
  var trendingVideos = <HomeModel>[].obs;
  var featuredVideos = <HomeModel>[].obs;
  var lastestVideos = <HomeModel>[].obs;
  var recommendedVideos = <HomeModel>[].obs;
  var emptyMessage = 'No record available'.obs;

  void getAllTrendingVideos() {
    isListLoading(true);
    _homeService.getAllTrendingVideos().then((value) {
      print(value['data']);
      print('Now');
      try {
        if (value['message'] == "success") {
          var trans = List<HomeModel>.from(
              (value['data']).map((x) => HomeModel.fromMap(x)));
          trendingVideos.value = trans;
          print('Here');
          print(trendingVideos.length);
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

  void getLatestVideos() {
    isListLoading(true);
    _homeService.getLatestVideos().then((value) {
      print(value['data']);
      print('Now');
      try {
        if (value['message'] == "success") {
          var trans = List<HomeModel>.from(
              (value['data']).map((x) => HomeModel.fromMap(x)));
          lastestVideos.value = trans;
          print('Here');
          print(lastestVideos.length);
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

  void getFeaturedVideos() {
    isListLoading(true);
    _homeService.getFeaturedVideos().then((value) {
      print(value['data']);
      print('Now');
      try {
        if (value['message'] == "Ok") {
          var trans = List<HomeModel>.from(
              (value['data']).map((x) => HomeModel.fromMap(x)));
          featuredVideos.value = trans;
          print('Here');
          print(featuredVideos.length);
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

  void getRecommendedVideos() {
    isListLoading(true);
    _homeService.getRecommendedVideos().then((value) {
      print(value['data']);
      print('Now');
      try {
        if (value['message'] == "Ok") {
          var trans = List<HomeModel>.from(
              (value['data']).map((x) => HomeModel.fromMap(x)));
          recommendedVideos.value = trans;
          print('Here');
          print(recommendedVideos.length);
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
