import 'package:get/get.dart';
import 'package:urge/common/helpers/utils.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/features/home/model/saved_items_model.dart';
import 'package:urge/features/home/services/home_services.dart';
import 'package:urge/features/home/model/home_model.dart';
import 'package:urge/features/home/views/home.dart';
import 'package:http/http.dart' as http;


class AnonymousController extends GetxController with BaseController {
  final HomeService _homeService = HomeService();
  var isLoading = false.obs;
  var isListLoading = false.obs;
  var errorMessage = ''.obs;
  var trendingVideos = <HomeModel>[].obs;
  var featuredVideos = <HomeModel>[].obs;
  var lastestVideos = <HomeModel>[].obs;
  var recommendedVideos = <HomeModel>[].obs;
  var emptyMessage = 'No record available'.obs;
  List<SavedItemsModel> savedItems = [];
  var savedVideos = <HomeModel>[].obs;
  var newSavedVideos = <HomeModel>[].obs;
  var featuredVideoItems = <HomeModel>[].obs;
  var recommendedVideoItems = <HomeModel>[].obs;
  var trendingVideoItems = <HomeModel>[].obs;
  var latestVideoItems = <HomeModel>[].obs;
  var newFeaturedVideos = <HomeModel>[].obs;
  var newRecommendedVideos = <HomeModel>[].obs;
  var newTrendingVideos = <HomeModel>[].obs;
  var newLatestVideos = <HomeModel>[].obs;

  void getAllAnonymousVideos(){
    isListLoading(true);
    _homeService.getAllAnonymousVideos().then((value){
      print(value['data']);
      try {
        if(value['message'] == "Ok"){
          var featuredList =
          List<HomeModel>.from((value['data']['Featured']).map((x) => HomeModel.fromMap(x)));
          featuredVideoItems.value = featuredList;
          var recommendedList =
          List<HomeModel>.from((value['data']['Recommended']).map((x) => HomeModel.fromMap(x)));
          recommendedVideoItems.value = recommendedList;
          var trendingList =
          List<HomeModel>.from((value['data']['Trending']).map((x) => HomeModel.fromMap(x)));
          trendingVideoItems.value = trendingList;
          var latestList =
          List<HomeModel>.from((value['data']['Latest']).map((x) => HomeModel.fromMap(x)));
          latestVideoItems.value = latestList;
          print('Here are some videos');
          isListLoading(false);
        }
      }catch (error) {
        print(error);
      }
    }).catchError((error) {
      isListLoading(false);
      handleError(error);
    });
  }


}