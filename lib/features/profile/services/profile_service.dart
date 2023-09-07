import 'dart:convert';
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

  // Future<dynamic> editProfile(String firstName, String lastName, File? image) async {
  //   try {
  //     return await baseClient.post(url, '/editProfile', {
  //       "first_name": firstName,
  //       "last_name": lastName
  //     });
  //   }catch (error) {
  //   return Future.error(error);
  //   }
  // }

    Future<dynamic> editProfile(String firstName, String lastName, File? image) async {
      try {
        final request = http.MultipartRequest('POST', Uri.parse('$url/editProfile'));
        // Add the authorization header with the token
        var token = introdata.read('access');
        request.headers['Authorization'] = 'Bearer $token';

        request.fields['first_name'] = firstName;
        request.fields['last_name'] = lastName;

        if (image != null) {
          final file = await http.MultipartFile.fromPath('profile_picture', image.path);
          request.files.add(file);
        }

        final response = await request.send();
        final responseString = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(responseString);

        return jsonResponse;
      } catch (error) {
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