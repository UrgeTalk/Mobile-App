import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:urge/common/network/base_client.dart';
import 'package:urge/common/network/base_controller.dart';

class HomeService with BaseController {

  final introdata = GetStorage();
  BaseClient baseClient = BaseClient();

    Future<dynamic> getAllVideos() async {
    return await baseClient.get(
      url,
        '/home',
    );
  }


}