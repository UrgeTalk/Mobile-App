import 'dart:convert';

import 'package:get/get.dart';
import 'package:urge/common/helpers/utils.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/features/home/model/saved_items_model.dart';
import 'package:urge/features/home/services/home_services.dart';
import 'package:urge/features/home/model/home_model.dart';
import 'package:urge/features/home/views/home.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController with BaseController {
  final HomeService _homeService = HomeService();
  bool isLoading2 = false;

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


  List<SavedEvents> latestVideos = [];
  bool isLoaded = false;

  void getAllVideos(){
   isListLoading(true);
   _homeService.getAllVideos().then((value){
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
         update(['Details']);

       }
     }catch (error) {
       print(error);
     }
   }).catchError((error) {
     isListLoading(false);
     handleError(error);
   });
  }

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
          update(['search']);
        }
      } catch (error) {
        print(error);
      }
    }).catchError((error) {
      isListLoading(false);
      handleError(error);
    });
  }

  void getSavedVideoItems() {
    isListLoading(true);
    _homeService.getSavedItems().then((value) {
      print(value['data']);
      try {
        if (value['message'] == "Ok") {
          var trans = List<HomeModel>.from(
              (value['data']['videos']).map((x) => HomeModel.fromMap(x)));
          savedVideos.value = trans;
          print('is this real?');
          print(savedVideos.length);
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

  void saveVideoItem(HomeModel model) {
    isLoading(true);
    _homeService.saveVideo(model.id).then((value){
      if(value['message'] == "success"){
        showSnackBar(content: "Video successfully saved!");
      }
    }).catchError((error) {
      isListLoading(false);
      handleError(error);
    });
  }

    void likeVideoItem(HomeModel model) {
    isLoading(true);
    _homeService.likeVideo(model.id).then((value){
      if(value['message'] == "MasterClass liked successfully"){
        showSnackBar(content: "Video successfully Liked!");
      }
    }).catchError((error) {
      isListLoading(false);
      handleError(error);
    });
  }
}
