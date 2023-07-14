import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:urge/common/network/base_client.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/features/events/model/event_model.dart';

class EventService with BaseController {
  final introdata = GetStorage();
  BaseClient baseClient = BaseClient();

  Future<dynamic> getAllEvents() async {
    return await baseClient.get(
      url,
      '/events',
    );
  }

  Future<dynamic> getRegisteredEvents() async {
    return await baseClient.get(
      url,
      '/getRegisteredEvents',
    );
  }

  Future<dynamic> saveEvent(int? id) async {
    try {
      var map = <String, dynamic>{};
      map['type'] = "event";
      map['id'] = id;
      return await baseClient.post(
          url, '/saveItem', map);
    } catch (error) {
      return Future.error(error);
    }
  }

    Future<dynamic> registerEvent(int? id) async {
    try {
      var map = <String, dynamic>{};
      map['event_id'] = id;
      return await baseClient.post(
          url, '/registerEvent', map);
    } catch (error) {
      return Future.error(error);
    }
  }
}
