import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:urge/common/helpers/dialog_box.dart';
import 'package:urge/common/helpers/utils.dart';
import 'package:urge/common/network/base_client.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/common/widgets/bottom_nav.dart';
import 'package:urge/features/auth/views/login.dart';
import 'package:urge/features/profile/services/profile_service.dart';
import 'package:urge/features/profile/model/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:urge/features/profile/views/profile.dart';
import 'dart:io';
import 'dart:convert';

import '../../../common/helpers/get_storage.dart';



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
    isLoading(true);
    _profileService.getProfile().then((value) {
      isLoading(true);
      if (value['message'] == "success") {
        isLoading(false);
        _profileModel = ProfileModel.fromMap(value['data']);
        print('Hey');
        print(_profileModel.fullName);
        print(_profileModel.isMember);
        isLoading(false);
        update(['Profile']);
      }
    }).catchError((e) {
      handleError(e);
      isLoading(false);
    });
  }
  void editProfile(
      String firstName,
      String lastName,
      File? image
      ){
    //isLoading(true);
    _profileService.editProfile(firstName, lastName, image).then((value){
      if(value['status'] == 200){
        isLoading(false);
        profileUpdateSuccessful();
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
  }

  void submitRequest(){
    isLoading(true);
    _profileService.speakerRequest().then((value){
      if(value['message']== "Speaker Request already submitted"){
        isLoading(false);
        showSnackBar(content: "Request Submitted");
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
  }



    void logOut() async {
    Get.offAll(() => const Login());
    introdata.remove('access');
  }

  void uploadImage(File image) async {
    var userId = LocalStorage.getUserId();
    isLoading(true);
    var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
    // get file length
    var length = await image.length();
    // string to uri
    var uri = Uri.parse("$url/editProfile");
    print(uri.toString());

    // create multipart request
    var request = http.MultipartRequest("POST", uri);
    var token = introdata.read('access');
    request.headers['Authorization'] = 'Bearer $token';
    print(request.headers);

    print('hello');

    // multipart that takes file.. here this "image_file" is a key of the API request
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: path.basename(image.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        isLoading(false);
      });
    }).catchError((e) {
      handleError(e);
      print(e);
      isLoading(false);
    });
  }

}
