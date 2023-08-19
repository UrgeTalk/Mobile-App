import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:urge/common/network/base_client.dart';
import 'package:urge/common/network/base_controller.dart';


class ProfileService with BaseController {
    final introdata = GetStorage();
  BaseClient baseClient = BaseClient();

  Future<dynamic> getProfile() async {
    try {
      return await baseClient.get(
        url,
        '/user',
      );
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<dynamic> editProfile(String firstName, String lastName) async {
    try {
      return await baseClient.post(url, '/editProfile', {
        "first_name": firstName,
        "last_name": lastName
      });
    }catch (error) {
    return Future.error(error);
    }
  }

    Future<dynamic> speakerRequest() async {
      try {
        return await baseClient.post(
          url,
          '/speakerRequest',
          ""

        );
      } catch (error) {
        return Future.error(error);
      }
    }



}