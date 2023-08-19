import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final introdata = GetStorage();

  void init() {
    introdata.writeIfNull("display", false);
    introdata.writeIfNull("loggedinbefore", false);
    introdata.write("access", '');
    introdata.write("id", '');
    introdata.write("is_member", '');
    introdata.write("is_speaker", '');
  }

  static getToken() {
    return GetStorage().read("access");
  }

  static getUserId() {
    return GetStorage().read("id");
  }

  static deleteToken() {
    return GetStorage().remove("access");
  }

  static getMemberStatus() {
    return GetStorage().read("is_member");
  }

  static getSpeakerStatus(){
    return GetStorage().read("is_speaker");
  }

}
