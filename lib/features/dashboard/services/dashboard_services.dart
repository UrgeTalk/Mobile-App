import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:urge/common/network/base_client.dart';
import 'package:urge/common/network/base_controller.dart';

class DashboardService with BaseController {

    final introdata = GetStorage();
  BaseClient baseClient = BaseClient();

    Future<dynamic> getMasterClass() async {
    return await baseClient.get(
      url,
        '/myMasterclass',
    );
  }

  Future<dynamic> speakerRequest() async {
      return await baseClient.post(
          url,
          '/speakerRequest', {});

  }

  Future<dynamic> applicationStatus() async {
      return await baseClient.get(
      url, '/getSpeakerApplicationProgress');
  }

}