import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final introdata = GetStorage();

  void init() {
    introdata.writeIfNull("display", false);
    introdata.writeIfNull("loggedinbefore", false);
    introdata.write("token", '');
    introdata.write("id", '');
  }

  static getToken() {
    return GetStorage().read("token");
  }

  static getUserId() {
    return GetStorage().read("id");
  }
}
