import 'package:get/get.dart';
import 'package:urge/common/helpers/dialog_box.dart';
import 'package:urge/common/helpers/utils.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/features/dashboard/model/application_status_model.dart';
import 'package:urge/features/dashboard/services/dashboard_services.dart';
import 'package:urge/features/dashboard/model/master_class_model.dart';
import 'package:flutter/foundation.dart';

class DashboardController extends GetxController with BaseController {
  final DashboardService _dashboardService = DashboardService();

  var isLoading = false.obs;
  var isListLoading = false.obs;
  var errorMessage = ''.obs;
  var masterClassList = <MasterClassModel>[].obs;
  var newMasterClassList = <MasterClassModel>[].obs;

  ApplicationStatus _applicationStatus = ApplicationStatus();
  ApplicationStatus get applicationStatus => _applicationStatus;

  void getMasterClass() {
    isListLoading(true);
    _dashboardService.getMasterClass().then((value) {
      print(value['data']);
      try {
        if (value['message'] == "success") {
          var trans = List<MasterClassModel>.from(
              (value['data']).map((x) => MasterClassModel.fromMap(x)));
          masterClassList.value = trans;
          isListLoading(false);
        }
      } catch (error) {
        debugPrint(error.toString());
      }
    }).catchError((error) {
      isListLoading(false);
      handleError(error);
    });
  }
  void speakerRequest() {
    isLoading(true);
    _dashboardService.speakerRequest().then((value){
      if(value['status'] == 200){
        showSnackBar(content: "Speaker Request Submitted");
        isLoading(false);
      } else {
        showSnackBar(content: "Could not process application");
        isLoading(false);
      }
    }).catchError((error) {
      isListLoading(false);
      handleError(error);
    });
  }

  void getApplicationStatus() {
    isLoading(true);
    _dashboardService.applicationStatus().then((value){
      if(value['status'] == 200){
        isLoading(false);
        _applicationStatus = ApplicationStatus.fromMap(value['data']);
           print(_applicationStatus.data?.approved);
        }

    }).catchError((error) {
      isListLoading(false);
      print(error);
      handleError(error);
    });
  }
}
