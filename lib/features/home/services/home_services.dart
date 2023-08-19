import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:urge/common/network/base_client.dart';
import 'package:urge/common/network/base_controller.dart';

class HomeService with BaseController {
  final introdata = GetStorage();
  BaseClient baseClient = BaseClient();

  Future<dynamic> getAllTrendingVideos() async {
    return await baseClient.get(
      url,
      '/getTrendingVideos?page=1',
    );
  }

  Future<dynamic> getAllVideos() async {
    return await baseClient.get(
      url,
      '/home',
    );
  }

  Future<dynamic> getAllAnonymousVideos() async {
    return await baseClient.get2(
      url,
      '/anon/home',
    );
  }

  Future<dynamic> getLatestVideos() async {
    return await baseClient.get(
      url,
      '/getLatestVideos?page=1',
    );
  }

  Future<dynamic> getFeaturedVideos() async {
    return await baseClient.get(
      url,
      '/getFeaturedVideos',
    );
  }

  Future<dynamic> getRecommendedVideos() async {
    return await baseClient.get(
      url,
      '/getRecommendedVideos',
    );
  }

  Future<dynamic> getSavedItems() async {
    return await baseClient.get(
      url,
      '/getSavedItems',
    );
  }

  Future<dynamic> saveVideo(int? id) async {
    try {
      var map = <String, dynamic>{};
      map['type'] = "master class";
      map['id'] = id;
      return await baseClient.post(url, '/saveItem', map);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<dynamic> likeVideo(int? id) async {
    try {
      var map = <String, dynamic>{};
      map['masterclass_id'] = id;
      return await baseClient.post(url, '/like', map);
    } catch (error) {
      return Future.error(error);
    }
  }
}
