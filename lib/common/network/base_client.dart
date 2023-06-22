import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:urge/common/network/app_exception.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/common/network/dialog_help.dart';
import 'package:urge/common/helpers/simple_log_printer.dart';
import 'package:urge/common/network/base_client.dart';


const String _authUrl = "http://16.171.33.78";
String get url => _authUrl;

class BaseClient {

    static const int TIME_OUT_DURATION = 180;
  final introdata = GetStorage();

  Map<String, String> headers = {
    "Content-Type": "application/json",
    };

  Map<String, String> authorization = {
    "Authorization": "Bearer Token",
  };


  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj, {String? access,List<File>? files}) async {
    var token = introdata.read('token');
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);

    if (token != null) {
      headers = {
        "Content-Type": "application/json",
        'authorization': token,
      };
      }
    try {
      if (kDebugMode) {
        getLogger().d(''' URL:: $uri,
        print:: ${json.encode(headers)},
         body:: ${json.encode(payloadObj)}''');
      }
      Response response;
      if(files != null){
        var request = http.MultipartRequest("POST", uri);
        request.fields.addAll(payloadObj);
        request.headers.addAll(headers);
        for (var element in files) {
          var contentType = lookupMimeType(element.path);
          request.files.add(await http.MultipartFile.fromPath(
            "files",
            element.path,
            filename: element.path.split('/').last,
            contentType: MediaType.parse(contentType!),
          ));
        }
        response = await request.send().then((value) => http.Response.fromStream(value));
      }else{
        response = await http.post(uri, body: payload, headers: headers).timeout(const Duration(seconds: TIME_OUT_DURATION));
      }

      if (kDebugMode) {
        getLogger()
            .d('''Received Response status code is : ${response.statusCode}, 
        response body ::  ${response.body} ''');
      }
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }

    
  }


    dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        return responseJson;
    //break;
      case 201:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        return responseJson;
    // break;
      case 400:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw BadRequestException(responseJson['message'] ?? 'An error occurred',
            response.request!.url.toString());
      case 401:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw BadRequestException(
            responseJson['detail'], response.request!.url.toString());
      case 403:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw UnAuthorizedException(
            responseJson['detail'], response.request!.url.toString());
      case 404:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw BadRequestException(responseJson['error'] ?? 'An error occurred',
            response.request!.url.toString());
      case 422:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw BadRequestException(responseJson['message'] ?? 'An error occurred',
            response.request!.url.toString());
      case 503:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw BadRequestException(responseJson['error'] ?? 'An error occurred',
            response.request!.url.toString());
      case 500:
      default:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw FetchDataException(responseJson['message'] ?? 'An error occurred',
            response.request!.url.toString());
    }
  }





}


